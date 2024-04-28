local MODULES = {
    require "aszswaz.config.settings",
    require "aszswaz.config.autocmd",
    require "aszswaz.config.commands",
    require "aszswaz.config.hotkey",
    require "aszswaz.config.plugin",
}

local M = {}

function M.setup()
    for _, iterm in pairs(MODULES) do
        pcall(iterm.setup)
    end
end

return M
