local logger = require "aszswaz.logger"

local MODULES = {
    "aszswaz.config.plugin.bufferline",
    "aszswaz.config.plugin.coc",
    "aszswaz.config.plugin.indent_blankline",
    "aszswaz.config.plugin.nvim-autopairs",
    "aszswaz.config.plugin.nvim-tree",
    "aszswaz.config.plugin.project",
    "aszswaz.config.plugin.toggleterm",
    "aszswaz.config.plugin.translate",
    "aszswaz.config.plugin.vim-bookmarks",
}

local M = {}

function M.setup()
    if vim.o.loadplugins then
        for _, iterm in pairs(MODULES) do
            local status, res = pcall(require, iterm)
            if not status then
                logger.error(res)
		return
	    end

            local status, msg = pcall(res.setup)
            if not status then
                logger.error(msg)
            end
        end
    end
end

return M
