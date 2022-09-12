command! CtagsUpdate lua Ctags:update()
command! FileFormat lua FileFormat()

command! -nargs=1 TemplateNew lua Template:new(<args>)
command! -nargs=1 TemplateEdit lua Template:new(<args>)
command! TemplateList lua Template:list()
command! -nargs=1 TemplateUse lua Template:use(<args>)
command! -nargs=1 TemplateDelete lua Template:delete(<args>)
command! TemplateCommit lua Template:commit()
