return {
    "MagicDuck/grug-far.nvim",
    keys = {
        { "<leader>gf", "<cmd>GrugFar<CR>", desc = "Search and Replace" },
        {
            "<leader>gF",
            function()
                require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
            end,
            desc = "Search and Replace (word under cursor)"
        },
    },
}
