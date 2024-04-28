local template = require "aszswaz.template"
local log = require "aszswaz.logger"
local theme = require "aszswaz.theme"

local M = {}

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
        name = "TemplateOpen",
        action = function(argv)
            template.open(argv.args)
        end,
        attributes = {
            nargs = 1,
            desc = "Create template.",
            complete = template.list,
        },
    },
    {
        name = "TemplateList",
        action = function()
            for _, iterm in pairs(template.list()) do
                print(iterm)
            end
        end,
        attributes = {
            desc = "View all templates.",
        },
    },
    {
        name = "TemplateUse",
        action = function(argv)
            local args = argv.fargs
            template.use(args[1], args[2])
        end,
        attributes = {
            nargs = "+",
            desc = "使用模板创建文件",
            complete = template.list,
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
            complete = template.list,
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

function M.setup()
    for _, command in pairs(COMMANDS) do
        vim.api.nvim_create_user_command(command.name, command.action, command.attributes)
    end
end
return M
