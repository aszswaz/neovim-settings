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
    elseif filetype == "xml" or filetype == "svg" then
        command = "xmllint --encode UTF-8 --format -"
    elseif filetype == "cpp" or filetype == "c" then
        command = "astyle -s"
            .. tabstop
            .. " -A2 -C -xG -S -K -N -L -xw -w -p -xg -H -U -k3 -W3"
            .. " -xL -xC"
            .. textwidth
    elseif filetype == "sh" or filetype == "zsh" or filetype == "bash" or PKGBUILD == "PKGBUILD" then
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

    local lineCount = vim.api.nvim_buf_line_count(0)
    local output = vim.fn.systemlist(command, vim.api.nvim_buf_get_lines(0, 0, lineCount, true))
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        vim.api.nvim_buf_set_lines(0, 0, lineCount, true, output)
    elseif #output > 0 then
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

text.row.trim = function(buffer)
    if buffer == nil or buffer == 0 then
        buffer = vim.api.nvim_get_current_buf()
    end

    -- Remove all trailing whitespace.
    -- If all lines are fetched from the buffer first, and then all trailing spaces are removed,
    -- it will lead to high performance consumption when processing large amounts of text,
    -- and neovim is at risk of being killed by the operating system.
    -- This way of reading one line, and processing one line, the performance consumption is the smallest.
    local lineCount = vim.api.nvim_buf_line_count(buffer)
    for lineNumber = 1, lineCount do
        local lineText = vim.fn.getbufline(buffer, lineNumber)[1]
        local lineLen = vim.fn.strlen(lineText)
        if lineLen == 0 then
            goto continue
        end

        local lastCharIndex = lineLen - 1
        local charIndex = lastCharIndex
        while charIndex >= 0 and vim.fn.strgetchar(lineText, charIndex) == 32 do
            charIndex = charIndex - 1
        end

        if charIndex == -1 then
            -- There are no lines with non-space characters.
            vim.fn.setbufline(buffer, lineNumber, "")
        elseif charIndex ~= lastCharIndex then
            vim.fn.setbufline(buffer, lineNumber, string.sub(lineText, 1, charIndex + 1))
        end

        ::continue::
    end
end
