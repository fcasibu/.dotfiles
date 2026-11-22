return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    keys = {
        {
            "<C-e>",
            function()
                if vim.bo.filetype == "oil" then
                    vim.cmd("bd!")
                else
                    require("oil").open()
                end
            end,
            desc = "Toggle oil.nvim",
        },
    },
    opts = {
        default_file_explorer = true,
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["gF"] = {
                desc = "Find files in directory",
                mode = "n",
                callback = function()
                    local oil = require("oil")
                    local entry = oil.get_cursor_entry()
                    local dir
                    if entry and entry.type == "directory" then
                        dir = entry.path
                    else
                        dir = oil.get_current_dir()
                    end
                    if dir then
                        Snacks.picker.files({ cwd = dir, hidden = true })
                    end
                end,
            },
            ["g/"] = {
                desc = "Live grep in directory",
                mode = "n",
                callback = function()
                    local oil = require("oil")
                    local entry = oil.get_cursor_entry()
                    local dir
                    if entry and entry.type == "directory" then
                        dir = entry.path
                    else
                        dir = oil.get_current_dir()
                    end
                    if dir then
                        Snacks.picker.grep({ cwd = dir })
                    end
                end,
            },
        },
    },
}
