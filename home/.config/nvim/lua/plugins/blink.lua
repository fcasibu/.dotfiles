return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts_extend = { "sources.default" },
		opts = {
			keymap = {
				preset = "super-tab",
				["<C-y>"] = { "select_and_accept", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				trigger = { show_in_snippet = false },
				ghost_text = {
					enabled = true,
				},
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 500,
				},
				menu = {
					auto_show = true,
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
						components = {
							kind_icon = { ellipsis = false },
						},
					},
				},
				list = {
					selection = { preselect = true, auto_insert = true },
				},
			},
			sources = {
				default = { "lsp", "buffer", "path" },
				per_filetype = {
					sql = { "dadbod", "buffer" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
			cmdline = {
				enabled = true,
				sources = { "cmdline", "buffer" },
				completion = { menu = { auto_show = true } },
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
			signature = { enabled = true },
			snippets = { preset = "default" },
		},
	},
	{
		enabled = false,
		"saghen/blink.indent",
		--- @module 'blink.indent'
		--- @type blink.indent.Config
		opts = {
			scope = {
				enabled = true,
			},
		},
	},
}
