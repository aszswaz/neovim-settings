local log = require "logger"
local job = require "util.job"

local M = {}
local TEMPLATE_PATH = vim.fn.stdpath "config" .. "/templates"

-- 创建或打开模板文件
function M.open(templateName)
    vim.cmd.edit(TEMPLATE_PATH .. "/" .. templateName)
end

-- Print all templates.
function M.list()
    if vim.fn.isdirectory(TEMPLATE_PATH) == 0 then
        log.warn "No template yet."
        return
    end

    local templates = vim.fn.readdir(TEMPLATE_PATH)
    if #templates == 0 then
        log.warn "No template yet."
        return
    end
    return templates
end

-- Cretae files from templates.
function M.use(templateName, filename)
    local uv = vim.loop
    local setPath = vim.api.nvim_buf_set_name

    vim.cmd.edit(TEMPLATE_PATH .. "/" .. templateName)
    local buffer = vim.api.nvim_get_current_buf()

    if filename then
        setPath(buffer, filename)
    else
        setPath(buffer, templateName)
    end
end

function M.delete(templateName)
    local templateFile = TEMPLATE_PATH .. "/" .. templateName
    if vim.fn.filereadable(templateFile) == 0 then
        error("Template that does not exist: " .. templateName)
        return
    end
    vim.fn.delete(templateFile)
end

-- Submit a template.
function M.commit()
    local command = "git -C " .. TEMPLATE_PATH
    local result = vim.fn.systemlist(command .. " rev-parse --is-inside-work-tree")[1]
    if result ~= "true" then
        error(TEMPLATE_PATH .. ": " .. result)
        return
    end
    result = vim.fn.systemlist(command .. " add " .. TEMPLATE_PATH)
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        error(result)
        return
    end
    result = vim.fn.systemlist(command .. " commit -m 'Submit templates.'")
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        error(result)
        return
    end

    local branch = vim.fn.systemlist(command .. " branch --show-current")[1]
    local repositories = vim.fn.systemlist(command .. " remote")

    for i, item in ipairs(repositories) do
        job.start(command .. " push " .. item .. " " .. branch .. ":master")
    end
end

return {
    open = M.open,
    list = M.list,
    use = M.use,
    delete = M.delete,
    commit = M.commit,
}
