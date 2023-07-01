local MODULES = {
    require "aszswaz.config.plugin.bufferline",
    require "aszswaz.config.plugin.coc",
    require "aszswaz.config.plugin.indent_blankline",
    require "aszswaz.config.plugin.nvim-autopairs",
    require "aszswaz.config.plugin.nvim-tree",
    require "aszswaz.config.plugin.project",
    require "aszswaz.config.plugin.toggleterm",
    require "aszswaz.config.plugin.translate",
    require "aszswaz.config.plugin.vim-bookmarks",
}

local M = {}

function M.setup()
    if vim.o.loadplugins then
        for _, iterm in pairs(MODULES) do
            iterm.setup()
        end
    end
end

return M
