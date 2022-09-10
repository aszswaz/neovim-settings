-- packer，github：https://github.com/wbthomason/packer.nvim

vim.cmd [[packadd packer.nvim]]

-- packer, like vim-plug, is also a package manager.
return require("packer").startup(function()
    -- Let packer manager self.
    use "wbthomason/packer.nvim"
    -- Tab page plugin.
    use {
        "romgrk/barbar.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    }
end)