local M = {}

local keyset = vim.keymap.set

function M.setup()
    --[[
    一些 vim 的设置需要在 UI 完全打开后才能被正确初始化，比如 columns，在通过 neovim-qt 时，只有窗口创建完毕之后，它的值才有效
    --]]
    vim.api.nvim_create_autocmd("UIEnter", { pattern = "*", callback = M.config })
end

function M.config()
    local options = { silent = true, unique = true, noremap = true }

    keyset({ "n", "i" }, "<C-t><C-e>", "<esc>:ToggleTerm<cr>", options)
    keyset("t", "<C-t><C-e>", "<C-\\><C-N>:ToggleTerm<cr>", options)

    -- Terminal plugin.
    require("toggleterm").setup {
        hide_numbers = true,
        shade_terminals = true,
        -- The color depth of the terminal
        shading_factor = "1",
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_szie = true,
        -- Terminal window type
        direction = "float",
        close_on_exit = true,
        -- Set the default shell.
        shell = vim.o.shell,
        -- Terminal's popup settings.
        float_opts = {
            border = "rounded",
            width = math.floor(vim.o.columns / 5 * 4),
            height = math.floor(vim.o.lines / 5 * 4),
            -- transparency
            winblend = 0,
        },
        highlights = {
            NormalFloat = {
                guifg = "#DCDCDC",
                guibg = "#2C2C2C",
            },
            FloatBorder = {
                guifg = "#CCCCCC",
                guibg = "#2C2C2C",
            },
        },
        on_create = require("aszswaz.event").toggleterm_open,
    }
end

return M
