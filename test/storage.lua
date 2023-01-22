local storage = require "util.storage"

function test01()
    storage.set("demo", { demo01 = "Hello World", demo02 = "Hello World" })
    print(vim.inspect(storage.get "demo"))
end

function test02()
    storage.save()
end
