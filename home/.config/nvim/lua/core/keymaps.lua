vim.keymap.set({ "n", "v", "o" }, "<C-s>", "}", { desc = "Jump down to next blank line" })
vim.keymap.set({ "n", "v", "o" }, "<C-p>", "{", { desc = "Jump up to next blank line" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", function()
	vim.cmd("nohlsearch")
	vim.cmd("redraw!")
	vim.cmd("wincmd l")
end, { desc = "Redraw + window right" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>vv", "<cmd>split<CR>", { desc = "Horizontal split" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>", { desc = "Prev quickfix" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up", silent = true })

local brackets = {
	["("] = true,
	[")"] = true,
	["["] = true,
	["]"] = true,
	["{"] = true,
	["}"] = true,
	["<"] = true,
	[">"] = true,
	["'"] = true,
	['"'] = true,
	["`"] = true,
}
local function exec_b(key)
	local col = vim.fn.col(".")
	local left_char = vim.api.nvim_get_current_line():sub(col - 1, col - 1)

	if key == "d" then
		if brackets[left_char] then
			return "xh"
		end

		return key .. "bxh"
	end

	return "vb" .. key
end

local function exec_w(key)
	local col = vim.fn.col(".")
	local right_char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

	if key == "d" and brackets[right_char] then
		return "x"
	end

	return key .. "w"
end

vim.keymap.set("n", "dw", function()
	return exec_w("d")
end, { desc = "Forward delete", expr = true })
vim.keymap.set("n", "db", function()
	return exec_b("d")
end, { desc = "Backward delete", expr = true })
vim.keymap.set("n", "yw", function()
	return exec_w("y")
end, { desc = "Forward yank", expr = true })
vim.keymap.set("n", "yb", function()
	return exec_b("y")
end, { desc = "Forward yank", expr = true })
vim.keymap.set("n", "cw", function()
	return exec_w("c")
end, { desc = "Forward change", expr = true })
vim.keymap.set("n", "cb", function()
	return exec_b("c")
end, { desc = "Backward change", expr = true })

local function scroll_move(direction)
	local count = math.floor(vim.api.nvim_win_get_height(0) / 3)
	vim.api.nvim_feedkeys(count .. direction, "n", false)
end

vim.keymap.set({ "n", "v" }, "<C-U>", function()
	scroll_move("k")
end, { desc = "Scroll up 1/3 screen" })
vim.keymap.set({ "n", "v" }, "<C-D>", function()
	scroll_move("j")
end, { desc = "Scroll down 1/3 screen" })

vim.keymap.set({ "n", "v" }, "<C-f>", function()
	if vim.fn.getcmdwintype() == "" then
		vim.api.nvim_feedkeys("q:<CR>", "n", false)

		vim.schedule(function()
			vim.cmd("startinsert!")
		end)
	else
		vim.cmd("quit")
	end
end, { desc = "Toggle command history" })

local scratch_path = "/tmp/nvim-scratch.md"
local augroup = vim.api.nvim_create_augroup("nvim_scratch_persist", { clear = true })
local scratch_buf = -1

local function toggle_scratch()
	local buf = -1
	local win = -1

	local function create_buf()
		buf = vim.api.nvim_create_buf(false, true)
		pcall(vim.api.nvim_buf_set_name, buf, scratch_path)
		scratch_buf = buf

		local bo = vim.bo[buf]
		bo.buftype = "acwrite"
		bo.filetype = "markdown"
		bo.bufhidden = "hide"
		bo.swapfile = false

		local ok, lines = pcall(vim.fn.readfile, scratch_path)
		if ok and #lines > 0 then
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		end

		vim.api.nvim_create_autocmd("BufWriteCmd", {
			group = augroup,
			buffer = buf,
			callback = function()
				vim.fn.writefile(vim.api.nvim_buf_get_lines(buf, 0, -1, false), scratch_path)
				vim.bo[buf].modified = false
			end,
		})
	end

	return function()
		if win ~= -1 and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
			win = -1
			return
		end

		if buf == -1 or not vim.api.nvim_buf_is_valid(buf) then
			create_buf()
		end

		local ui = vim.api.nvim_list_uis()[1]
		local width = math.floor(ui.width * 0.8)
		local height = math.floor(ui.height * 0.8)
		local row = math.floor((ui.height - height) / 2)
		local col = math.floor((ui.width - width) / 2)

		win = vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = width,
			height = height,
			row = row,
			col = col,
			style = "minimal",
			border = "single",
		})
	end
end

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = augroup,
	callback = function()
		if scratch_buf == -1 or not vim.api.nvim_buf_is_valid(scratch_buf) then
			return
		end
		pcall(vim.fn.writefile, vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false), scratch_path)
	end,
})

vim.keymap.set("n", "<leader>ts", toggle_scratch(), { desc = "Toggle scratch buffer" })

-- ---------------------------------------------------------- --
--                         Treesitter                         --
-- ---------------------------------------------------------- --

vim.keymap.set({ "n", "x", "o" }, "<C-Space>", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end, { desc = "Increment Selection" })

vim.keymap.set({ "n", "x", "o" }, "<BS>", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end, { desc = "Decrement Selection" })
