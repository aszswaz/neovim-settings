local nvimTree = require "nvim-tree.api"

local M = {}

local keyset = vim.keymap.set

function M.setup()
    local options = { silent = true, unique = true, noremap = true }

    keyset("i", "<C-e>", "<esc>:NvimTreeOpen<cr>", options)
    keyset("n", "<C-e>", nvimTree.tree.focus, options)
    keyset({ "n", "i" }, "<C-e><C-r>", nvimTree.tree.reload, options)

    require("nvim-tree").setup {
        on_attach = M.on_attach,
        -- Enable git
        git = {
            enable = true,
            ignore = false,
        },
    }
end

-- 当打开 NvimTree 时，设置 NvimTree 缓冲区的快捷键
function M.on_attach(bufnr)
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings. Feel free to modify or remove as you wish.
    --
    -- BEGIN_DEFAULT_ON_ATTACH
    keyset("n", "<C-]>", nvimTree.tree.change_root_to_node, opts "CD")
    -- keyset("n", "<C-e>", nvimTree.node.open.replace_tree_buffer, opts "Open: In Place")
    keyset("n", "<C-e>", nvimTree.tree.close, opts "Close")
    keyset("n", "<C-k>", nvimTree.node.show_info_popup, opts "Info")
    keyset("n", "<C-r>", nvimTree.fs.rename_sub, opts "Rename: Omit Filename")
    keyset("n", "<C-t>", nvimTree.node.open.tab, opts "Open: New Tab")
    keyset("n", "<C-v>", nvimTree.node.open.vertical, opts "Open: Vertical Split")
    keyset("n", "<C-x>", nvimTree.node.open.horizontal, opts "Open: Horizontal Split")
    keyset("n", "<BS>", nvimTree.node.navigate.parent_close, opts "Close Directory")
    keyset("n", "<CR>", nvimTree.node.open.edit, opts "Open")
    keyset("n", "<Tab>", nvimTree.node.open.preview, opts "Open Preview")
    keyset("n", ">", nvimTree.node.navigate.sibling.next, opts "Next Sibling")
    keyset("n", "<", nvimTree.node.navigate.sibling.prev, opts "Previous Sibling")
    keyset("n", ".", nvimTree.node.run.cmd, opts "Run Command")
    keyset("n", "-", nvimTree.tree.change_root_to_parent, opts "Up")
    keyset("n", "a", nvimTree.fs.create, opts "Create")
    keyset("n", "bd", nvimTree.marks.bulk.delete, opts "Delete Bookmarked")
    keyset("n", "bmv", nvimTree.marks.bulk.move, opts "Move Bookmarked")
    keyset("n", "B", nvimTree.tree.toggle_no_buffer_filter, opts "Toggle No Buffer")
    keyset("n", "c", nvimTree.fs.copy.node, opts "Copy")
    keyset("n", "C", nvimTree.tree.toggle_git_clean_filter, opts "Toggle Git Clean")
    keyset("n", "[c", nvimTree.node.navigate.git.prev, opts "Prev Git")
    keyset("n", "]c", nvimTree.node.navigate.git.next, opts "Next Git")
    keyset("n", "d", nvimTree.fs.remove, opts "Delete")
    keyset("n", "D", nvimTree.fs.trash, opts "Trash")
    keyset("n", "E", nvimTree.tree.expand_all, opts "Expand All")
    keyset("n", "e", nvimTree.fs.rename_basename, opts "Rename: Basename")
    keyset("n", "]e", nvimTree.node.navigate.diagnostics.next, opts "Next Diagnostic")
    keyset("n", "[e", nvimTree.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
    keyset("n", "F", nvimTree.live_filter.clear, opts "Clean Filter")
    keyset("n", "f", nvimTree.live_filter.start, opts "Filter")
    keyset("n", "g?", nvimTree.tree.toggle_help, opts "Help")
    keyset("n", "gy", nvimTree.fs.copy.absolute_path, opts "Copy Absolute Path")
    keyset("n", "H", nvimTree.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
    keyset("n", "I", nvimTree.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
    keyset("n", "J", nvimTree.node.navigate.sibling.last, opts "Last Sibling")
    keyset("n", "K", nvimTree.node.navigate.sibling.first, opts "First Sibling")
    keyset("n", "m", nvimTree.marks.toggle, opts "Toggle Bookmark")
    keyset("n", "o", nvimTree.node.open.edit, opts "Open")
    keyset("n", "O", nvimTree.node.open.no_window_picker, opts "Open: No Window Picker")
    keyset("n", "p", nvimTree.fs.paste, opts "Paste")
    keyset("n", "P", nvimTree.node.navigate.parent, opts "Parent Directory")
    keyset("n", "q", nvimTree.tree.close, opts "Close")
    keyset("n", "r", nvimTree.fs.rename, opts "Rename")
    keyset("n", "R", nvimTree.tree.reload, opts "Refresh")
    keyset("n", "s", nvimTree.node.run.system, opts "Run System")
    keyset("n", "S", nvimTree.tree.search_node, opts "Search")
    keyset("n", "U", nvimTree.tree.toggle_custom_filter, opts "Toggle Hidden")
    keyset("n", "W", nvimTree.tree.collapse_all, opts "Collapse")
    keyset("n", "x", nvimTree.fs.cut, opts "Cut")
    keyset("n", "y", nvimTree.fs.copy.filename, opts "Copy Name")
    keyset("n", "Y", nvimTree.fs.copy.relative_path, opts "Copy Relative Path")
    keyset("n", "<2-LeftMouse>", nvimTree.node.open.edit, opts "Open")
    keyset("n", "<2-RightMouse>", nvimTree.tree.change_root_to_node, opts "CD")
    -- END_DEFAULT_ON_ATTACH

    -- Mappings migrated from view.mappings.list
    --
    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    keyset("n", "<C-e>", api.tree.close, opts "Close")
end

return M
