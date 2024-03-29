local vimWarp = require "aszswaz.util.vim-warp"
local objects = require "aszswaz.util.objects"

-- Store data in json form.
local M = {}

-- Data storage path.
local STORAGE_PATH = vim.fn.stdpath "state" .. "/shada/storage.json"
local DATA

-- Read data from a file.
local dir = vim.fs.dirname(STORAGE_PATH)
if not vimWarp.isdirectory(dir) then
    vim.fn.mkdir(dir)
end
if vimWarp.filereadable(STORAGE_PATH) then
    local lines = io.open(STORAGE_PATH):read("*a")
    DATA = objects.new(vim.fn.json_decode(lines))
else
    DATA = objects.new()
end

function M.get(key, default)
    if DATA[key] then
        return objects.new(DATA[key])
    elseif default then
        DATA[key] = default
        return default
    end
end

function M.set(key, value)
    DATA[key] = value
end

function M.unset(key)
    DATA[key] = nil
end

function M.save()
    local data = vim.fn.json_encode(DATA)
    local file = io.open(STORAGE_PATH, "w")
    file:write(data)
    file:flush()
end

return { init = M.init, set = M.set, get = M.get, unset = M.unset, save = M.save }
