local M = {}

function M.setup()
    require("project").setup {
        autostart = { "~/Documents/project/aszswaz", "~/Documents/project/neovim" },
        shell = "/bin/bash",
    }
end

return M
