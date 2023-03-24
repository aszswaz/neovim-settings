local log = require "aszswaz.logger"
local errorCode = require "aszswaz.error-code"

local M = {}

-- 格式化当前缓冲区中的所有文本
function M.format(isFormatexpr)
    local currentBuf = vim.api.nvim_get_current_buf()

    if not vim.api.nvim_buf_get_option(currentBuf, "modifiable") then
        error "the current buffer is read-only"
        return
    end

    local lineCount = vim.api.nvim_buf_line_count(currentBuf)
    local status, result = pcall(M._format, vim.api.nvim_buf_get_lines(currentBuf, 0, lineCount, true))
    if status then
        -- 将格式化后的文本更新到缓冲区
        for index, newLine in pairs(result) do
            vim.fn.setbufline(currentBuf, index, newLine)
        end
        -- 删除多余的文本
        if lineCount > #result then
            vim.fn.deletebufline(currentBuf, #result + 1, lineCount)
        end
    elseif isFormatexpr and result.code == errorCode.FORMAT_FILE_TYPE_ERROR then
        -- 通过 gq 或 autoformat 调用本函数，当文件类型不支持格式化时，返回 true 让 neovim 使用内部格式机制
        return true
    else
        log.error(result.msg)
    end
end

-- Copy a line of text.
function M.copyLine()
    local currentWin = vim.api.nvim_get_current_win()
    local cursor = vim.api.nvim_win_get_cursor(currentWin)
    vim.fn.append(cursor[1], vim.api.nvim_get_current_line())
    cursor[1] = cursor[1] + 1
    vim.api.nvim_win_set_cursor(currentWin, cursor)
end

-- Remove trailing spaces.
function M.trim(buffer)
    if buffer == nil then
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
        local lineLen = vim.fn.strchars(lineText)
        if lineLen == 0 then
            goto continue
        end

        local lastCharIndex = lineLen - 1
        local charIndex = lastCharIndex
        while charIndex >= 0 and vim.fn.strgetchar(lineText, charIndex) == 32 do
            charIndex = charIndex - 1
        end

        if charIndex == -1 then
            -- 整行都是空格，没有非空格字符
            vim.fn.setbufline(buffer, lineNumber, "")
        elseif charIndex ~= lastCharIndex then
            vim.fn.setbufline(buffer, lineNumber, vim.fn.strcharpart(lineText, 0, charIndex + 1))
        end

        ::continue::
    end
end

function M._format(content)
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
        command = "astyle -s" .. tabstop .. " -A2 -C -xG -S -K -N -L -xw -w -p -xg -H -U -k3 -W3 -xL -xC" .. textwidth
    elseif filetype == "sh" or filetype == "zsh" or filetype == "bash" or filetype == "PKGBUILD" then
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
    elseif filetype == "go" then
        command = "gofmt"
    else
        error { msg = "unsupported file tyle: " .. filetype, code = errorCode.FORMAT_FILE_TYPE_ERROR }
    end

    local output = vim.fn.systemlist(command, content)
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        return output
    elseif #output > 0 then
        error { msg = vim.fn.join(output, "\n"), code = errorCode.FORMAT_SHELL_ERROR }
    end
    error { msg = command .. ": formatting failed", code = errorCode.FORMAT_SHELL_ERROR }
end

return {
    format = M.format,
    copyLine = M.copyLine,
    trim = M.trim,
    trimAll = M.trimAll,
}
