local cmake = require "cmake"
local ctags = require "ctags"
local template = require "template"
local util = require "util"

util.rc("CmakeInit", cmake.init, "Initialize cmake project.")
util.rc("CmakeBuild", cmake.build, "Build the cmake project.")
util.rc("CmakeClean", cmake.clean, "Clean the cmake project.")

util.rc("CtagsUpdate", ctags.update, "Updated tag files for C and C++.")

util.rcParameter("TemplateNew", template.new, "Create template.")
util.rc("TemplateList", template.list, "View all templates.")
util.rcParameter("TemplateUse", template.use, "Use the specified template.")
util.rcParameter("TemplateDelete", template.delete, "Delete the specified template.")
util.rc("TemplateCommit", template.commit, "Submit the template.")
