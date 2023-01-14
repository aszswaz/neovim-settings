local stdpath = vim.fn.stdpath

local createAutocmd = vim.api.nvim_create_autocmd
local setHighlight = vim.api.nvim_set_hl
local getHighlight = vim.api.nvim_get_hl_by_name

local options = {
    tabstop = 4,
    shiftwidth = 0,
    expandtab = true,
    shiftround = true,
    writebackup = false,
    magic = true,
    wrap = false,
    textwidth = math.floor(vim.o.columns / 4 * 3),
    tags = vim.o.tags .. "," .. stdpath "config" .. "/tags",
    mouse = "a",
    splitright = true,
    splitbelow = true,
    scrolloff = 3,
    number = true,
    cursorcolumn = true,
    cursorline = true,
    termguicolors = true,
    background = "light",
}
for opt, value in pairs(options) do
    vim.o[opt] = value
end

createAutocmd("FileType", {
    desc = "Sets the indentation width for some file types.",
    pattern = { "json", "html", "xml", "yaml", "svg", "sql" },
    callback = function()
        vim.o.tabstop = 2
    end,
})

createAutocmd("FileType", {
    desc = "Some file types enable line breaks.",
    pattern = { "text", "desktop" },
    callback = function()
        vim.o.wrap = true
    end,
})

createAutocmd("FileType", {
    desc = "Set formatting options for all file types.",
    pattern = "*",
    callback = function()
        vim.o.formatoptions = "jcroql"
    end,
})

createAutocmd("ColorScheme", {
    desc = "After the theme is set, set some highlights.",
    pattern = "*",
    callback = function()
        -- Get the background color set by the current theme.
        local normal = getHighlight("Normal", true)
        setHighlight(0, "DialogNormal", { fg = normal.foreground, bg = normal.background })
        setHighlight(0, "NotifyDebug", { fg = "#66CCFF", bg = bg })
        setHighlight(0, "NotifyInfo", { fg = "#008000", bg = bg })
        setHighlight(0, "NotifyWarn", { fg = "#FF7F00", bg = bg })
        setHighlight(0, "NotifyError", { fg = "#FF0000", bg = bg })
    end,
})

-- Set the theme and trigger the ColorScheme event, the theme file is in the colors directory.
-- vim.cmd [[colorscheme Tomorrow-Night-Eighties]]
vim.cmd [[colorscheme vscode]]
