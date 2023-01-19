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

export OPT_CONFIG_ROOT=1

function log_info() {
    echo -e "\033[92m$@\033[0m"
}

function help() {
    local spaces=20
    printf "%-${spaces}s %s\n" "--no-config-root" "不将 neovim 的配置应用到 root 用户"
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
}

# Apply neovim's configuration to the root user.
function config_root() {
    [[ ! -e '/root/.config' ]] && mkdir '/root/.config'
    [[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
    [[ -e '/root/.config/nvim' ]] && rm -rf '/root/.config/nvim'
    [[ -e '/root/.local/share/nvim' ]] && rm -rf '/root/.local/share/nvim'
    ln -svfT "$PWD" '/root/.config/nvim'
    ln -svfT "$NVIM_SHARE" '/root/.local/share/nvim'
}

function install_depend() {
    local packages=('neovim' 'nodejs' 'npm' 'git')
    if [ -x "$(command -v pacman)" ]; then
        pacman -S --noconfirm --needed ${packages[*]} python-pynvim
    else
        [ -x "$(command -v dnf)" ]
        dnf install -y ${packages[*]} python-neovim
    fi
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
        coc-snippets coc-json coc-tsserver coc-pyright coc-ccls
    cd "node_modules/coc-ccls"
    ln -svfT "node_modules/ws/lib" lib

    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

log_info "minit neovim..."

while [ $# -gt 1 ]; do
    case "$1" in
    --no-config-root)
        OPT_CONFIG_ROOT=0
        ;;
    esac
    shift
done

[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"

if [[ $PWD != $CONFIG_PATH ]]; then
    ln -svfT "$PWD" "$CONFIG_PATH"
fi


install_plugin_manager
sudo -E /bin/bash -o errexit -o nounset -c "
        $(declare -f config_root)
        $(declare -f install_depend)
        [ OPT_CONFIG_ROOT == 1 ] && config_root
        install_depend
    "
install_plugin
log_info "init neovim success"
