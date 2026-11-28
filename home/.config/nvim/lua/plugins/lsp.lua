return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			},
			inlay_hints = { enabled = true, exclude = {} },
			codelens = { enabled = true },
			folds = { enabled = false },

			-- Per-server config. "*" applies to all servers.
			-- Set `mason = false` to skip installing via mason, `enabled = false` to disable.
			servers = {
				["*"] = {
					capabilities = {
						workspace = {
							fileOperations = { didRename = true, willRename = true },
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							codeLens = { enable = true },
							completion = { callSnippet = "Replace" },
							doc = { privateName = { "^_" } },
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},

			-- Custom setup per server. Return true to skip the default setup.
			setup = {
				-- tsserver = function(_, server_opts)
				--   require("typescript").setup({ server = server_opts })
				--   return true
				-- end,
			},
		},

		config = function(_, opts)
			---------------------------------------------------------------------------
			-- Keymaps + per-buffer features (run when a server attaches)
			---------------------------------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(ev)
					local buf = ev.buf
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if not client then
						return
					end

					local function map(mode, lhs, rhs, desc, method)
						-- `method` = only map if the server supports it
						if method and not client:supports_method(method, buf) then
							return
						end
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "Goto Definition", "textDocument/definition")
					map("n", "gr", vim.lsp.buf.references, "References")
					map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
					map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
					map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "gK", vim.lsp.buf.signature_help, "Signature Help", "textDocument/signatureHelp")
					map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help", "textDocument/signatureHelp")
					map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action", "textDocument/codeAction")
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename", "textDocument/rename")
					map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens", "textDocument/codeLens")
					map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh Codelens", "textDocument/codeLens")
					map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")

					map("n", "<leader>cA", function()
						vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
					end, "Source Action", "textDocument/codeAction")

					map("n", "<leader>co", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = { only = { "source.organizeImports" }, diagnostics = {} },
						})
					end, "Organize Imports", "textDocument/codeAction")

					-- Inlay hints
					if
						opts.inlay_hints.enabled
						and client:supports_method("textDocument/inlayHint", buf)
						and vim.bo[buf].buftype == ""
						and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buf].filetype)
					then
						vim.lsp.inlay_hint.enable(true, { bufnr = buf })
					end

					-- LSP folding (window-local)
					if opts.folds.enabled and client:supports_method("textDocument/foldingRange", buf) then
						local win = vim.api.nvim_get_current_win()
						vim.wo[win][0].foldmethod = "expr"
						vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
					end

					-- Code lens
					if
						opts.codelens.enabled
						and vim.lsp.codelens
						and client:supports_method("textDocument/codeLens", buf)
					then
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = buf,
							callback = vim.lsp.codelens.refresh,
						})
					end
				end,
			})

			---------------------------------------------------------------------------
			-- Diagnostics
			---------------------------------------------------------------------------
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			---------------------------------------------------------------------------
			-- Servers
			---------------------------------------------------------------------------
			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			local mason_all = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
			local mason_exclude = {}

			---@return boolean? true if mason should install this server
			local function configure(server)
				if server == "*" then
					return false
				end

				local sopts = opts.servers[server]
				sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

				if sopts.enabled == false then
					mason_exclude[#mason_exclude + 1] = server
					return
				end

				local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
				local setup = opts.setup[server] or opts.setup["*"]
				if setup and setup(server, sopts) then
					mason_exclude[#mason_exclude + 1] = server
				else
					vim.lsp.config(server, sopts)
					if not use_mason then
						vim.lsp.enable(server)
					end
				end
				return use_mason
			end

			local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))

			require("mason-lspconfig").setup({
				ensure_installed = install,
				automatic_enable = { exclude = mason_exclude },
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function() end,
	},
}
