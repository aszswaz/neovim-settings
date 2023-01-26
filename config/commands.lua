local template = require "template"
local log = require "logger"
local theme = require "theme"

local createCommand = vim.api.nvim_create_user_command

local COMMANDS = {
    {
        name = "LoggerMesssages",
        action = log.showMessages,
        attributes = {
            desc = "View all logs.",
        },
    },
    {
        name = "ColorScheme",
        action = function(argv)
            theme.switchTheme(argv.fargs[1], argv.fargs[2])
        end,
        attributes = {
            nargs = "+",
            desc = "Switch theme.",
            complete = "color",
        },
    },
    {
        name = "TemplateNew",
        action = function(argv)
            template.new(argv.args)
        end,
        attributes = {
            nargs = 1,
            desc = "Create template.",
        },
    },
    {
        name = "TemplateList",
        action = template.list,
        attributes = {
            desc = "View all templates.",
        },
    },
    {
        name = "TemplateUse",
        action = function(argv)
            template.use(argv.args)
        end,
        attributes = {
            nargs = 1,
            desc = "Use the specified template.",
        },
    },
    {
        name = "TemplateDelete",
        action = function(argv)
            template.delete(argv.args)
        end,
        attributes = {
            nargs = 1,
            desc = "Delete the specified template.",
        },
    },
    {
        name = "TemplateCommit",
        action = template.commit,
        attributes = {
            desc = "Submit the template.",
        },
    },
}

for _, command in pairs(COMMANDS) do
    vim.api.nvim_create_user_command(command.name, command.action, command.attributes)
end
