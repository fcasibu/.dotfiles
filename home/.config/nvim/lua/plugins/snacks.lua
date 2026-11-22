return {
    {
        "folke/snacks.nvim",
        lazy = false,
        keys = {
            { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end,     desc = "Find files" },
            { "<leader>fg", function() Snacks.picker.grep({ hidden = true }) end,      desc = "Live grep" },
            { "<leader>fw", function() Snacks.picker.grep_word({ hidden = true }) end, desc = "Grep word under cursor" },
            { "<leader>fk", function() Snacks.picker.keymaps() end,                    desc = "Show keymaps" },
            {
                "<leader>fd",
                function()
                    local dir = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir")
                    if dir and dir ~= "" then
                        Snacks.picker.files({ cwd = dir, hidden = true })
                    end
                end,
                desc = "Find files in directory"
            },
            {
                "<leader>fD",
                function()
                    local dir = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir")
                    if dir and dir ~= "" then
                        Snacks.picker.grep({ cwd = dir })
                    end
                end,
                desc = "Live grep in directory"
            },
            { "<leader>fb", function() Snacks.picker.buffers() end,   desc = "Buffers" },
            { "<leader>fe", function() Snacks.picker.git_files() end, desc = "Git files" },
            { "<leader>gi", function() Snacks.picker.gh_issue() end,  desc = "GH Issues (open)" },
            { "<leader>gp", function() Snacks.picker.gh_pr() end,     desc = "GH PRs (open)" },
        },
        opts = {
            picker = {
                layout = { preset = "full_horz" },
                win = {
                    list = {
                        wo = {
                            foldenable = false,
                        },
                    },
                    preview = {
                        wo = {
                            foldenable = false,
                        },
                    },
                },
                layouts = {
                    full_horz = {
                        reverse = true,
                        layout = {
                            box = "horizontal",
                            width = 0.95,
                            height = 0.9,
                            border = "rounded",
                            {
                                box = "vertical",
                                { win = "list",  title = " Results ", title_pos = "center", border = "none" },
                                { win = "input", height = 1,          border = "none",      title = "{title} {live} {flags}", title_pos = "center" },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.6,
                                border = "none",
                                title_pos = "center",
                            },
                        },
                    },
                    full_vert = {
                        layout = {
                            backdrop = false,
                            fullscreen = true,
                            box = "vertical",
                            border = "rounded",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                            { win = "list",    border = "none" },
                            { win = "preview", title = "{preview}", height = 0.4,    border = "top" },
                            { win = "input",   height = 1,          border = "none", title = "{title} {live} {flags}", title_pos = "center" },
                        },
                    },
                },
            },
        },
    },
}
