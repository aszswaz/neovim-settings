local template_path = vim.g.config_dir .. "/templates"

-- Create a template
function TemplateNew(template_name)
    if vim.fn.isdirectory(template_path) == 0 then
        if vim.fn.mkdir(template_path) == 0 then
            DialogError(template_path .. ": Create failed!")
        end
    end

    local buf_id = vim.fn.bufadd(template_path .. "/" .. template_name)
    if vim.fn.buflisted(buf_id) == 0 then
        vim.fn.bufload(buf_id)
        vim.api.nvim_buf_set_option(buf_id, "buflisted", true)
        vim.cmd("bufdo " .. buf_id)
    end
end

-- Print all templates.
function TemplateList()
    if vim.fn.isdirectory(template_path) == 0 then
        DialogWarn "No template yet."
        return
    end

    local templates = vim.fn.readdir(template_path)
    if #templates == 0 then
        DialogWarn "No template yet."
        return
    end
    for i, template in ipairs(templates) do
        print(template)
    end
end

-- Cretae files from templates.
function TemplateUse(template_name)
    local template_file = template_path .. "/" .. template_name
    if vim.fn.filereadable(template_file) == 0 then
        DialogError("Template that does not exist: " .. template_name)
        return
    end

    local buf_id = vim.fn.bufadd(template_name)
    if buf_id == vim.fn.bufnr() then
        return
    end

    vim.fn.bufload(buf_id)
    vim.api.nvim_buf_set_option(buf_id, "buflisted", true)
    vim.fn.setbufline(buf_id, 1, vim.fn.readfile(template_file))
    vim.cmd("bufdo " .. buf_id)
end

function TemplateDelete(template_name)
    local template_file = template_path .. "/" .. template_name
    if vim.fn.filereadable(template_file) == 0 then
        DialogError("Template that does not exist: " .. template_name)
        return
    end
    vim.fn.delete(template_file)
end
