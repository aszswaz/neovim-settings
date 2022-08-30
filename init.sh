#!/bin/sh

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

cd "$(dirname $0)"

alias ln="ln -svfT"
alias curl="curl --disable -fL"

function log_info() {
    echo -e "\033[92m$@\033[0m"
}

log_info "minit neovim..."

nvim_share="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
config_path="$HOME/.config/nvim"
packer_path="$nvim_share/site/pack/packer/start/packer.nvim"
coc_start="$nvim_share/site/pack/coc/start"
coc_extensions="$HOME/.config/coc/extensions"

if [[ $PWD != $config_path ]]; then
    ln "$PWD" "$config_path"
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
curl -o "$vim_plug_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 将 maven 配置应用到 root 账户
sudo /bin/sh -e -c "
alias ln='ln -svfT'
[[ ! -e '/root/.config' ]] && mkdir '/root/.config'
[[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
[[ -e /root/.config/nvim ]] && rm -rf /root/.config/nvim
[[ -e /root/.local/share/nvim ]] && rm -rf /root/.local/share/nvim
ln '$PWD' '/root/.config/nvim'
ln '$nvim_share' '/root/.local/share/nvim'
exit 0
"

# Install nodejs lts version.
if [ ! -x "$(command -v node)" ]; then
    curl -Ss https://install-node.vercel.app/lts | sh
fi

# Install coc
mkdir -p "$coc_start"
cd "$coc_start"
curl https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
# Install the coc extension.
mkdir -p "$coc_extensions"
cd "$coc_extensions"
if [ ! -f package.json ]; then
    echo '{"dependencies":{}}'> package.json
fi
npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=pro \
    coc-snippets coc-json coc-tsserver coc-pyright coc-ccls


log_info "init neovim success"
unset nvim_share packer_path vim_plug_path
unset -f log_info
