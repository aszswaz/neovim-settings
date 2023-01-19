local packer = require "packer"

-- Use vim-plug and packer.vim to manage plugins.

-- vim-plug
vim.fn["plug#begin"]()

local plug = vim.fn["plug#"]
-- Bookmark plugin.
plug "MattesGroeger/vim-bookmarks"
-- Start screen plugin.
plug "mhinz/vim-startify"
-- gdb debugging plugin.
plug("sakhnik/nvim-gdb", { ["do"] = ":!./install.sh" })

vim.fn["plug#end"]()

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
        tag = "0.1.1",
        requires = { "nvim-lua/plenary.nvim" },
    }
    -- Translation plugin
    use "voldikss/vim-translator"
    -- Programming language helper plugins.
    use { "neoclide/coc.nvim", branch = "release" }
    -- A gui function for nvim-qt.
    use "equalsraf/neovim-gui-shim"
    -- Indent level display plugin
    use "lukas-reineke/indent-blankline.nvim"
end)
