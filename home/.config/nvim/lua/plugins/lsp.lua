return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                check_for_updates = false,
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cmd = { "LspInstall" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "rust_analyzer",
                    "ts_ls",
                    "clangd",
                    "lua_ls",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local on_attach = function(_, bufnr)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
                vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = bufnr, desc = "Code lens" })
                vim.keymap.set("n", "<leader>crn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
                vim.keymap.set("n", "<leader>ctd", vim.lsp.buf.type_definition,
                    { buffer = bufnr, desc = "Type definition" })
                vim.keymap.set("n", "<leader>cds", vim.lsp.buf.document_symbol,
                    { buffer = bufnr, desc = "Document symbols" })
            end

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("lua_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            if vim.fn.executable("rust-analyzer") == 1 then
                vim.lsp.config("rust_analyzer", {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        ["rust-analyzer"] = {
                            check = { command = "clippy" },
                        },
                    },
                })
            end

            vim.lsp.config("ts_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("clangd", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            vim.lsp.config("ols", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            local servers = { "lua_ls", "ts_ls", "clangd", "ols" }
            if vim.fn.executable("rust-analyzer") == 1 then
                table.insert(servers, "rust_analyzer")
            end
            vim.lsp.enable(servers)
        end,
    },
}
