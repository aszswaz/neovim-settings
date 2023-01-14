local log = require "Logger"
local util = require "util"

local strchars = vim.fn.strchars
local strlen = vim.fn.strlen
local setbufline = vim.fn.setbufline
local deletebufline = vim.fn.deletebufline
local systemlist = vim.fn.systemlist
local getbufline = vim.fn.getbufline
local strgetchar = vim.fn.strgetchar
local strcharpart = vim.fn.strcharpart
local append = vim.fn.append
local getbufinfo = vim.fn.getbufinfo
local getreg = vim.fn.getreg

local inspect = vim.inspect
local cmd = vim.cmd

local getCurrentBuf = vim.api.nvim_get_current_buf
local bufLineCount = vim.api.nvim_buf_line_count
local getVvar = vim.api.nvim_get_vvar
local bufGetLines = vim.api.nvim_buf_get_lines
local bufSetText = vim.api.nvim_buf_set_text
local winGetCursor = vim.api.nvim_win_get_cursor
local winSetCursor = vim.api.nvim_win_set_cursor
local getCurrentLine = vim.api.nvim_get_current_line
local getCurrentWin = vim.api.nvim_get_current_win

local M = {}

-- Format files via external tools.
function M.format()
    local filetype = vim.o.filetype
    local textwidth = vim.o.textwidth
    local tabstop = vim.o.tabstop
    local command = nil
    local currentBuf = getCurrentBuf()

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

    local lineCount = bufLineCount(currentBuf)
    local output = systemlist(command, bufGetLines(currentBuf, 0, lineCount, true))
    if getVvar "shell_error" == 0 then
        -- 将格式化后的文本更新到缓冲区
        for index, newLine in pairs(output) do
            setbufline(currentBuf, index, newLine)
        end
        -- 删除多余的文本
        if lineCount > #output then
            deletebufline(currentBuf, #output + 1, lineCount)
        end
    elseif #output > 0 then
        log.error(output)
    end
end

-- Copy a line of text.
function M.copyLine()
    local currentWin = getCurrentWin()
    local cursor = winGetCursor(currentWin)
    append(cursor[1], getCurrentLine())
    cursor[1] = cursor[1] + 1
    winSetCursor(currentWin, cursor)
end

-- Remove trailing spaces.
function M.trim(buffer)
    if buffer == nil then
        buffer = getCurrentBuf()
    end

    -- Remove all trailing whitespace.
    -- If all lines are fetched from the buffer first, and then all trailing spaces are removed,
    -- it will lead to high performance consumption when processing large amounts of text,
    -- and neovim is at risk of being killed by the operating system.
    -- This way of reading one line, and processing one line, the performance consumption is the smallest.
    local lineCount = bufLineCount(buffer)
    for lineNumber = 1, lineCount do
        local lineText = getbufline(buffer, lineNumber)[1]
        local lineLen = strchars(lineText)
        if lineLen == 0 then
            goto continue
        end

        local lastCharIndex = lineLen - 1
        local charIndex = lastCharIndex
        while charIndex >= 0 and strgetchar(lineText, charIndex) == 32 do
            charIndex = charIndex - 1
        end

        if charIndex == -1 then
            -- 整行都是空格，没有非空格字符
            setbufline(buffer, lineNumber, "")
        elseif charIndex ~= lastCharIndex then
            setbufline(buffer, lineNumber, strcharpart(lineText, 0, charIndex + 1))
        end

        ::continue::
    end
end

-- Remove trailing whitespace in all buffers.
function M.trimAll()
    local bufferInfos = getbufinfo { buflisted = true, bufloaded = true }
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
}
