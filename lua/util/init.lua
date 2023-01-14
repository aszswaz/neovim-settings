local strchars = vim.fn.strchars

local setKeymap = vim.keymap.set
local createCommand = vim.api.nvim_create_user_command

local M = {}

-- Register hotkeys in batches.
function M.regHotkeys(hotkeys, defaultMode)
    for _, iterm in pairs(hotkeys) do
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
                setKeymap(mode, iterm.key, action, opts)
            end
        elseif iterm.mode then
            for _, mode in pairs(iterm.mode) do
                setKeymap(mode, iterm.key, iterm.action, opts)
            end
        elseif defaultMode then
            for _, mode in pairs(defaultMode) do
                setKeymap(mode, iterm.key, iterm.action, opts)
            end
        else
            error("Please specify ar least one mode. Hotkey configuration: " .. vim.inspect(iterm))
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
