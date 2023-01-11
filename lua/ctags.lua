local job = require "utils/job"

local M = {}
local tagsFile = vim.fn.stdpath "config" .. "/tags"

function M.update()
    local ctags = "ctags -f "
        .. tagsFile
        .. " -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R /usr/include"
    job.start(ctags)
end
