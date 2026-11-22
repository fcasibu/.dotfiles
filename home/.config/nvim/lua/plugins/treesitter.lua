return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		config = function()
			local ts_textobj = require("nvim-treesitter-textobjects")
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			ts_textobj.setup({
				select = { enable = true, lookahead = true },
				move = { enable = true, set_jumps = true },
				swap = { enable = true },
			})

			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer")
			end, { desc = "around function" })
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner")
			end, { desc = "inner function" })
			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer")
			end, { desc = "around class" })
			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner")
			end, { desc = "inner class" })
			vim.keymap.set({ "x", "o" }, "ab", function()
				select.select_textobject("@block.outer")
			end, { desc = "around block" })
			vim.keymap.set({ "x", "o" }, "ib", function()
				select.select_textobject("@block.inner")
			end, { desc = "inner block" })
			vim.keymap.set({ "x", "o" }, "aa", function()
				select.select_textobject("@parameter.outer")
			end, { desc = "around parameter" })
			vim.keymap.set({ "x", "o" }, "ia", function()
				select.select_textobject("@parameter.inner")
			end, { desc = "inner parameter" })
			vim.keymap.set({ "x", "o" }, "al", function()
				select.select_textobject("@conditional.outer")
			end, { desc = "around conditional" })
			vim.keymap.set({ "x", "o" }, "il", function()
				select.select_textobject("@conditional.inner")
			end, { desc = "inner conditional" })
			vim.keymap.set({ "x", "o" }, "aL", function()
				select.select_textobject("@loop.outer")
			end, { desc = "around loop" })
			vim.keymap.set({ "x", "o" }, "iL", function()
				select.select_textobject("@loop.inner")
			end, { desc = "inner loop" })
			vim.keymap.set({ "x", "o" }, "ar", function()
				select.select_textobject("@return.outer")
			end, { desc = "around return" })
			vim.keymap.set({ "x", "o" }, "ir", function()
				select.select_textobject("@return.inner")
			end, { desc = "inner return" })

			vim.keymap.set("n", "]f", function()
				move.goto_next_start("@function.outer")
			end, { desc = "next function start" })
			vim.keymap.set("n", "[f", function()
				move.goto_previous_start("@function.outer")
			end, { desc = "prev function start" })
			vim.keymap.set("n", "]a", function()
				move.goto_next_start("@parameter.outer")
			end, { desc = "next parameter" })
			vim.keymap.set("n", "[a", function()
				move.goto_previous_start("@parameter.outer")
			end, { desc = "prev parameter" })
			vim.keymap.set("n", "]F", function()
				move.goto_next_end("@function.outer")
			end, { desc = "next function end" })
			vim.keymap.set("n", "[F", function()
				move.goto_previous_end("@function.outer")
			end, { desc = "prev function end" })

			vim.keymap.set("n", "<leader>sn", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "swap param next" })
			vim.keymap.set("n", "<leader>sp", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "swap param prev" })
		end,
	},
	{
		"romus204/tree-sitter-manager.nvim",
		event = "VeryLazy",
		config = function()
			require("tree-sitter-manager").setup({
				ensure_installed = {
					"lua",
					"c",
					"cpp",
					"rust",
					"javascript",
					"typescript",
					"tsx",
				},
			})
		end,
	},
}
