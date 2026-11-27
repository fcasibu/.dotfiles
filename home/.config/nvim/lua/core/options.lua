vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.hidden = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.list = false
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 3
vim.opt.guicursor = "n-v-c:hor20,i-ci-ve:ver25"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		linehl = { "DiagnosticErrorLn", "DiagnosticWarnLn", "DiagnosticInfoLn", "DiagnosticHintLn" },
	},
	update_in_insert = true,
	underline = false,
	severity_sort = true,
	float = { border = "rounded" },
})
vim.diagnostic.enable(false)
