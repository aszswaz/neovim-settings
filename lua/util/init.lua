local strchars = vim.fn.strchars

local setKeymap = vim.keymap.set
local createCommand = vim.api.nvim_create_user_command

local M = {}

-- Register hotkeys in batches.
function M.regHotkeys(hotkeys, defaultMode)
    for _, iterm in pairs(hotkeys) do
        local opts = {
            silent = true,
            unique = true,
            desc = iterm.desc,
            noremap = true,
        }

        if iterm.mode then
            for _, mode in pairs(iterm.mode) do
                setKeymap(mode, iterm.key, iterm.action, opts)
            end
            break
        elseif type(iterm.action) == "table" then
            for mode, action in pairs(iterm.action) do
                setKeymap(mode, iterm.key, action, opts)
            end
        elseif defaultMode then
            for _, mode in pairs(defaultMode) do
                setKeymap(mode, iterm.key, iterm.action, opts)
            end
        end
    end
end

-- Register a directive that takes no arguments.
function M.rc(command, targetCallback, desc)
    local opts = { desc = desc, nargs = 0 }
    local callback = function(args)
        targetCallback()
    end
    createCommand(command, callback, opts)
end

-- Register a directive with only one parameter.
function M.rcParameter(command, targetCallback, desc)
    local opts = { desc = desc, nargs = 1 }
    local callback = function(args)
        targetCallback(args.args)
    end
    createCommand(command, callback, opts)
end

-- Wrap vim commands as callback functions.
function M.wrapCmd(cmd)
    return function()
        vim.cmd(cmd)
    end
end

return {
    inserts = M.inserts,
    strlens = M.strlens,
    regHotkeys = M.regHotkeys,
    rc = M.rc,
    rcParameter = M.rcParameter,
    wrapCmd = M.wrapCmd,
}
