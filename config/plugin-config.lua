local event = require "event"

-- File manager plugin
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

-- Text indentation level display settings.
require("indent_blankline").setup {
    show_end_of_line = true,
    filetype_exclude = { "startify", "help", "qf", "vim-plug", "dashboard" },
}

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
            guifg = "#CCCCCC",
            guibg = "#2C2C2C",
        },
        FloatBorder = {
            guifg = "#CCCCCC",
            guibg = "#2C2C2C",
        },
    },
    on_create = event.toggleterm_open,
}

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

-- vim-bookmarks
vim.api.nvim_set_var("bookmark_sign", "⚑")
vim.api.nvim_set_var("bookmark_highlight_lines", 0)

-- enable lualine.
require("lualine").setup {}

-- enable nvim-autopairs
require("nvim-autopairs").setup {
    map_cr = false,
}
