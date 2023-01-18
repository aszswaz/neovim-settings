local define = require "float-window.define"

local setHighlight = vim.api.nvim_set_hl
local getHighlight = vim.api.nvim_get_hl_by_name

local M = {}

function M.regStyle()
    -- Get the background color set by the current theme.
    local normal = getHighlight("Normal", true)
    setHighlight(0, define.normal, { fg = (normal.foreground or "#FFFFFF") })
    setHighlight(0, define.debug, { fg = "#66CCFF" })
    setHighlight(0, define.info, { fg = "#008000" })
    setHighlight(0, define.warn, { fg = "#FF9F00" })
    setHighlight(0, define.error, { fg = "#FF0000" })
end

return {
    notify = require "float-window.notify",
    dialog = require "float-window.dialog",
    regStyle = M.regStyle,
}
