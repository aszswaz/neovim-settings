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
    mouse = "",
    splitright = true,
    splitbelow = true,
    scrolloff = 3,
    number = true,
    cursorcolumn = true,
    cursorline = true,
    termguicolors = true,
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175",
    guifont = "JetBrainsMono Nerd Font Mono:h12",
}
for opt, value in pairs(options) do
    vim.o[opt] = value
end
