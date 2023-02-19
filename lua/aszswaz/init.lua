local log = require "aszswaz.logger"
local storage = require "aszswaz.util.storage"
local config = require "aszswaz.config"

local M = {}

function M.setup()
    vim.notify = log.notify
    vim.notify_once = log.notify
    config.setup()
end

return M
