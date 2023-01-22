local M = {}

-- Register hotkeys in batches.
function M.regHotkeys(hotkeys, defaultMode)
    for _, iterm in pairs(hotkeys) do
        local status, errMsg = pcall(function()
            local opts = {
                silent = (iterm.silent or true),
                unique = (iterm.unique or true),
                desc = (iterm.desc or vim.inspect(iterm)),
                noremap = (iterm.noremap or true),
                expr = iterm.expr,
                script = iterm.script,
                nowait = iterm.nowait,
            }

            assert(iterm.key, "Please set the keys to be monitored. Hotkey configuration: \n" .. vim.inspect(iterm))
            assert(iterm.action, "Please set the action to be performed by the Hotkey, Hotkey configuration: \n" .. vim.inspect(iterm))

            if type(iterm.action) == "table" then
                for mode, action in pairs(iterm.action) do
                    vim.keymap.set(mode, iterm.key, action, opts)
                end
            elseif iterm.mode then
                for _, mode in pairs(iterm.mode) do
                    vim.keymap.set(mode, iterm.key, iterm.action, opts)
                end
            elseif defaultMode then
                for _, mode in pairs(defaultMode) do
                    vim.keymap.set(mode, iterm.key, iterm.action, opts)
                end
            else
                error "Please specify ar least one mode."
            end
        end)
        if not status then
            print(errMsg .. vim.inspect(iterm))
        end
    end
end

-- Wrap vim commands as callback functions.
function M.wrapCmd(cmd)
    return function()
        vim.cmd(cmd)
    end
end

-- Checks if the specified highlight does not exist.
function M.hlNotExists(name)
    return vim.fn.hlexists(name) == 0
end

function M.setHighlight(name, value)
    vim.api.nvim_set_hl(0, name, value)
end

return {
    regHotkeys = M.regHotkeys,
    wrapCmd = M.wrapCmd,
    hlNotExists = M.hlNotExists,
    setHighlight = M.setHighlight,
}
