local event = require "aszswaz.event"

local M = {}

local keyset = vim.keymap.set

function M.setup()
    local options = { silent = true, unique = true, noremap = true }

    keyset({ "n", "i" }, "<A-c>", event.closeBuffer, options)
    keyset({ "n", "i" }, "<A-c-o>", event.closeOtherBuffer, options)
    keyset({ "n", "i" }, "<A-Left>", vim.cmd.BufferPrevious, options)
    keyset({ "n", "i" }, "<A-Right>", vim.cmd.BufferNext, options)
    keyset({ "n", "i" }, "<A-9>", vim.cmd.BufferLast, options)
    keyset({ "n", "i" }, "<C-A-Left>", vim.cmd.BufferMove, options)
    keyset({ "n", "i" }, "<C-A-Right>", vim.cmd.BufferMoveNext, options)
    keyset({ "n", "i" }, "<A-p>", vim.cmd.BufferPin, options)

    -- 注册跳转到指定 buffer 的快捷键
    for index = 1, 8 do
        keyset({ "n", "i" }, "<A-" .. index .. ">", function()
            vim.cmd.BufferGoto(index)
        end, options)
    end

    -- Plugins that use buffer as tab.
    require("bufferline").setup {
        animation = true,
        auto_hide = false,
        tabpages = true,
        closable = true,
        clickable = true,
        exclude_ft = { "qf", "fugitive" },
        exclude_name = {},
        icons = {
            button = "",
            filetype = {
                enable = true,
            },
            modified = {
                button = "●",
            },
            separator = {
                left = "▎",
            },
            pinned = {
                button = "車",
            },
            inactive = {
                separator = {
                    left = "▎",
                },
            },
        },
        icon_custom_colors = false,
        insert_at_end = true,
        insert_at_start = false,
        maximum_padding = 1,
        maximum_length = 30,
        semantic_letters = true,
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
        no_name_title = nil,
    }
end

return M
