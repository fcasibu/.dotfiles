local M = {}

M.transparent = true

local c = {
	bg = "#0C0C0C",
	fg = "#A8B590",
	fg_dim = "#6A7A6A",
	green = "#A7C080",
	teal = "#6EA896",
	yellow = "#C9B87A",
	purple = "#B89BC0",
	red = "#C87A7A",
	border = "#2C2C2C",
	cursorline = "#1A1A1A",
	selection = "#3C5C3C",
	line_nr = "#3C4C3C",
	diff_add_bg = "#1A3A1A",
	diff_change_bg = "#1A2A3A",
	diff_delete_bg = "#3A1A1A",
	diff_text_bg = "#2A3A4A",
	diag_error_bg = "#2A1414",
	diag_warn_bg = "#2A2414",
	diag_info_bg = "#14242A",
	diag_hint_bg = "#1A1E1E",
}

M.palette = c

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.load()
	vim.g.colors_name = "minimal"
	vim.o.background = "dark"

	local function get_bg(normal_bg)
		return M.transparent and "NONE" or normal_bg
	end

	-- ── UI ────────────────────────────────────────────────────────
	hl("Normal", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NormalFloat", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NormalNC", { fg = c.fg, bg = get_bg(c.bg) })
	hl("EndOfBuffer", { fg = get_bg(c.bg) })
	hl("SignColumn", { bg = get_bg(c.bg) })
	hl("FoldColumn", { fg = c.fg_dim, bg = get_bg(c.bg) })
	hl("Folded", { fg = c.fg_dim, bg = c.border })
	hl("ColorColumn", { bg = c.cursorline })
	hl("Conceal", { fg = c.fg_dim })
	hl("Cursor", { fg = c.bg, bg = c.teal })
	hl("CursorLine", { bg = c.cursorline })
	hl("CursorLineNr", { fg = c.teal })
	hl("LineNr", { fg = c.line_nr, bg = get_bg("NONE") })
	hl("CursorColumn", { bg = c.cursorline })
	hl("Directory", { fg = c.teal })
	hl("DiffAdd", { fg = c.green, bg = c.diff_add_bg })
	hl("DiffChange", { fg = c.fg, bg = c.diff_change_bg })
	hl("DiffDelete", { fg = c.red, bg = c.diff_delete_bg })
	hl("DiffText", { fg = c.fg, bg = c.diff_text_bg })
	hl("ErrorMsg", { fg = c.red, bold = true })
	hl("WarningMsg", { fg = c.yellow })
	hl("MoreMsg", { fg = c.green })
	hl("Question", { fg = c.teal })
	hl("IncSearch", { fg = c.bg, bg = c.yellow })
	hl("Search", { fg = c.bg, bg = c.teal })
	hl("CurSearch", { fg = c.bg, bg = c.yellow })
	hl("MatchParen", { fg = c.bg, bg = c.teal })
	hl("ModeMsg", { fg = c.fg })
	hl("MsgArea", { fg = c.fg })
	hl("MsgSeparator", { fg = c.border })
	hl("NonText", { fg = c.line_nr })
	hl("Whitespace", { fg = c.line_nr })
	hl("Pmenu", { fg = c.fg, bg = c.border })
	hl("PmenuSel", { fg = c.bg, bg = c.teal, bold = true })
	hl("PmenuSbar", { bg = c.cursorline })
	hl("PmenuThumb", { bg = c.fg_dim })
	-- blink.cmp (uses Pmenu by default, but be explicit so transparent mode can't break selection fg)
	hl("BlinkCmpMenu", { fg = c.fg, bg = c.border })
	hl("BlinkCmpMenuBorder", { fg = c.border, bg = c.border })
	hl("BlinkCmpMenuSelection", { fg = c.bg, bg = c.teal, bold = true })
	hl("BlinkCmpScrollBarGutter", { bg = c.cursorline })
	hl("BlinkCmpScrollBarThumb", { bg = c.fg_dim })
	hl("BlinkCmpLabelMatch", { fg = c.green, bold = true })
	hl("SpellBad", { sp = c.red, undercurl = true })
	hl("SpellCap", { sp = c.yellow, undercurl = true })
	hl("SpellLocal", { sp = c.teal, undercurl = true })
	hl("SpellRare", { sp = c.purple, undercurl = true })
	hl("StatusLine", { fg = c.fg, bg = c.border })
	hl("StatusLineNC", { fg = c.fg_dim, bg = c.cursorline })
	hl("TabLine", { fg = c.fg_dim, bg = c.cursorline })
	hl("TabLineFill", { bg = get_bg(c.bg) })
	hl("TabLineSel", { fg = c.teal, bg = get_bg(c.bg) })
	hl("Title", { fg = c.teal, bold = true })
	hl("Visual", { bg = c.selection })
	hl("VisualNOS", { bg = c.selection })
	hl("WildMenu", { fg = c.bg, bg = c.teal })
	hl("WinBar", { fg = c.fg_dim })
	hl("WinBarNC", { fg = c.fg_dim })
	hl("WinSeparator", { fg = c.border })

	-- ── Syntax ────────────────────────────────────────────────────
	hl("Comment", { fg = c.fg_dim, italic = true })
	hl("Constant", { fg = c.teal })
	hl("String", { fg = c.green })
	hl("Character", { fg = c.green })
	hl("Number", { fg = c.green })
	hl("Boolean", { fg = c.green })
	hl("Float", { fg = c.green })
	hl("Identifier", { fg = c.fg })
	hl("Function", { fg = c.green })
	hl("Statement", { fg = c.teal })
	hl("Conditional", { fg = c.teal })
	hl("Repeat", { fg = c.teal })
	hl("Label", { fg = c.teal })
	hl("Operator", { fg = c.yellow })
	hl("Keyword", { fg = c.teal })
	hl("Exception", { fg = c.teal })
	hl("PreProc", { fg = c.teal })
	hl("Include", { fg = c.teal })
	hl("Define", { fg = c.teal })
	hl("Macro", { fg = c.teal })
	hl("PreCondit", { fg = c.teal })
	hl("Type", { fg = c.yellow })
	hl("StorageClass", { fg = c.yellow })
	hl("Structure", { fg = c.yellow })
	hl("Typedef", { fg = c.yellow })
	hl("Special", { fg = c.teal })
	hl("SpecialChar", { fg = c.teal })
	hl("Tag", { fg = c.yellow })
	hl("Delimiter", { fg = c.fg_dim })
	hl("SpecialComment", { fg = c.fg_dim })
	hl("Debug", { fg = c.red })
	hl("Underlined", { underline = true })
	hl("Ignore", { fg = get_bg(c.bg) })
	hl("Error", { fg = c.red })
	hl("Todo", { fg = c.bg, bg = c.yellow })

	-- ── Treesitter ────────────────────────────────────────────────
	hl("@comment", { link = "Comment" })
	hl("@keyword", { fg = c.teal })
	hl("@keyword.function", { fg = c.teal, italic = true })
	hl("@keyword.return", { fg = c.teal, italic = true })
	hl("@keyword.operator", { fg = c.teal })
	hl("@string", { link = "String" })
	hl("@string.regex", { fg = c.green, italic = true })
	hl("@number", { link = "Number" })
	hl("@boolean", { link = "Boolean" })
	hl("@type", { fg = c.yellow })
	hl("@type.definition", { fg = c.yellow })
	hl("@type.qualifier", { fg = c.yellow })
	hl("@function", { fg = c.green })
	hl("@function.builtin", { fg = c.green, italic = true })
	hl("@function.method", { fg = c.green })
	hl("@function.call", { fg = c.green })
	hl("@function.method.call", { fg = c.green })
	hl("@function.macro", { fg = c.yellow })
	hl("@variable", { fg = c.fg })
	hl("@variable.builtin", { fg = c.fg })
	hl("@variable.parameter", { fg = c.fg, italic = true })
	hl("@constant", { fg = c.yellow })
	hl("@constant.builtin", { fg = c.yellow })
	hl("@constant.macro", { fg = c.yellow })
	hl("@property", { fg = c.fg })
	hl("@label", { fg = c.green })
	hl("@operator", { fg = c.yellow })
	hl("@punctuation.delimiter", { fg = c.fg })
	hl("@punctuation.bracket", { fg = c.fg })
	hl("@punctuation.special", { fg = c.fg })
	hl("@tag", { fg = c.yellow })
	hl("@tag.attribute", { fg = c.teal })
	hl("@tag.delimiter", { fg = c.fg_dim })
	hl("@constructor", { fg = c.yellow })
	hl("@method", { link = "@function.method" })
	hl("@method.call", { link = "@function.method.call" })
	hl("@parameter", { link = "@variable.parameter" })
	hl("@field", { fg = c.fg })
	hl("@namespace", { fg = c.yellow })
	hl("@attribute", { fg = c.green })
end

return M
