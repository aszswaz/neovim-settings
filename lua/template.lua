local dialog = require "utils/dialog"

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

local nvim_buf_set_option = vim.api.nvim_buf_set_option
local nvim_get_vvar = vim.api.nvim_get_vvar

local M = {}
local templatePath = vim.fn.stdpath "config" .. "/templates"

-- Create a template
function M.new(templateName)
    if isdirectory(templatePath) == 0 then
        if mkdir(templatePath) == 0 then
            dialog.error(templatePath .. ": Create failed!")
        end
    end

    local buf_id = vim.fn.bufadd(templatePath .. "/" .. templateName)
    if buflisted(buf_id) == 0 then
        bufload(buf_id)
        nvim_buf_set_option(buf_id, "buflisted", true)
        cmd("bufdo " .. buf_id)
    end
end

-- Print all templates.
function M.list()
    if isdirectory(templatePath) == 0 then
        dialog.warn "No template yet."
        return
    end

    local templates = readdir(templatePath)
    if #templates == 0 then
        ialog.warn "No template yet."
        return
    end
    for i, template in ipairs(templates) do
        print(template)
    end
end

-- Cretae files from templates.
function M.use(templateName)
    local template_file = templatePath .. "/" .. templateName
    if filereadable(template_file) == 0 then
        dialog.error("Template that does not exist: " .. templateName)
        return
    end

    local buf_id = bufadd(templateName)
    if buf_id == bufnr() then
        return
    end

    bufload(buf_id)
    nvim_buf_set_option(buf_id, "buflisted", true)
    setbufline(buf_id, 1, readfile(template_file))
    cmd("bufdo " .. buf_id)
end

function M.delete(templateName)
    local template_file = templatePath .. "/" .. templateName
    if filereadable(template_file) == 0 then
        dialog.error("Template that does not exist: " .. templateName)
        return
    end
    delete(template_file)
end

-- Submit a template.
function M.commit()
    local command = "git -C " .. templatePath
    local result = systemlist(command .. " rev-parse --is-inside-work-tree")[1]
    if result ~= "true" then
        dialog.error(templatePath .. ": " .. result)
        return
    end
    result = systemlist(command .. " add " .. templatePath)
    if nvim_get_vvar "shell_error" ~= 0 then
        dialog.error(result)
        return
    end
    result = systemlist(command .. " commit -m 'Submit templates.'")
    if nvim_get_vvar "shell_error" ~= 0 then
        dialog.error(result)
        return
    end

    local branch = systemlist(command .. " branch --show-current")[1]
    local repositories = systemlist(command .. " remote")

    for i, item in ipairs(repositories) do
        job.start(command .. " push " .. item .. " " .. branch .. ":master")
    end
end

return M
