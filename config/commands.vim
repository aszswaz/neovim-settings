command! CtagsUpdate lua Ctags:update()
command! FileFormat lua text.format()

command! -nargs=1 TemplateNew lua Template:new(<q-args>)
command! -nargs=1 TemplateEdit lua Template:new(<q-args>)
command! TemplateList lua Template:list()
command! -nargs=1 TemplateUse lua Template:use(<q-args>)
command! -nargs=1 TemplateDelete lua Template:delete(<q-args>)
command! TemplateCommit lua Template:commit()

command! CmakeInit lua cmake.init()
command! CmakeBuild lua cmake.build()
command! CmakeClean lua cmake.clean()
