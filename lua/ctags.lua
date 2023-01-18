local job = require "util.job"

local M = {}

function M.update()
    local ctags = "ctags -f "
        .. vim.fn.stdpath "config"
        .. "/tags"
        .. " -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R /usr/include"
    job.start(ctags)
end

return {
    update = M.update,
}
