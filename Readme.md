# Introduction

The configuration of neovim.

# How to use?

```bash
$ ./init.sh
# Install the plugin.
$ nvim -c PlugInstall -c PackerInstall
```

# How to develop?

First, you need to install fish as your terminal shell.

In the second step, clone the repository.

```bash
$ git clone ${HOME}/.config/nvim ${HOME}/neovim-settings
```

Third step is to initialize the test environment.

```bash
$ ./test/init.sh
```

The script will build a test environment under the /test/test-environment directory, and create a "nvim_test" command in fish for testing.
