local packer = require "packer"

-- Use packer.vim to manage plugins.

-- packer，github：https://github.com/wbthomason/packer.nvim
packer.startup(function()
    -- Let packer manager self.
    use "wbthomason/packer.nvim"
    -- File manager.
    use {
        "aszswaz/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }
    -- Tab page plugin.
    use {
        "romgrk/barbar.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    }
    --git plugin
    use "tpope/vim-fugitive"
    -- vscode theme
    use "Mofiqul/vscode.nvim"
    -- OneDark theme
    use "navarasu/onedark.nvim"
    -- Bottom status bar plugin
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    }
    -- debug plugin
    use "puremourning/vimspector"
    -- tokyonight theme
    use "folke/tokyonight.nvim"
    -- Terminal plugin.
    use "akinsho/toggleterm.nvim"
    -- fish plugin
    use "nickeb96/fish.vim"
    -- Fuzzy lookup plugin.
    use {
        "nvim-telescope/telescope.nvim",
        tag = "*",
        requires = { "nvim-lua/plenary.nvim" },
    }
    -- Translation plugin
    use "voldikss/vim-translator"
    -- Programming language helper plugins.
    use { "neoclide/coc.nvim", branch = "release", run = vim.cmd.CocUpdate }
    -- A gui function for nvim-qt.
    use "equalsraf/neovim-gui-shim"
    -- Indent level display plugin
    use "lukas-reineke/indent-blankline.nvim"
    -- Bookmark plugin.
    use "MattesGroeger/vim-bookmarks"
    -- Start screen plugin.
    use "mhinz/vim-startify"
    -- gdb debugging plugin.
    use "sakhnik/nvim-gdb"
    -- Automatic pairing plug-in, which can automatically add or delete paired symbols, such as "()", "[]", "{}".
    use "windwp/nvim-autopairs"
    -- Project configuration management plugin.
    use "aszswaz/project.nvim"
end)
