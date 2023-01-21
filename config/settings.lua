local stdpath = vim.fn.stdpath

-- Set neovim options.

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
    --[[
        If neovim is used in termux-app, neovim's cursor can only be white, and all settings for neovim cursor have no effect.
        In order to prevent the color of the cursor from mixing with the background color of the theme and making it impossible to distinguish,
        a theme with a darker color must be used.
    --]]
    background = os.getenv "TERMUX_APP_PID" and "dark" or "light",
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175",
}
for opt, value in pairs(options) do
    vim.o[opt] = value
end
