# Introduction

The configuration of neovim.

# How to use?

```bash
$ ./init.sh
# Install the plugin.
$ nvim -c PlugInstall -c PackerInstall
```

# How to develop?

First, create a repository for development:

```bash
$ git clone ${HOME}/.config/nvim ${HOME}/neovim-settings
```

If you need to debug a script under development, you can execute the following command:

```bash
# Sepcifies the init script for neovim.
$ alias nvim="nvim -u $PWD/init.lua"
$ nvim
```
