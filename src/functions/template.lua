Template = {}

-- Create a template
function Template:new(templateName)
    local templatePath = vim.g.template_path
    if vim.fn.isdirectory(templatePath) == 0 then
        if vim.fn.mkdir(templatePath) == 0 then
            dialog.error(templatePath .. ": Create failed!")
        end
    end

    local buf_id = vim.fn.bufadd(templatePath .. "/" .. templateName)
    if vim.fn.buflisted(buf_id) == 0 then
        vim.fn.bufload(buf_id)
        vim.api.nvim_buf_set_option(buf_id, "buflisted", true)
        vim.cmd("bufdo " .. buf_id)
    end
end

-- Print all templates.
function Template:list()
    local templatePath = vim.g.template_path
    if vim.fn.isdirectory(templatePath) == 0 then
        dialog.warn "No template yet."
        return
    end

    local templates = vim.fn.readdir(templatePath)
    if #templates == 0 then
        ialog.warn "No template yet."
        return
    end
    for i, template in ipairs(templates) do
        print(template)
    end
end

-- Cretae files from templates.
function Template:use(templateName)
    local templatePath = vim.g.template_path
    local template_file = templatePath .. "/" .. templateName
    if vim.fn.filereadable(template_file) == 0 then
        dialog.error("Template that does not exist: " .. templateName)
        return
    end

    local buf_id = vim.fn.bufadd(templateName)
    if buf_id == vim.fn.bufnr() then
        return
    end

    vim.fn.bufload(buf_id)
    vim.api.nvim_buf_set_option(buf_id, "buflisted", true)
    vim.fn.setbufline(buf_id, 1, vim.fn.readfile(template_file))
    vim.cmd("bufdo " .. buf_id)
end

function Template:delete(templateName)
    local templatePath = vim.g.template_path
    local template_file = templatePath .. "/" .. templateName
    if vim.fn.filereadable(template_file) == 0 then
        dialog.error("Template that does not exist: " .. templateName)
        return
    end
    vim.fn.delete(template_file)
end

-- Submit a template.
function Template:commit()
    local templatePath = vim.g.template_path
    local command = "git -C " .. templatePath
    local result = vim.fn.systemlist(command .. " rev-parse --is-inside-work-tree")[1]
    if result ~= "true" then
        dialog.error(templatePath .. ": " .. result)
        return
    end
    result = vim.fn.systemlist(command .. " add " .. templatePath)
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        dialog.error(result)
        return
    end
    result = vim.fn.systemlist(command .. " commit -m 'Submit templates.'")
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        dialog.error(result)
        return
    end

    local branch = vim.fn.systemlist(command .. " branch --show-current")[1]
    local repositories = vim.fn.systemlist(command .. " remote")

    for i, item in ipairs(repositories) do
        Job:start(command .. " push " .. item .. " " .. branch .. ":master")
    end
end
