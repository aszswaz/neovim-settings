local strchars = vim.fn.strchars

local setKeymap = vim.keymap.set
local createCommand = vim.api.nvim_create_user_command

local M = {}

function M.inserts(dest, src)
    if type(dest) ~= "table" then
        dialog.error 'The parameter "dest" type must be a table.'
        return
    end
    if type(src) == "table" then
        for i = 1, #src do
            table.insert(dest, src[i])
        end
    else
        table.insert(dest, src)
    end
end

function M.strlens(text)
    local textLen = 0
    local mType = type(text)
    if mType == "string" then
        textLen = strchars(text)
    elseif mType == "table" then
        for i = 1, #text do
            textLen = textLen + strchars(text[i])
        end
    end
    return textLen
end

-- Register hotkeys in batches.
function M.regHotkeys(hotkeys, defaultMode)
    for index, iterm in pairs(hotkeys) do
        local opts = {
            silent = true,
            unique = true,
            desc = iterm.desc,
            noremap = true,
        }
        local targetMode = nil
        if iterm.mode == nil then
            targetMode = defaultMode
        else
            targetMode = iterm.mode
        end
        for index, mode in pairs(targetMode) do
            setKeymap(mode, iterm.key, iterm.action, opts)
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
