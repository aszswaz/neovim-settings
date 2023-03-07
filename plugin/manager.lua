local packer = require "packer"

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
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_end_of_line = true,
                filetype_exclude = { "startify", "help", "qf", "vim-plug", "dashboard" },
            }
        end,
    },
    -- Bookmark plugin.
    {
        "MattesGroeger/vim-bookmarks",
        config = function()
            -- vim-bookmarks
            vim.api.nvim_set_var("bookmark_sign", "⚑")
            vim.api.nvim_set_var("bookmark_highlight_lines", 0)
        end,
    },
    -- gdb debugging plugin.
    { "sakhnik/nvim-gdb", run = "./install.sh" },
    -- Automatic pairing plug-in, which can automatically add or delete paired symbols, such as "()", "[]", "{}".
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {
                map_cr = false,
            }
        end,
    },
    -- Project configuration management plugin.
    {
        "aszswaz/project.nvim",
        config = function()
            require("project").setup {
                autostart = { "~/Documents/project/aszswaz", "~/Documents/project/neovim" },
                shell = "/bin/bash",
            }
        end,
    },
    -- Terminal plugin.
    {
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            -- Terminal plugin.
            require("toggleterm").setup {
                hide_numbers = true,
                shade_terminals = true,
                -- The color depth of the terminal
                shading_factor = "1",
                start_in_insert = true,
                insert_mappings = true,
                terminal_mappings = true,
                persist_szie = true,
                -- Terminal window type
                direction = "float",
                close_on_exit = true,
                -- Set the default shell.
                shell = vim.o.shell,
                -- Terminal's popup settings.
                float_opts = {
                    border = "rounded",
                    width = math.floor(vim.o.columns / 5 * 4),
                    height = math.floor(vim.o.lines / 5 * 4),
                    -- transparency
                    winblend = 0,
                },
                highlights = {
                    NormalFloat = {
                        guifg = "#DCDCDC",
                        guibg = "#2C2C2C",
                    },
                    FloatBorder = {
                        guifg = "#CCCCCC",
                        guibg = "#2C2C2C",
                    },
                },
                on_create = require("aszswaz.event").toggleterm_open,
            }
        end,
    },
    -- Programming language helper plugins.
    { "neoclide/coc.nvim", branch = "release" },
    -- File manager.
    {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                -- Enable git
                git = {
                    enable = true,
                    ignore = false,
                },
                view = {
                    mappings = {
                        list = {
                            { key = "<C-e>", action = "close" },
                        },
                    },
                },
            }
        end,
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
        config = function()
            -- Plugins that use buffer as tab.
            require("bufferline").setup {
                animation = true,
                auto_hide = false,
                tabpages = true,
                closable = true,
                clickable = true,
                exclude_ft = { "qf", "fugitive" },
                exclude_name = {},
                icons = true,
                icon_custom_colors = false,
                icon_separator_active = "▎",
                icon_separator_inactive = "▎",
                icon_close_tab = "",
                icon_close_tab_modified = "●",
                icon_pinned = "車",
                insert_at_end = true,
                insert_at_start = false,
                maximum_padding = 1,
                maximum_length = 30,
                semantic_letters = true,
                letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
                no_name_title = nil,
            }
        end,
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
