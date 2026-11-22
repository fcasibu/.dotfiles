return {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    opts = {
        modes = {
            char = {
                enabled = true,
            },
            search = {
                enabled = false,
            },
        },
        highlight = {
            backdrop = true,
        },
        label = {
            style = "overlay",
        },
        jump = {
            multiwindow = true,
        },
    },
}
