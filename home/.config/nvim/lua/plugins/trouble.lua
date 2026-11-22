return {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
        position = "bottom",
        height = 10,
        icons = {
            indent = {
                top = " ",
                middle = " ",
                last = " ",
                fold_open = " ",
                fold_closed = " ",
                ws = "  ",
            },
        },
        modes = {
            diagnostics_workspace = {
                mode = "diagnostics",
                filter = { any = { buf = 0 } },
            },
        },
    },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics (Trouble)" },
    },
}
