return {
    {
        "mfussenegger/nvim-dap",
        cmd = "DapContinue",
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Conditional breakpoint"
            },
            { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
            { "<leader>do", function() require("dap").step_over() end,         desc = "Step over" },
            { "<leader>di", function() require("dap").step_into() end,         desc = "Step into" },
            { "<leader>dO", function() require("dap").step_out() end,          desc = "Step out" },
            { "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate" },
            { "<leader>dr", function() require("dap").restart() end,           desc = "Restart" },
            { "<leader>dh", function() require("dap").hover() end,             desc = "Hover variable",   mode = { "n", "v" } },
            {
                "<leader>dR",
                function()
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "dap-repl" then
                            vim.api.nvim_win_close(win, true)
                            return
                        end
                    end
                    require("dap").repl.open()
                end,
                desc = "Toggle REPL"
            },
        },
        config = function()
            local dap = require("dap")

            -- codelldb adapter for Rust/C++ debugging (installed via mason)
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            -- js-debug-adapter for TypeScript/JavaScript debugging (installed via mason)
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "js-debug-adapter",
                    args = { "${port}" },
                },
            }

            -- Rust launch configurations
            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            -- C/C++ launch configurations (deep copy to avoid shared table references)
            dap.configurations.c = vim.deepcopy(dap.configurations.rust)
            dap.configurations.cpp = vim.deepcopy(dap.configurations.rust)

            -- TypeScript/JavaScript launch configurations
            local js_configs = {
                {
                    name = "Launch file",
                    type = "pwa-node",
                    request = "launch",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                },
                {
                    name = "Launch with args",
                    type = "pwa-node",
                    request = "launch",
                    program = "${file}",
                    args = function()
                        local args_str = vim.fn.input("Arguments: ")
                        return vim.split(args_str, " ")
                    end,
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                },
            }
            dap.configurations.typescript = vim.deepcopy(js_configs)
            dap.configurations.javascript = vim.deepcopy(js_configs)
            dap.configurations.typescriptreact = vim.deepcopy(js_configs)
            dap.configurations.javascriptreact = vim.deepcopy(js_configs)

            -- DAP signs
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition",
                { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected",
                { text = "●", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "", numhl = "" })

            local c = require("core.colors").palette

            vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = c.red })
            vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = c.teal })
            vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = c.fg_dim })
            vim.api.nvim_set_hl(0, "DapLogPoint", { fg = c.green })
            vim.api.nvim_set_hl(0, "DapStopped", { fg = c.green })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
            { "<leader>de", function() require("dapui").eval() end,   desc = "Evaluate expression", mode = { "n", "v" } },
        },
        config = function()
            local dapui = require("dapui")
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                layouts = {
                    {
                        elements = { "scopes", "breakpoints", "stacks", "watches" },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = { "repl", "console" },
                        size = 10,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = { close = { "q", "<Esc>" } },
                },
            })

            -- Auto-open/close DAP UI with debug session
            local dap = require("dap")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- DAP UI highlights
            local hl = vim.api.nvim_set_hl
            local c = require("core.colors").palette

            hl(0, "DapUIBreakpointsPath", { fg = c.fg_dim })
            hl(0, "DapUIBreakpointsInfo", { fg = c.green })
            hl(0, "DapUIBreakpointsCurrentLine", { fg = c.teal })
            hl(0, "DapUIBreakpointsLine", { fg = c.fg_dim })
            hl(0, "DapUIScope", { fg = c.teal })
            hl(0, "DapUIType", { fg = c.teal, bold = true })
            hl(0, "DapUIName", { fg = c.fg })
            hl(0, "DapUIValue", { fg = c.fg })
            hl(0, "DapUIVariable", { fg = c.fg })
            hl(0, "DapUIWatchesValue", { fg = c.green })
            hl(0, "DapUIWatchesEmpty", { fg = c.red })
            hl(0, "DapUIModifiedValue", { fg = c.red })
            hl(0, "DapUIStoppedThread", { fg = c.teal })
            hl(0, "DapUISource", { fg = c.teal })
            hl(0, "DapUILineNumber", { fg = c.fg_dim })
            hl(0, "DapUIFloatBorder", { fg = c.fg_dim })
            hl(0, "DapUIThread", { fg = c.teal })
            hl(0, "DapUIEndOfBuffer", { fg = c.fg_dim })
            hl(0, "DapUIPlayPause", { fg = c.green })
            hl(0, "DapUIRestart", { fg = c.green })
            hl(0, "DapUIStepOver", { fg = c.teal })
            hl(0, "DapUIStepInto", { fg = c.teal })
            hl(0, "DapUIStepBack", { fg = c.teal })
            hl(0, "DapUIStepOut", { fg = c.teal })
            hl(0, "DapUIStop", { fg = c.red })
            hl(0, "DapUIUnavailable", { fg = c.fg_dim })
            hl(0, "DapUIWinSelect", { fg = c.fg, bg = c.bg, bold = true })
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        cmd = "DapContinue",
        opts = {
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            show_stop_reason = true,
            virt_text_pos = "eol",
            all_frames = true,
            virt_lines = false,
            highlight_new_as_changed = false,
        },
    },
    {
        "williamboman/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        cmd = "DapInstall",
        config = function()
            require("mason-nvim-dap").setup({
                automatic_installation = true,
                handlers = {},
            })
        end,
    },
}
