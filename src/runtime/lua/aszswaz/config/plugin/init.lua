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
        -- 加载插件，一个插件加载失败不能影响其它插件的加载
        for _, iterm in pairs(MODULES) do
            local status, msg = pcall(function()
                require(iterm).setup()
            end)
            if not status then
                logger.error(msg)
            end
        end
    end
end

return M
