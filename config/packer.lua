-- packer，github：https://github.com/wbthomason/packer.nvim

vim.cmd [[packadd packer.nvim]]

-- packer, like vim-plug, is also a package manager.
return require("packer").startup(function()
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
end)
