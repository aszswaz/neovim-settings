#!/bin/bash

# error when referencing undefined variable
set -o nounset
# exit when command fails
set -o errexit

cd "$(dirname $0)"

export NVIM_SHARE="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
export CONFIG_PATH="$HOME/.config/nvim"
export PACKER_PATH="$NVIM_SHARE/site/pack/packer/start/packer.nvim"
export COC_START="$NVIM_SHARE/site/pack/coc/start"
export COC_EXTENSIONS="$HOME/.config/coc/extensions"
export VIM_PLUG_PATH="$NVIM_SHARE/site/autoload/plug.vim"

# 是否将 neovim 配置应用到 ROOT 用户
export OPT_CONFIG_ROOT=1
# 是否允许执行需要 ROOT 权限的操作
ROOT_ACTION=1

function log_info() {
    echo -e "\033[92m$@\033[0m"
}

function help() {
    local fmt="%-20s %s\n"
    echo "Usage: $(basename $0) [options]"
    printf "$fmt" "--no-config-root"      "不将 neovim 的配置应用到 root 用户"
    printf "$fmt" "--disable-root-action" "不执行需要 root 权限的操作"
    return 0
}

function install_plugin_manager() {
    # Add neovim package manager.
    # packer，github：https://github.com/wbthomason/packer.nvim
    if [[ -e "$PACKER_PATH" ]]; then
        git -C "$PACKER_PATH" pull
    else
        git clone https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
    fi

    # All plugins are already managed using packer.vim. vim-plug is no longer needed.
    [ -e "$VIM_PLUG_PATH" ] && rm "$VIM_PLUG_PATH"
    [ -e "$NVIM_SHARE/plugged" ] && rm -rf "$NVIM_SHARE/plugged"
    # In some old versions of bash, is errexit is set, the return value of -e "$NVIM_SHARE/plugged" is false in most cases, and there is no next line of code, which will directly cause bash to exit, so you need to explicitly return 0
    return 0
}

# Apply neovim's configuration to the root user.
function config_root() {
    [[ ! -e '/root/.config' ]] && mkdir '/root/.config'
    [[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
    [[ -e '/root/.config/nvim' ]] && rm -rf '/root/.config/nvim'
    [[ -e '/root/.local/share/nvim' ]] && rm -rf '/root/.local/share/nvim'
    ln -svfT "$PWD" '/root/.config/nvim'
    ln -svfT "$NVIM_SHARE" '/root/.local/share/nvim'
    return 0
}

function install_depend() {
    local packages=('neovim' 'nodejs' 'npm' 'git')
    if [ -x "$(command -v pacman)" ]; then
        pacman -S --noconfirm --needed ${packages[*]} python-pynvim
    elif [ -x "$(command -v dnf)" ]; then
        dnf install -y ${packages[*]} python-neovim
    fi
    return 0
}

function install_plugin() {
    # Install coc
    mkdir -p "$COC_START"
    cd "$COC_START"
    curl --disable -fL -Ss https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
    # Install the coc extension.
    mkdir -p "$COC_EXTENSIONS"
    cd "$COC_EXTENSIONS"
    if [ ! -f package.json ]; then
        echo '{"dependencies":{}}' >package.json
    fi
    npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=production \
        coc-snippets coc-json coc-tsserver coc-pyright
    cd "node_modules/coc-ccls"
    ln -svfT "node_modules/ws/lib" lib

    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    return 0
}


while [ $# -gt 0 ]; do
    case "$1" in
    --help)
        help
        exit 0
        ;;
    --no-config-root)
        OPT_CONFIG_ROOT=0
        ;;
    --disable-root-action)
        ROOT_ACTION=0
        ;;
    *)
        help
        exit 1
        ;;
    esac
    shift
done

log_info "minit neovim..."
[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"

if [[ $PWD != $CONFIG_PATH ]]; then
    ln -svfT "$PWD" "$CONFIG_PATH"
fi

OS="$(uname -o)"
if [[ "$OS" == "GNU/Linux" ]]; then
    install_plugin_manager
    if [ $ROOT_ACTION == 1 ]; then
        sudo -E /bin/bash -o errexit -o nounset -c "
                $(declare -f config_root)
                $(declare -f install_depend)
                [ OPT_CONFIG_ROOT == 1 ] && config_root
                install_depend
            "
    fi
    install_plugin
elif [[ "$OS" == "Android" ]]; then
    set -x
    install_plugin_manager
    install_plugin
    set +x
else
    echo -e "\033[91mUnknown OS: $OS\033[0m"
    exit 1
fi

log_info "init neovim success"
