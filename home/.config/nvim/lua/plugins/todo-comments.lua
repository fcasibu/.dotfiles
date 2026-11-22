return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        highlight = {
            pattern = [[.*<(%(KEYWORDS))%(\(\w+\))?:]],
            keyword = "fg",
            before = "",
            after = "",
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS)]],
        },
        colors = {
            error = { "#DC2626" },
            warning = { "#FBBF24" },
            info = { "#2563EB" },
            hint = { "#10B981" },
            default = { "#7C3AED" },
            test = { "#FF00FF" }
        },
    },
    keys = {
        { "<leader>xt", "<cmd>TodoQuickFix<CR>", desc = "Todo QFList" },
    },
}
