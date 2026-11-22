return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GRename", "GDelete", "Gblame" },
        keys = {
            { "<leader>gs", "<cmd>Git<CR>",         desc = "Git status" },
            { "<leader>gb", "<cmd>Git blame<CR>",   desc = "Git blame" },
            { "<leader>gd", "<cmd>Gdiffsplit<CR>",  desc = "Git diff (split)" },
            { "<leader>gl", "<cmd>Git log<CR>",     desc = "Git log" },
        },
    },
}