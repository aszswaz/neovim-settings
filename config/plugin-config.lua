local CONFIG_DIR = vim.fn.stdpath "config"

-- File manager plugin
require("nvim-tree").setup {
    -- Enable git
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
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
    shell = "/bin/fish",
    -- Terminal's popup settings.
    float_opts = {
        border = "single",
        width = 300,
        height = 60,
        -- 透明度
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

-- Plugins that use buffer as tab.
require("bufferline").setup {
    animation = true,
    auto_hide = false,
    tabpages = true,
    closable = true,
    clickable = true,
    exclude_ft = { "qf" },
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

-- Status bar theme configuration.
local lightline = {
    colorscheme = "onedark",
    active = {
        left = { { "mode", "paste" }, { "user", "gitbranch", "readonly", "filename", "modified" } },
    },
    component_function = {
        user = "Username",
        gitbranch = "Gitbranchicon",
    },
}
vim.api.nvim_set_var("lightline", lightline)
vim.cmd [[
function! Gitbranchicon()
    let branchname=gitbranch#name()
    if empty(branchname)
        return ""
    else
        return " " . branchname
    endif
endfunction
]]
vim.cmd [[
function! Username()
    return $USER
endfunction
]]

-- vim-bookmarks
vim.cmd [[autocmd ColorScheme * :highlight BookmarkSign guibg=NONE guifg='#D70000']]
vim.cmd [[autocmd ColorScheme * :highlight BookmarkLine guibg='#D7FFD7' guifg=NONE]]
vim.api.nvim_set_var("bookmark_sign", "⚑")
vim.api.nvim_set_var("bookmark_highlight_lines", 1)
