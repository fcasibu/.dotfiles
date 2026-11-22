return {
    {
        dir = vim.fn.stdpath("config") .. "/lua/comments",
        config = function()
            require('comments').setup()
        end
    },
    {
        "fangjunzhou/comment-divider.nvim",
        config = function()
            vim.keymap.set("n", "<leader>sb", ":CommentDividerBox<CR>", { desc = "Box separator" })
            vim.keymap.set("n", "<leader>sl", ":CommentDividerLine<CR>", { desc = "Line separator" })
        end,
    }
}
