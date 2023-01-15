local stdpath = vim.fn.stdpath

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
    viminfo = "'100,n" .. stdpath "data" .. "/viminfo",
}
for opt, value in pairs(options) do
    vim.o[opt] = value
end
