return {
    {
        name = "colors",
        dir = vim.fn.stdpath("config"),
        lazy = false,
        priority = 1000,
        config = function()
            require("core.colors").load()
        end,
    },
}
