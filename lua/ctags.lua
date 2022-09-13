require "utils/job"

Ctags = {}
local tagsFile = vim.fn.stdpath("config") .. "/tags"

function Ctags:update()
    local ctags = "ctags -f "
        .. tagsFile
        .. " -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R /usr/include"
    job.start(ctags)
end
