require "utils/dialog"

text = {}

-- Format files via external tools.
text.format = function()
    local filetype = vim.o.filetype
    local textwidth = vim.o.textwidth
    local tabstop = vim.o.tabstop
    local command = nil

    if filetype == "json" then
        command = "jq"
    elseif filetype == "java" then
        command = "astyle --style=java -s" .. tabstop .. " --mode=java -U"
    elseif filetype == "python" then
        command = "autopep8 --max-line-length " .. textwidth .. " -"
    elseif filetype == "lua" then
        command = "stylua - --indent-type Spaces --indent-width "
            .. tabstop
            .. " --call-parentheses None --quote-style AutoPreferDouble --column-width "
            .. textwidth
    elseif filetype == "tex" or filetype == "latex" then
        command = "latexindent"
    elseif filetype == "xml" then
        command = "xmllint --encode UTF-8 --format -"
    elseif filetype == "cpp" or filetype == "c" then
        command = "astyle -s"
            .. tabstop
            .. " -A2 -xn -xc -xl -xk -xV -C -xG -S -K -N -L -xw -w -Y -f -p -xg -H -U -k3 -W3"
            .. " -xL -xC"
            .. textwidth
    elseif filetype == "sh" or filetype == "zsh" or filetype == "bash" then
        command = "shfmt -ln bash -i " .. tabstop
    elseif filetype == "typescript" or filetype == "javascript" or filetype == "js" then
        command = "prettier --parser typescript --print-width "
            .. textwidth
            .. " --tab-width "
            .. tabstop
            .. " --no-semi --single-attribute-per-line"
    elseif filetype == "css" or filetype == "scss" or filetype == "less" then
        command = "prettier --parser "
            .. filetype
            .. " --print-width "
            .. textwidth
            .. " --tab-width "
            .. tabstop
            .. " --no-semi --single-attribute-per-line"
    elseif filetype == "html" then
        command = "prettier --parser html --print-width "
            .. textwidth
            .. " --tab-width "
            .. tabstop
            .. " --no-semi --single-attribute-per-line"
    elseif filetype == "vue" then
        command = "prettier --parser vue --print-width "
            .. textwidth
            .. " --tab-width "
            .. tabstop
            .. " --no-semi --single-attribute-per-line --vue-indent-script-and-style"
    elseif filetype == "markdown" then
        command = "prettier --parser markdown --print-width " .. textwidth .. " --tab-width " .. tabstop
    elseif filetype == "yaml" then
        command = "prettier --parser yaml --print-width " .. textwidth .. " --tab-width " .. tabstop
    else
        dialog.error("Unknown file type: " .. filetype)
        return
    end

    local output = vim.fn.systemlist(command, vim.fn.getline(1, "$"))
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        vim.fn.setline(1, output)
        -- Delete extra lines.
        local del_start = vim.fn.len(output)
        local del_end = vim.fn.line "$"
        if del_end > del_start then
            vim.fn.deletebufline(vim.fn.bufnr(), del_start + 1, del_end)
        end
    else
        dialog.error(output)
    end
end

text.row = {}
text.row.copy = function()
    local cursorX = vim.fn.col "."
    vim.cmd "normal! yyp"
    vim.cmd("normal! " .. cursorX .. "|")
end

text.row.delete = function()
    local cursorX = vim.fn.col "."
    vim.api.nvim_del_current_line()
    vim.cmd("normal! " .. cursorX .. "|")
end

text.row.trim = function()
    local lineCount = vim.api.nvim_buf_line_count(0)
    local lines = vim.api.nvim_buf_get_lines(0, 0, lineCount, true)
    for lineNumber = 1, #lines do
        local lineText = lines[lineNumber]
        local lineLen = vim.fn.strlen(lineText)
        if lineLen == 0 then
            goto continue
        end

        local lastIndex = lineLen - 1
        local i = lastIndex
        while i >= 0 and vim.fn.strgetchar(lineText, i) == 32 do
            i = i - 1
        end

        if i == -1 then
            lines[lineNumber] = ""
        else
            lines[lineNumber] = string.sub(lineText, 1, i + 1)
        end
        vim.api.nvim_buf_set_lines(0, 0, #lines, true, lines)

        ::continue::
    end
end
