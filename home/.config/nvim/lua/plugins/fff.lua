return {
    {
        "dmtrKovalenko/fff.nvim",
        enabled = false,
        lazy = false,
        build = function()
            require("fff.download").download_or_build_binary()
        end,
        keys = {
            { "<leader>ff", function() require("fff").find_files() end,                                    desc = "Find files" },
            { "<leader>fg", function() require("fff").live_grep() end,                                     desc = "Live grep" },
            { "<leader>fw", function() require("fff").live_grep({ query = vim.fn.expand("<cword>") }) end, desc = "Grep word under cursor" },
            {
                "<leader>fd",
                function()
                    local dir = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir")
                    if dir and dir ~= "" then
                        require("fff").find_files_in_dir(dir)
                    end
                end,
                desc = "Find files in directory"
            },
            {
                "<leader>fD",
                function()
                    local dir = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir")
                    if dir and dir ~= "" then
                        require("fff").live_grep({ cwd = dir })
                    end
                end,
                desc = "Live grep in directory"
            },
        },
        opts = {
            debug = {
                enabled = false,
                show_scores = false,
            },
            prompt_vim_mode = true,
            layout = {
                anchor = "top",
                width = 1.0,
                height = 0.5,
            },
        },
    },
}
