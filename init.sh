#!/bin/sh -e

cd "$(dirname $0)"

source ../shell/lib/index.sh

log_info "init neovim..."

# 当前文件夹映射到 nvim 的默认配置文件路径
if [[ ! -e "$HOME/.config/nvim" ]]; then
    ln -s "$PWD" "$HOME/.config/nvim"
fi

# 添加 vim 包管理器当当前用户和 root 用户
# packer，github：https://github.com/wbthomason/packer.nvim
nvim_share="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
packer_path="$nvim_share/site/pack/packer/start/packer.nvim"
[[ ! -e "$packer_path" ]] && git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_path"
# vim-plug，github：https://github.com/junegunn/vim-plug
vim_plug_path="$nvim_share/site/autoload/plug.vim"
[[ ! -e "$vim_plug_path" ]] && curl --disable -fLo "$vim_plug_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 将 maven 配置应用到 root 账户
sudo $SHELL -e -c "
[[ ! -e '/root/.config' ]] && mkdir '/root/.config'
[[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
[[ ! -e '/root/.config/nvim' ]] && ln -s '$PWD' '/root/.config/nvim'
[[ ! -e '/root/.local/share/nvim' ]] && ln -s '$nvim_share' '/root/.local/share/nvim'
exit 0
"
unset nvim_share packer_path vim_plug_path
log_info "init neovim sucess"
