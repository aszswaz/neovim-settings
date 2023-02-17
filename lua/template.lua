local log = require "logger"
local job = require "util.job"

local M = {}
local templatePath = vim.fn.stdpath "config" .. "/templates"

-- Create a template
function M.new(templateName)
    if vim.fn.isdirectory(templatePath) == 0 then
        if vim.fn.mkdir(templatePath) == 0 then
            log.error(templatePath .. ": Create failed!")
        end
    end

    local bufId = vim.fn.bufadd(templatePath .. "/" .. templateName)
    if vim.fn.buflisted(bufId) == 0 then
        vim.fn.bufload(bufId)
        vim.api.nvim_buf_set_option(bufId, "buflisted", true)
        vim.cmd("bufdo " .. bufId)
    end
end

-- Print all templates.
function M.list()
    if vim.fn.isdirectory(templatePath) == 0 then
        log.warn "No template yet."
        return
    end

    local templates = vim.fn.readdir(templatePath)
    if #templates == 0 then
        log.warn "No template yet."
        return
    end
    return templates
end

-- Cretae files from templates.
function M.use(templateName)
    local templateFile = templatePath .. "/" .. templateName
    if vim.fn.filereadable(templateFile) == 0 then
        log.error("Template that does not exist: " .. templateName)
        return
    end

    local bufId = vim.fn.bufadd(templateName)
    if bufId == vim.fn.bufnr() then
        return
    end

    vim.fn.setbufline(bufId, 1, vim.fn.readfile(templateFile))

    vim.fn.bufload(bufId)
    vim.api.nvim_win_set_buf(bufId)
    local options = vim.bo[bufId]
    options.buflisted = true
    options.modified = false
end

function M.delete(templateName)
    local templateFile = templatePath .. "/" .. templateName
    if vim.fn.filereadable(templateFile) == 0 then
        log.error("Template that does not exist: " .. templateName)
        return
    end
    vim.fn.delete(templateFile)
end

-- Submit a template.
function M.commit()
    local command = "git -C " .. templatePath
    local result = vim.fn.systemlist(command .. " rev-parse --is-inside-work-tree")[1]
    if result ~= "true" then
        log.error(templatePath .. ": " .. result)
        return
    end
    result = vim.fn.systemlist(command .. " add " .. templatePath)
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        log.error(result)
        return
    end
    result = vim.fn.systemlist(command .. " commit -m 'Submit templates.'")
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        log.error(result)
        return
    end

    local branch = vim.fn.systemlist(command .. " branch --show-current")[1]
    local repositories = vim.fn.systemlist(command .. " remote")

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
