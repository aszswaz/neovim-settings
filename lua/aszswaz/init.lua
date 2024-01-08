local log = require "aszswaz.logger"
local storage = require "aszswaz.util.storage"
local config = require "aszswaz.config"

local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("UIEnter", { pattern = "*", callback = function()
        vim.notify = log.notify
        vim.notify_once = log.notify
    end })

    config.setup()
end

return M
