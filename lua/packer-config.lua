-- packer，github：https://github.com/wbthomason/packer.nvim

vim.cmd [[packadd packer.nvim]]

-- 使用 packer 管理插件，界面的展示效果比 vim-plug 好一些，虽然生态环境还很小，暂时先保留着
return require("packer").startup(function()
    -- 让 packer 自己管理自己
    use "wbthomason/packer.nvim"
    -- 标签页插件
    use {
        "romgrk/barbar.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    }
end)
