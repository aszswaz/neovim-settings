local log = require "logger"
local job = require "util.job"

local isdirectory = vim.fn.isdirectory
local mkdir = vim.fn.mkdir
local buflisted = vim.fn.buflisted
local bufload = vim.fn.bufload
local readdir = vim.fn.readdir
local filereadable = vim.fn.filereadable
local bufadd = vim.fn.bufadd
local bufnr = vim.fn.bufnr
local setbufline = vim.fn.setbufline
local readfile = vim.fn.readfile
local delete = vim.fn.delete
local systemlist = vim.fn.systemlist

local cmd = vim.cmd

local bufSetOption = vim.api.nvim_buf_set_option
local getVvar = vim.api.nvim_get_vvar

local M = {}
local templatePath = vim.fn.stdpath "config" .. "/templates"

-- Create a template
function M.new(templateName)
    if isdirectory(templatePath) == 0 then
        if mkdir(templatePath) == 0 then
            log.error(templatePath .. ": Create failed!")
        end
    end

    local bufId = vim.fn.bufadd(templatePath .. "/" .. templateName)
    if buflisted(bufId) == 0 then
        bufload(bufId)
        bufSetOption(bufId, "buflisted", true)
        cmd("bufdo " .. bufId)
    end
end

-- Print all templates.
function M.list()
    if isdirectory(templatePath) == 0 then
        log.warn "No template yet."
        return
    end

    local templates = readdir(templatePath)
    if #templates == 0 then
        log.warn "No template yet."
        return
    end
    for i, template in ipairs(templates) do
        print(template)
    end
end

-- Cretae files from templates.
function M.use(templateName)
    local templateFile = templatePath .. "/" .. templateName
    if filereadable(templateFile) == 0 then
        log.error("Template that does not exist: " .. templateName)
        return
    end

    local bufId = bufadd(templateName)
    if bufId == bufnr() then
        return
    end

    bufload(bufId)
    bufSetOption(bufId, "buflisted", true)
    setbufline(bufId, 1, readfile(templateFile))
    cmd("bufdo " .. bufId)
end

function M.delete(templateName)
    local templateFile = templatePath .. "/" .. templateName
    if filereadable(templateFile) == 0 then
        log.error("Template that does not exist: " .. templateName)
        return
    end
    delete(templateFile)
end

-- Submit a template.
function M.commit()
    local command = "git -C " .. templatePath
    local result = systemlist(command .. " rev-parse --is-inside-work-tree")[1]
    if result ~= "true" then
        log.error(templatePath .. ": " .. result)
        return
    end
    result = systemlist(command .. " add " .. templatePath)
    if getVvar "shell_error" ~= 0 then
        log.error(result)
        return
    end
    result = systemlist(command .. " commit -m 'Submit templates.'")
    if getVvar "shell_error" ~= 0 then
        log.error(result)
        return
    end

    local branch = systemlist(command .. " branch --show-current")[1]
    local repositories = systemlist(command .. " remote")

    for i, item in ipairs(repositories) do
        job.start(command .. " push " .. item .. " " .. branch .. ":master")
    end
end

return {
    new = M.new,
    list = M.list,
    use = M.use,
    delete = M.delete,
    commit = M.commit,
}
