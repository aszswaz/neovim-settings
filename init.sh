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

nvim_share="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
config_path="$HOME/.config/nvim"
packer_path="$nvim_share/site/pack/packer/start/packer.nvim"
coc_start="$nvim_share/site/pack/coc/start"
coc_extensions="$HOME/.config/coc/extensions"

if [[ $PWD != $config_path ]]; then
    ln -svfT "$PWD" "$config_path"
fi


# 添加 vim 包管理器
# packer，github：https://github.com/wbthomason/packer.nvim
if [[ -e "$packer_path" ]]; then
    env -C "$packer_path" git pull
else
    git clone https://github.com/wbthomason/packer.nvim "$packer_path"
fi

# vim-plug，github：https://github.com/junegunn/vim-plug
vim_plug_path="$nvim_share/site/autoload/plug.vim"
curl --disable -fL -o "$vim_plug_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 将 maven 配置应用到 root 账户
sudo /bin/bash -e -c "
[[ ! -e '/root/.config' ]] && mkdir '/root/.config'
[[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
[[ -e /root/.config/nvim ]] && rm -rf /root/.config/nvim
[[ -e /root/.local/share/nvim ]] && rm -rf /root/.local/share/nvim
ln -svfT '$PWD' '/root/.config/nvim'
ln -svfT '$nvim_share' '/root/.local/share/nvim'
exit 0
"

# Install nodejs lts version.
if [ ! -x "$(command -v node)" ]; then
    curl --disable -fL -Ss https://install-node.vercel.app/lts | sudo sh
fi

# Install coc
mkdir -p "$coc_start"
cd "$coc_start"
curl --disable -fL -Ss https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
# Install the coc extension.
mkdir -p "$coc_extensions"
cd "$coc_extensions"
if [ ! -f package.json ]; then
    echo '{"dependencies":{}}'> package.json
fi
npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=production \
    coc-snippets coc-json coc-tsserver coc-pyright coc-ccls
cd "node_modules/coc-ccls"
ln -svfT "node_modules/ws/lib" lib

log_info "init neovim success"
