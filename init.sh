#!/bin/sh -e

cd "$(dirname $0)"

source ../shell/lib/index.sh

log_info "init neovim..."

config_path="$HOME/.config/nvim"

if [[ -e $config_path ]]; then
    if [[ -L $config_path ]]; then
        if [[ $(readlink "$config_path") != "$PWD" ]]; then
            rm -rf "$config_path"
            ln -s "$PWD" "$config_path"
        fi
    elif [[ $PWD != $config_path ]]
        rm -rf "$config_path"
        ln -s "$PWD" "$config_path"
    fi
else
    ln -s "$PWD" "$config_path"
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
[[ ! -e '/root/.config/nvim' ]] && ln -s '$PWD' '/root/.config/nvim'
[[ ! -e '/root/.local/share/nvim' ]] && ln -s '$nvim_share' '/root/.local/share/nvim'
exit 0
"
unset nvim_share packer_path vim_plug_path
log_info "init neovim sucess"
