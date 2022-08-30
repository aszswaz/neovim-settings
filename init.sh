#!/bin/sh -e

cd "$(dirname $0)"

function log_info() {
    echo -e "\033[92m$@\033[0m"
}

log_info "minit neovim..."

config_path="$HOME/.config/nvim"

if [[ -e $config_path ]]; then
    if [[ -L $config_path ]]; then
        ln -s -f "$PWD" "$config_path"
    elif [[ $PWD != $config_path ]]; then
        rm -rf "$config_path"
        ln -s "$PWD" "$config_path"
    fi
else
    ln -s -f "$PWD" "$config_path"
fi

# 添加 vim 包管理器当当前用户和 root 用户
# packer，github：https://github.com/wbthomason/packer.nvim
nvim_share="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
packer_path="$nvim_share/site/pack/packer/start/packer.nvim"

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
[[ ! -e '/root/.config' ]] && mkdir '/root/.config'
[[ ! -e '/root/.local/share' ]] && mkdir -p '/root/.local/share'
ln -s -f '$PWD' '/root/.config/nvim'
ln -s -f '$nvim_share' '/root/.local/share/nvim'
exit 0
"

log_info "init neovim success"
unset nvim_share packer_path vim_plug_path
unset -f log_info
