command! CtagsUpdate lua ctags.update()
command! FileFormat lua text.format()

command! -nargs=1 TemplateNew lua template.new(<q-args>)
command! -nargs=1 TemplateEdit lua template.new(<q-args>)
command! TemplateList lua template.list()
command! -nargs=1 TemplateUse lua template.use(<q-args>)
command! -nargs=1 TemplateDelete lua template.delete(<q-args>)
command! TemplateCommit lua template.commit()

command! CmakeInit lua cmake.init()
command! CmakeBuild lua cmake.build()
command! CmakeClean lua cmake.clean()
