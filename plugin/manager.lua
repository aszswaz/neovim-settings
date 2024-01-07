pcall(function()
local packer = require "packer"
local plugCfg = require "aszswaz.config.plugin"

-- Use packer.vim to manage plugins.
-- packer，github：https://github.com/wbthomason/packer.nvim
local M = {}

local PLUGINS = {
    -- Let packer manager self.
    "wbthomason/packer.nvim",
    --git plugin
    "tpope/vim-fugitive",
    -- debug plugin
    "puremourning/vimspector",
    -- fish plugin
    "nickeb96/fish.vim",
    -- Translation plugin
    "voldikss/vim-translator",
    -- A gui function for nvim-qt.
    "equalsraf/neovim-gui-shim",
    -- Indent level display plugin
    "lukas-reineke/indent-blankline.nvim",
    -- Bookmark plugin.
    "MattesGroeger/vim-bookmarks",
    -- gdb debugging plugin.
    { "sakhnik/nvim-gdb", run = "./install.sh" },
    -- Automatic pairing plug-in, which can automatically add or delete paired symbols, such as "()", "[]", "{}".
    "windwp/nvim-autopairs",
    -- Project configuration management plugin.
    "aszswaz/project.nvim",
    -- Terminal plugin.
    {
        "akinsho/toggleterm.nvim",
        tag = "*",
    },
    -- Programming language helper plugins.
    { "neoclide/coc.nvim", branch = "release" },
    -- File manager.
    {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    },
    -- Tab page plugin.
    {
        "romgrk/barbar.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    },
    -- Fuzzy lookup plugin.
    {
        "nvim-telescope/telescope.nvim",
        tag = "*",
        requires = { "nvim-lua/plenary.nvim" },
    },
}

local THEMES = {
    -- vscode theme
    "Mofiqul/vscode.nvim",
    -- OneDark theme
    "navarasu/onedark.nvim",
    -- tokyonight theme
    "folke/tokyonight.nvim",
    -- Bottom status bar plugin
    {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    },
}

function M.extend(dest, src)
    for _, iterm in pairs(src) do
        table.insert(dest, iterm)
    end
end

M.extend(PLUGINS, THEMES)
packer.startup(function()
    for _, iterm in pairs(PLUGINS) do
        use(iterm)
    end
end)
end)
