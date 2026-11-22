return {
    "cbochs/grapple.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        scope = "git",
    },
    keys = {
        { "<leader>m", "<cmd>Grapple toggle<CR>",         desc = "Toggle file tag" },
        { "<leader>M", "<cmd>Grapple toggle_tags<CR>",    desc = "Tags window" },
        { "<leader>1", "<cmd>Grapple select index=1<CR>", desc = "Select tag 1" },
        { "<leader>2", "<cmd>Grapple select index=2<CR>", desc = "Select tag 2" },
        { "<leader>3", "<cmd>Grapple select index=3<CR>", desc = "Select tag 3" },
        { "<leader>4", "<cmd>Grapple select index=4<CR>", desc = "Select tag 4" },
        { "<leader>5", "<cmd>Grapple select index=5<CR>", desc = "Select tag 5" },
        { "<leader>6", "<cmd>Grapple select index=6<CR>", desc = "Select tag 6" },
    },
}
