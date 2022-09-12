require "utils/job"

Ctags = {}
function Ctags:update()
    local ctags = "ctags -f "
        .. vim.g.tags_file
        .. " -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R /usr/include"
    job.start(ctags)
end
