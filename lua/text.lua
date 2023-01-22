local log = require "logger"

local M = {}

-- Format files via external tools.
function M.format()
    local filetype = vim.o.filetype
    local textwidth = vim.o.textwidth
    local tabstop = vim.o.tabstop
    local command = nil
    local currentBuf = vim.api.nvim_get_current_buf()

    if not vim.api.nvim_buf_get_option(currentBuf, "modifiable") then
        log.error "The current buffer is read-only."
        return
    end

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
        command = "astyle -s" .. tabstop .. " -A2 -C -xG -S -K -N -L -xw -w -p -xg -H -U -k3 -W3" .. " -xL -xC" .. textwidth
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
    else
        log.error("Unsupported file tyle: " .. filetype)
        return
    end

    local lineCount = vim.api.nvim_buf_line_count(currentBuf)
    local output = vim.fn.systemlist(command, vim.api.nvim_buf_get_lines(currentBuf, 0, lineCount, true))
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        -- 将格式化后的文本更新到缓冲区
        for index, newLine in pairs(output) do
            vim.fn.setbufline(currentBuf, index, newLine)
        end
        -- 删除多余的文本
        if lineCount > #output then
            vim.fn.deletebufline(currentBuf, #output + 1, lineCount)
        end
    elseif #output > 0 then
        log.error(output)
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

-- Remove trailing whitespace in all buffers.
function M.trimAll()
    local bufferInfos = vim.fn.getbufinfo { buflisted = true, bufloaded = true }
    for index, iterm in pairs(bufferInfos) do
        if iterm.changed then
            M.trim(iterm.bufnr)
        end
    end
end

return {
    format = M.format,
    copyLine = M.copyLine,
    trim = M.trim,
    trimAll = M.trimAll,
    unpair = M.unpair,
}
