-- Set neovim options.
local M = {}

local autocmd = vim.cmd.autocmd
local createAutocmd = vim.api.nvim_create_autocmd

local stdpath = vim.fn.stdpath

local OPTIONS = {
    tabstop = 4,
    shiftwidth = 0,
    expandtab = true,
    shiftround = true,
    writebackup = false,
    magic = true,
    wrap = false,
    mouse = "",
    splitright = true,
    splitbelow = true,
    scrolloff = 3,
    number = true,
    cursorcolumn = true,
    cursorline = true,
    termguicolors = true,
    showmode = false,
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175",
    guifont = "JetBrainsMono Nerd Font Mono:h12",
    formatexpr = 'v:lua.require("aszswaz.text").format(v:true)',
    tags = "/usr/share/nvim/plugins/tags," .. stdpath("cache") .. "/tags"
}

function M.setup()
    for opt, value in pairs(OPTIONS) do
        vim.o[opt] = value
    end

    autocmd "FileType json,html,xml,yaml,svg,sql :set tabstop=2"
    autocmd "FileType text,desktop,markdown      :set wrap"
    autocmd "FileType tags                       :set noexpandtab"
    autocmd "FileType help                       :set conceallevel=0"
    autocmd "FileType *                          :set formatoptions=tcro/w1]jp"

    -- UI 窗口完全打开之后，类似 columns 这样的值在 UI 完全打开之前是无效的
    createAutocmd("UIEnter", {
        pattern = "*",
        callback = function()
            vim.o.textwidth = math.floor(vim.o.columns / 4 * 3)
        end
    })
end

return M
