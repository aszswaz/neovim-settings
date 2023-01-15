#!/bin/bash

# error when referencing undefined variable
set -o nounset
# exit when command fails
set -o errexit

cd "$(dirname $0)"

log_info() {
    echo -e "\033[92m$@\033[0m"
}

log_info "minit neovim..."

export NVIM_SHARE="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
export CONFIG_PATH="$HOME/.config/nvim"
export PACKER_PATH="$NVIM_SHARE/site/pack/packer/start/packer.nvim"
export COC_START="$NVIM_SHARE/site/pack/coc/start"
export COC_EXTENSIONS="$HOME/.config/coc/extensions"
export VIM_PLUG_PATH="$NVIM_SHARE/site/autoload/plug.vim"

if [[ $PWD != $CONFIG_PATH ]]; then
    ln -svfT "$PWD" "$config_path"
fi

function install_plugin_manager() {
    # Add neovim package manager.
    # packer，github：https://github.com/wbthomason/packer.nvim
    if [[ -e "$PACKER_PATH" ]]; then
        git -C "$PACKER_PATH" pull
    else
        git clone https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
    fi
    # vim-plug，github：https://github.com/junegunn/vim-plug
    curl --disable -fL -o "$VIM_PLUG_PATH" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# Apply neovim's configuration to the root user.
function config_root() {
    if [ $USER == "root" ]; then
        [[ ! -e '/root/.config' ]] && mkdir '/root/.config'
        [[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
        [[ -e '/root/.config/nvim' ]] && rm -rf '/root/.config/nvim'
        [[ -e '/root/.local/share/nvim' ]] && rm -rf '/root/.local/share/nvim'
        ln -svfT "$PWD" '/root/.config/nvim'
        ln -svfT "$NVIM_SHARE" '/root/.local/share/nvim'
    else
        sudo -E /bin/bash -o errexit -o nounset -c "$(declare -f config_root);config_root"
    fi
}

function install_depend() {
    if [ -x "$(command -v pacman)" ]; then
        sudo pacman -S --noconfirm --needed neovim python-pynvim nodejs npm
    else
        [ -x "$(command -v dnf)" ]
        sudo dnf install -y neovim python-neovim nodejs npm
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

    nvim -c 'PlugInstall' -c 'PackerInstall'
}

install_plugin_manager
config_root
install_depend
install_plugin

log_info "init neovim success"
