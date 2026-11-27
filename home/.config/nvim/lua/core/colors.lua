-- local M = {}
--
-- M.transparent = true
--
-- local c = {
-- 	bg = "#0C0C0C",
-- 	fg = "#A8B590",
-- 	fg_dim = "#6A7A6A",
-- 	green = "#A7C080",
-- 	teal = "#6EA896",
-- 	yellow = "#C9B87A",
-- 	purple = "#B89BC0",
-- 	red = "#C87A7A",
-- 	border = "#2C2C2C",
-- 	cursorline = "#1A1A1A",
-- 	selection = "#3C5C3C",
-- 	line_nr = "#3C4C3C",
-- 	diff_add_bg = "#1A3A1A",
-- 	diff_change_bg = "#1A2A3A",
-- 	diff_delete_bg = "#3A1A1A",
-- 	diff_text_bg = "#2A3A4A",
-- 	diag_error_bg = "#2A1414",
-- 	diag_warn_bg = "#2A2414",
-- 	diag_info_bg = "#14242A",
-- 	diag_hint_bg = "#1A1E1E",
-- }
--
-- M.palette = c
--
-- local function hl(group, opts)
-- 	vim.api.nvim_set_hl(0, group, opts)
-- end
--
-- function M.load()
-- 	vim.g.colors_name = "minimal"
-- 	vim.o.background = "dark"
--
-- 	local function get_bg(normal_bg)
-- 		return M.transparent and "NONE" or normal_bg
-- 	end
--
-- 	-- ── UI ────────────────────────────────────────────────────────
-- 	hl("Normal", { fg = c.fg, bg = get_bg(c.bg) })
-- 	hl("NormalFloat", { fg = c.fg, bg = get_bg(c.bg) })
-- 	hl("NormalNC", { fg = c.fg, bg = get_bg(c.bg) })
-- 	hl("EndOfBuffer", { fg = get_bg(c.bg) })
-- 	hl("SignColumn", { bg = get_bg(c.bg) })
-- 	hl("FoldColumn", { fg = c.fg_dim, bg = get_bg(c.bg) })
-- 	hl("Folded", { fg = c.fg_dim, bg = c.border })
-- 	hl("ColorColumn", { bg = c.cursorline })
-- 	hl("Conceal", { fg = c.fg_dim })
-- 	hl("Cursor", { fg = c.bg, bg = c.teal })
-- 	hl("CursorLine", { bg = c.cursorline })
-- 	hl("CursorLineNr", { fg = c.teal })
-- 	hl("LineNr", { fg = c.line_nr, bg = get_bg("NONE") })
-- 	hl("CursorColumn", { bg = c.cursorline })
-- 	hl("Directory", { fg = c.teal })
-- 	hl("DiffAdd", { fg = c.green, bg = c.diff_add_bg })
-- 	hl("DiffChange", { fg = c.fg, bg = c.diff_change_bg })
-- 	hl("DiffDelete", { fg = c.red, bg = c.diff_delete_bg })
-- 	hl("DiffText", { fg = c.fg, bg = c.diff_text_bg })
-- 	hl("ErrorMsg", { fg = c.red, bold = true })
-- 	hl("WarningMsg", { fg = c.yellow })
-- 	hl("MoreMsg", { fg = c.green })
-- 	hl("Question", { fg = c.teal })
-- 	hl("IncSearch", { fg = c.bg, bg = c.yellow })
-- 	hl("Search", { fg = c.bg, bg = c.teal })
-- 	hl("CurSearch", { fg = c.bg, bg = c.yellow })
-- 	hl("MatchParen", { fg = c.bg, bg = c.teal })
-- 	hl("ModeMsg", { fg = c.fg })
-- 	hl("MsgArea", { fg = c.fg })
-- 	hl("MsgSeparator", { fg = c.border })
-- 	hl("NonText", { fg = c.line_nr })
-- 	hl("Whitespace", { fg = c.line_nr })
-- 	hl("Pmenu", { fg = c.fg, bg = c.border })
-- 	hl("PmenuSel", { fg = c.bg, bg = c.teal, bold = true })
-- 	hl("PmenuSbar", { bg = c.cursorline })
-- 	hl("PmenuThumb", { bg = c.fg_dim })
-- 	-- blink.cmp (uses Pmenu by default, but be explicit so transparent mode can't break selection fg)
-- 	hl("BlinkCmpMenu", { fg = c.fg, bg = c.border })
-- 	hl("BlinkCmpMenuBorder", { fg = c.border, bg = c.border })
-- 	hl("BlinkCmpMenuSelection", { fg = c.bg, bg = c.teal, bold = true })
-- 	hl("BlinkCmpScrollBarGutter", { bg = c.cursorline })
-- 	hl("BlinkCmpScrollBarThumb", { bg = c.fg_dim })
-- 	hl("BlinkCmpLabelMatch", { fg = c.green, bold = true })
-- 	hl("SpellBad", { sp = c.red, undercurl = true })
-- 	hl("SpellCap", { sp = c.yellow, undercurl = true })
-- 	hl("SpellLocal", { sp = c.teal, undercurl = true })
-- 	hl("SpellRare", { sp = c.purple, undercurl = true })
-- 	hl("StatusLine", { fg = c.fg, bg = c.border })
-- 	hl("StatusLineNC", { fg = c.fg_dim, bg = c.cursorline })
-- 	hl("TabLine", { fg = c.fg_dim, bg = c.cursorline })
-- 	hl("TabLineFill", { bg = get_bg(c.bg) })
-- 	hl("TabLineSel", { fg = c.teal, bg = get_bg(c.bg) })
-- 	hl("Title", { fg = c.teal, bold = true })
-- 	hl("Visual", { bg = c.selection })
-- 	hl("VisualNOS", { bg = c.selection })
-- 	hl("WildMenu", { fg = c.bg, bg = c.teal })
-- 	hl("WinBar", { fg = c.fg_dim })
-- 	hl("WinBarNC", { fg = c.fg_dim })
-- 	hl("WinSeparator", { fg = c.border })
--
-- 	-- ── Syntax ────────────────────────────────────────────────────
-- 	hl("Comment", { fg = c.fg_dim, italic = true })
-- 	hl("Constant", { fg = c.teal })
-- 	hl("String", { fg = c.green })
-- 	hl("Character", { fg = c.green })
-- 	hl("Number", { fg = c.green })
-- 	hl("Boolean", { fg = c.green })
-- 	hl("Float", { fg = c.green })
-- 	hl("Identifier", { fg = c.fg })
-- 	hl("Function", { fg = c.green })
-- 	hl("Statement", { fg = c.teal })
-- 	hl("Conditional", { fg = c.teal })
-- 	hl("Repeat", { fg = c.teal })
-- 	hl("Label", { fg = c.teal })
-- 	hl("Operator", { fg = c.yellow })
-- 	hl("Keyword", { fg = c.teal })
-- 	hl("Exception", { fg = c.teal })
-- 	hl("PreProc", { fg = c.teal })
-- 	hl("Include", { fg = c.teal })
-- 	hl("Define", { fg = c.teal })
-- 	hl("Macro", { fg = c.teal })
-- 	hl("PreCondit", { fg = c.teal })
-- 	hl("Type", { fg = c.yellow })
-- 	hl("StorageClass", { fg = c.yellow })
-- 	hl("Structure", { fg = c.yellow })
-- 	hl("Typedef", { fg = c.yellow })
-- 	hl("Special", { fg = c.teal })
-- 	hl("SpecialChar", { fg = c.teal })
-- 	hl("Tag", { fg = c.yellow })
-- 	hl("Delimiter", { fg = c.fg_dim })
-- 	hl("SpecialComment", { fg = c.fg_dim })
-- 	hl("Debug", { fg = c.red })
-- 	hl("Underlined", { underline = true })
-- 	hl("Ignore", { fg = get_bg(c.bg) })
-- 	hl("Error", { fg = c.red })
-- 	hl("Todo", { fg = c.bg, bg = c.yellow })
--
-- 	-- ── Treesitter ────────────────────────────────────────────────
-- 	hl("@comment", { link = "Comment" })
-- 	hl("@keyword", { fg = c.teal })
-- 	hl("@keyword.function", { fg = c.teal, italic = true })
-- 	hl("@keyword.return", { fg = c.teal, italic = true })
-- 	hl("@keyword.operator", { fg = c.teal })
-- 	hl("@string", { link = "String" })
-- 	hl("@string.regex", { fg = c.green, italic = true })
-- 	hl("@number", { link = "Number" })
-- 	hl("@boolean", { link = "Boolean" })
-- 	hl("@type", { fg = c.yellow })
-- 	hl("@type.definition", { fg = c.yellow })
-- 	hl("@type.qualifier", { fg = c.yellow })
-- 	hl("@function", { fg = c.green })
-- 	hl("@function.builtin", { fg = c.green, italic = true })
-- 	hl("@function.method", { fg = c.green })
-- 	hl("@function.call", { fg = c.green })
-- 	hl("@function.method.call", { fg = c.green })
-- 	hl("@function.macro", { fg = c.yellow })
-- 	hl("@variable", { fg = c.fg })
-- 	hl("@variable.builtin", { fg = c.fg })
-- 	hl("@variable.parameter", { fg = c.fg, italic = true })
-- 	hl("@constant", { fg = c.yellow })
-- 	hl("@constant.builtin", { fg = c.yellow })
-- 	hl("@constant.macro", { fg = c.yellow })
-- 	hl("@property", { fg = c.fg })
-- 	hl("@label", { fg = c.green })
-- 	hl("@operator", { fg = c.yellow })
-- 	hl("@punctuation.delimiter", { fg = c.fg })
-- 	hl("@punctuation.bracket", { fg = c.fg })
-- 	hl("@punctuation.special", { fg = c.fg })
-- 	hl("@tag", { fg = c.yellow })
-- 	hl("@tag.attribute", { fg = c.teal })
-- 	hl("@tag.delimiter", { fg = c.fg_dim })
-- 	hl("@constructor", { fg = c.yellow })
-- 	hl("@method", { link = "@function.method" })
-- 	hl("@method.call", { link = "@function.method.call" })
-- 	hl("@parameter", { link = "@variable.parameter" })
-- 	hl("@field", { fg = c.fg })
-- 	hl("@namespace", { fg = c.yellow })
-- 	hl("@attribute", { fg = c.green })
-- end
--
-- return M

local M = {}

M.transparent = true

local c = {
	-- surfaces
	bg = "#14100B",
	bg_float = "#1C150E",
	bg_alt = "#241B12",
	cursorline = "#1F1810",
	border = "#3A2C1C",
	selection = "#43321E",
	line_nr = "#5E4C36",

	-- text (three steps of lightness)
	fg = "#E4D3B0",
	fg_soft = "#B9A683",
	fg_dim = "#9C8767",

	-- accents
	amber = "#D9A05B",
	sage = "#A3AE78",
	teal = "#82AFA0",
	clay = "#CF7F6B",

	-- diff backgrounds
	diff_add_bg = "#202714",
	diff_change_bg = "#1B2626",
	diff_delete_bg = "#301812",
	diff_text_bg = "#2D423C",

	-- diagnostic backgrounds
	diag_error_bg = "#2A1511",
	diag_warn_bg = "#2A2110",
	diag_info_bg = "#122121",
	diag_hint_bg = "#1D1B15",
}

M.palette = c

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.load()
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "minimal"
	vim.o.background = "dark"
	vim.o.termguicolors = true

	local function get_bg(normal_bg)
		return M.transparent and "NONE" or normal_bg
	end

	vim.opt.fillchars:append({ eob = " " })

	-- ── Terminal colors (match alacritty) ────────────────────────
	vim.g.terminal_color_0 = "#1A1510"
	vim.g.terminal_color_1 = c.clay
	vim.g.terminal_color_2 = c.sage
	vim.g.terminal_color_3 = "#D4B26A"
	vim.g.terminal_color_4 = "#86A3B8"
	vim.g.terminal_color_5 = "#B99BAE"
	vim.g.terminal_color_6 = c.teal
	vim.g.terminal_color_7 = c.fg_soft
	vim.g.terminal_color_8 = c.fg_dim
	vim.g.terminal_color_9 = "#DB9482"
	vim.g.terminal_color_10 = "#B6C18B"
	vim.g.terminal_color_11 = "#E3C783"
	vim.g.terminal_color_12 = "#A0BACB"
	vim.g.terminal_color_13 = "#CCB2C2"
	vim.g.terminal_color_14 = "#9BC4B7"
	vim.g.terminal_color_15 = "#F2E8D0"

	-- ── UI ────────────────────────────────────────────────────────
	hl("Normal", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NormalNC", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NormalFloat", { fg = c.fg, bg = c.bg_float })
	hl("FloatBorder", { fg = c.border, bg = c.bg_float })
	hl("FloatTitle", { fg = c.teal, bg = c.bg_float, bold = true })
	hl("FloatFooter", { fg = c.fg_dim, bg = c.bg_float })
	hl("EndOfBuffer", { fg = get_bg(c.bg) })
	hl("SignColumn", { fg = c.fg_dim, bg = get_bg(c.bg) })
	hl("FoldColumn", { fg = c.fg_dim, bg = get_bg(c.bg) })
	hl("Folded", { fg = c.fg_dim, bg = c.bg_alt })
	hl("ColorColumn", { bg = c.cursorline })
	hl("Conceal", { fg = c.fg_dim })
	hl("Cursor", { fg = c.bg, bg = c.amber })
	hl("lCursor", { fg = c.bg, bg = c.amber })
	hl("CursorIM", { fg = c.bg, bg = c.amber })
	hl("TermCursor", { fg = c.bg, bg = c.amber })
	hl("CursorLine", { bg = c.cursorline })
	hl("CursorColumn", { bg = c.cursorline })
	hl("CursorLineNr", { fg = c.amber })
	hl("CursorLineSign", { bg = c.cursorline })
	hl("CursorLineFold", { fg = c.fg_dim, bg = c.cursorline })
	hl("LineNr", { fg = c.line_nr })
	hl("LineNrAbove", { fg = c.line_nr })
	hl("LineNrBelow", { fg = c.line_nr })
	hl("Directory", { fg = c.teal })

	hl("DiffAdd", { fg = c.sage, bg = c.diff_add_bg })
	hl("DiffChange", { fg = c.fg, bg = c.diff_change_bg })
	hl("DiffDelete", { fg = c.clay, bg = c.diff_delete_bg })
	hl("DiffText", { fg = c.fg, bg = c.diff_text_bg })
	hl("Added", { fg = c.sage })
	hl("Changed", { fg = c.teal })
	hl("Removed", { fg = c.clay })

	hl("ErrorMsg", { fg = c.clay, bold = true })
	hl("WarningMsg", { fg = c.amber })
	hl("MoreMsg", { fg = c.sage })
	hl("Question", { fg = c.teal })
	hl("ModeMsg", { fg = c.fg })
	hl("MsgArea", { fg = c.fg })
	hl("MsgSeparator", { fg = c.border })

	hl("Search", { fg = c.bg, bg = c.teal })
	hl("IncSearch", { fg = c.bg, bg = c.amber })
	hl("CurSearch", { fg = c.bg, bg = c.amber })
	hl("Substitute", { fg = c.bg, bg = c.clay })
	hl("MatchParen", { fg = c.bg, bg = c.teal })
	hl("QuickFixLine", { bg = c.selection })
	hl("SnippetTabstop", { bg = c.selection })

	hl("NonText", { fg = c.line_nr })
	hl("Whitespace", { fg = c.line_nr })
	hl("SpecialKey", { fg = c.line_nr })

	hl("Pmenu", { fg = c.fg, bg = c.bg_alt })
	hl("PmenuSel", { fg = c.bg, bg = c.teal, bold = true })
	hl("PmenuKind", { fg = c.fg_dim, bg = c.bg_alt })
	hl("PmenuKindSel", { fg = c.bg, bg = c.teal })
	hl("PmenuExtra", { fg = c.fg_dim, bg = c.bg_alt })
	hl("PmenuExtraSel", { fg = c.bg, bg = c.teal })
	hl("PmenuMatch", { fg = c.sage, bg = c.bg_alt, bold = true })
	hl("PmenuMatchSel", { fg = c.bg, bg = c.teal, bold = true })
	hl("PmenuSbar", { bg = c.cursorline })
	hl("PmenuThumb", { bg = c.fg_dim })
	hl("WildMenu", { fg = c.bg, bg = c.teal })

	hl("SpellBad", { sp = c.clay, undercurl = true })
	hl("SpellCap", { sp = c.amber, undercurl = true })
	hl("SpellLocal", { sp = c.teal, undercurl = true })
	hl("SpellRare", { sp = c.fg_soft, undercurl = true })

	hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
	hl("StatusLineNC", { fg = c.fg_dim, bg = c.cursorline })
	hl("StatusLineTerm", { fg = c.fg, bg = c.bg_alt })
	hl("StatusLineTermNC", { fg = c.fg_dim, bg = c.cursorline })
	hl("TabLine", { fg = c.fg_dim, bg = c.cursorline })
	hl("TabLineFill", { bg = get_bg(c.bg) })
	hl("TabLineSel", { fg = c.teal, bg = get_bg(c.bg) })
	hl("Title", { fg = c.teal, bold = true })
	hl("Visual", { bg = c.selection })
	hl("VisualNOS", { bg = c.selection })
	hl("WinBar", { fg = c.fg_dim })
	hl("WinBarNC", { fg = c.fg_dim })
	hl("WinSeparator", { fg = c.border })
	hl("VertSplit", { fg = c.border })

	-- ── Syntax (vim-style fallback groups) ───────────────────────
	hl("Comment", { fg = c.fg_dim, italic = true })
	hl("SpecialComment", { fg = c.fg_dim })

	hl("Constant", { fg = c.teal })
	hl("String", { fg = c.sage })
	hl("Character", { fg = c.sage })
	hl("Number", { fg = c.sage })
	hl("Boolean", { fg = c.sage })
	hl("Float", { fg = c.sage })

	hl("Identifier", { fg = c.fg })
	hl("Function", { fg = c.sage })

	hl("Statement", { fg = c.teal })
	hl("Conditional", { fg = c.teal })
	hl("Repeat", { fg = c.teal })
	hl("Label", { fg = c.teal })
	hl("Keyword", { fg = c.teal })
	hl("Exception", { fg = c.teal })
	hl("PreProc", { fg = c.teal })
	hl("Include", { fg = c.teal })
	hl("Define", { fg = c.teal })
	hl("Macro", { fg = c.teal })
	hl("PreCondit", { fg = c.teal })

	hl("Operator", { fg = c.amber })
	hl("Type", { fg = c.amber })
	hl("StorageClass", { fg = c.amber })
	hl("Structure", { fg = c.amber })
	hl("Typedef", { fg = c.amber })
	hl("Tag", { fg = c.amber })

	hl("Special", { fg = c.teal })
	hl("SpecialChar", { fg = c.teal })
	hl("Delimiter", { fg = c.fg_dim })

	hl("Debug", { fg = c.clay })
	hl("Underlined", { underline = true })
	hl("Ignore", { fg = get_bg(c.bg) })
	hl("Error", { fg = c.clay })
	hl("Todo", { fg = c.bg, bg = c.amber })

	-- ── Treesitter ────────────────────────────────────────────────
	hl("@comment", { link = "Comment" })
	hl("@comment.documentation", { fg = c.fg_dim, italic = true })
	hl("@comment.todo", { fg = c.bg, bg = c.amber })
	hl("@comment.note", { fg = c.bg, bg = c.teal })
	hl("@comment.warning", { fg = c.bg, bg = c.amber })
	hl("@comment.error", { fg = c.bg, bg = c.clay })

	-- keywords: teal
	hl("@keyword", { fg = c.teal })
	hl("@keyword.function", { fg = c.teal, italic = true })
	hl("@keyword.return", { fg = c.teal, italic = true })
	hl("@keyword.operator", { fg = c.teal })
	hl("@keyword.conditional", { fg = c.teal })
	hl("@keyword.repeat", { fg = c.teal })
	hl("@keyword.exception", { fg = c.teal })
	hl("@keyword.import", { fg = c.teal })
	hl("@keyword.modifier", { fg = c.amber })
	hl("@keyword.storage", { fg = c.amber })
	hl("@keyword.directive", { fg = c.teal })

	-- literals: sage
	hl("@string", { link = "String" })
	hl("@string.regexp", { fg = c.sage, italic = true })
	hl("@string.regex", { fg = c.sage, italic = true })
	hl("@string.escape", { fg = c.teal })
	hl("@string.special", { fg = c.teal })
	hl("@string.special.url", { fg = c.teal, underline = true })
	hl("@string.special.path", { fg = c.sage })
	hl("@character", { link = "Character" })
	hl("@number", { link = "Number" })
	hl("@number.float", { link = "Float" })
	hl("@boolean", { link = "Boolean" })

	-- types, constants, namespaces, operators: amber
	hl("@type", { fg = c.amber })
	hl("@type.builtin", { fg = c.amber })
	hl("@type.definition", { fg = c.amber })
	hl("@type.qualifier", { fg = c.amber })
	hl("@constructor", { fg = c.amber })
	hl("@constant", { fg = c.amber })
	hl("@constant.builtin", { fg = c.amber })
	hl("@constant.macro", { fg = c.amber })
	hl("@module", { fg = c.amber })
	hl("@module.builtin", { fg = c.amber })
	hl("@operator", { fg = c.amber })

	-- functions: sage (macros: amber)
	hl("@function", { fg = c.sage })
	hl("@function.builtin", { fg = c.sage, italic = true })
	hl("@function.call", { fg = c.sage })
	hl("@function.method", { fg = c.sage })
	hl("@function.method.call", { fg = c.sage })
	hl("@function.macro", { fg = c.amber })
	hl("@attribute", { fg = c.sage })
	hl("@attribute.builtin", { fg = c.sage })
	hl("@label", { fg = c.sage })

	-- variables, properties, punctuation: fg
	hl("@variable", { fg = c.fg })
	hl("@variable.builtin", { fg = c.fg })
	hl("@variable.parameter", { fg = c.fg, italic = true })
	hl("@variable.parameter.builtin", { fg = c.fg, italic = true })
	hl("@variable.member", { fg = c.fg })
	hl("@property", { fg = c.fg })
	hl("@punctuation.delimiter", { fg = c.fg })
	hl("@punctuation.bracket", { fg = c.fg })
	hl("@punctuation.special", { fg = c.fg })

	-- tags (html / jsx / xml)
	hl("@tag", { fg = c.amber })
	hl("@tag.builtin", { fg = c.amber })
	hl("@tag.attribute", { fg = c.teal })
	hl("@tag.delimiter", { fg = c.fg_dim })

	-- markup (markdown, help)
	hl("@markup", { fg = c.fg })
	hl("@markup.strong", { bold = true })
	hl("@markup.italic", { italic = true })
	hl("@markup.strikethrough", { strikethrough = true })
	hl("@markup.underline", { underline = true })
	hl("@markup.heading", { fg = c.teal, bold = true })
	hl("@markup.quote", { fg = c.fg_dim, italic = true })
	hl("@markup.math", { fg = c.amber })
	hl("@markup.link", { fg = c.fg_soft })
	hl("@markup.link.label", { fg = c.teal })
	hl("@markup.link.url", { fg = c.teal, underline = true })
	hl("@markup.raw", { fg = c.sage })
	hl("@markup.raw.block", { fg = c.sage })
	hl("@markup.list", { fg = c.teal })
	hl("@markup.list.checked", { fg = c.sage })
	hl("@markup.list.unchecked", { fg = c.fg_dim })

	-- diff
	hl("@diff.plus", { fg = c.sage })
	hl("@diff.minus", { fg = c.clay })
	hl("@diff.delta", { fg = c.teal })

	-- legacy names
	hl("@method", { link = "@function.method" })
	hl("@method.call", { link = "@function.method.call" })
	hl("@parameter", { link = "@variable.parameter" })
	hl("@field", { fg = c.fg })
	hl("@namespace", { fg = c.amber })
	hl("@conditional", { link = "@keyword.conditional" })
	hl("@repeat", { link = "@keyword.repeat" })
	hl("@exception", { link = "@keyword.exception" })
	hl("@include", { link = "@keyword.import" })

	-- ── LSP ───────────────────────────────────────────────────────
	hl("LspReferenceText", { bg = c.selection })
	hl("LspReferenceRead", { bg = c.selection })
	hl("LspReferenceWrite", { bg = c.selection, underline = true })
	hl("LspInlayHint", { fg = c.fg_dim, italic = true })
	hl("LspCodeLens", { fg = c.fg_dim })
	hl("LspCodeLensSeparator", { fg = c.border })
	hl("LspSignatureActiveParameter", { fg = c.teal, underline = true })

	-- keep semantic tokens consistent with treesitter
	hl("@lsp.type.comment", {})
	hl("@lsp.type.variable", {})
	hl("@lsp.typemod.variable.readonly", {})
	hl("@lsp.type.macro", { link = "@function.macro" })
	hl("@lsp.type.namespace", { link = "@module" })
	hl("@lsp.type.parameter", { link = "@variable.parameter" })
	hl("@lsp.type.property", { link = "@property" })
	hl("@lsp.type.enumMember", { link = "@constant" })
	hl("@lsp.type.interface", { link = "@type" })
	hl("@lsp.type.typeParameter", { link = "@type" })
	hl("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
	hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })

	-- ── Diagnostics ───────────────────────────────────────────────
	hl("DiagnosticError", { fg = c.clay })
	hl("DiagnosticWarn", { fg = c.amber })
	hl("DiagnosticInfo", { fg = c.teal })
	hl("DiagnosticHint", { fg = c.fg_dim })
	hl("DiagnosticOk", { fg = c.sage })

	hl("DiagnosticVirtualTextError", { fg = c.clay, bg = c.diag_error_bg })
	hl("DiagnosticVirtualTextWarn", { fg = c.amber, bg = c.diag_warn_bg })
	hl("DiagnosticVirtualTextInfo", { fg = c.teal, bg = c.diag_info_bg })
	hl("DiagnosticVirtualTextHint", { fg = c.fg_dim, bg = c.diag_hint_bg })
	hl("DiagnosticVirtualTextOk", { fg = c.sage })

	hl("DiagnosticFloatingError", { fg = c.clay, bg = c.bg_float })
	hl("DiagnosticFloatingWarn", { fg = c.amber, bg = c.bg_float })
	hl("DiagnosticFloatingInfo", { fg = c.teal, bg = c.bg_float })
	hl("DiagnosticFloatingHint", { fg = c.fg_dim, bg = c.bg_float })
	hl("DiagnosticFloatingOk", { fg = c.sage, bg = c.bg_float })

	hl("DiagnosticSignError", { fg = c.clay, bg = get_bg(c.bg) })
	hl("DiagnosticSignWarn", { fg = c.amber, bg = get_bg(c.bg) })
	hl("DiagnosticSignInfo", { fg = c.teal, bg = get_bg(c.bg) })
	hl("DiagnosticSignHint", { fg = c.fg_dim, bg = get_bg(c.bg) })
	hl("DiagnosticSignOk", { fg = c.sage, bg = get_bg(c.bg) })

	hl("DiagnosticUnderlineError", { sp = c.clay, undercurl = true })
	hl("DiagnosticUnderlineWarn", { sp = c.amber, undercurl = true })
	hl("DiagnosticUnderlineInfo", { sp = c.teal, undercurl = true })
	hl("DiagnosticUnderlineHint", { sp = c.fg_dim, undercurl = true })
	hl("DiagnosticUnderlineOk", { sp = c.sage, undercurl = true })
	hl("DiagnosticDeprecated", { sp = c.fg_dim, strikethrough = true })
	hl("DiagnosticUnnecessary", { fg = c.fg_dim })

	-- ── blink.cmp ─────────────────────────────────────────────────
	hl("BlinkCmpMenu", { fg = c.fg, bg = c.bg_alt })
	hl("BlinkCmpMenuBorder", { fg = c.border, bg = c.bg_alt })
	hl("BlinkCmpMenuSelection", { fg = c.bg, bg = c.teal, bold = true })
	hl("BlinkCmpScrollBarGutter", { bg = c.cursorline })
	hl("BlinkCmpScrollBarThumb", { bg = c.fg_dim })
	hl("BlinkCmpLabel", { fg = c.fg })
	hl("BlinkCmpLabelDeprecated", { fg = c.fg_dim, strikethrough = true })
	hl("BlinkCmpLabelMatch", { fg = c.sage, bold = true })
	hl("BlinkCmpLabelDetail", { fg = c.fg_dim })
	hl("BlinkCmpLabelDescription", { fg = c.fg_dim })
	hl("BlinkCmpKind", { fg = c.fg_dim })
	hl("BlinkCmpSource", { fg = c.fg_dim })
	hl("BlinkCmpGhostText", { fg = c.line_nr })
	hl("BlinkCmpDoc", { fg = c.fg, bg = c.bg_float })
	hl("BlinkCmpDocBorder", { fg = c.border, bg = c.bg_float })
	hl("BlinkCmpDocSeparator", { fg = c.border, bg = c.bg_float })
	hl("BlinkCmpSignatureHelp", { fg = c.fg, bg = c.bg_float })
	hl("BlinkCmpSignatureHelpBorder", { fg = c.border, bg = c.bg_float })
	hl("BlinkCmpSignatureHelpActiveParameter", { fg = c.teal, underline = true })

	-- ── Git signs ─────────────────────────────────────────────────
	hl("GitSignsAdd", { fg = c.sage })
	hl("GitSignsChange", { fg = c.teal })
	hl("GitSignsDelete", { fg = c.clay })
	hl("GitSignsTopdelete", { fg = c.clay })
	hl("GitSignsChangedelete", { fg = c.amber })
	hl("GitSignsUntracked", { fg = c.fg_dim })
	hl("GitSignsAddInline", { bg = c.diff_add_bg })
	hl("GitSignsDeleteInline", { bg = c.diff_delete_bg })
	hl("GitSignsChangeInline", { bg = c.diff_change_bg })
	hl("GitSignsCurrentLineBlame", { fg = c.fg_dim, italic = true })

	-- ── Pickers (telescope / fzf-lua / snacks) ───────────────────
	hl("TelescopeNormal", { fg = c.fg, bg = c.bg_float })
	hl("TelescopeBorder", { fg = c.border, bg = c.bg_float })
	hl("TelescopeTitle", { fg = c.teal, bold = true })
	hl("TelescopePromptNormal", { fg = c.fg, bg = c.bg_alt })
	hl("TelescopePromptBorder", { fg = c.bg_alt, bg = c.bg_alt })
	hl("TelescopePromptPrefix", { fg = c.teal })
	hl("TelescopePromptCounter", { fg = c.fg_dim })
	hl("TelescopeSelection", { fg = c.fg, bg = c.selection })
	hl("TelescopeSelectionCaret", { fg = c.teal, bg = c.selection })
	hl("TelescopeMatching", { fg = c.sage, bold = true })
	hl("FzfLuaNormal", { fg = c.fg, bg = c.bg_float })
	hl("FzfLuaBorder", { fg = c.border, bg = c.bg_float })
	hl("FzfLuaTitle", { fg = c.teal, bold = true })
	hl("FzfLuaCursorLine", { bg = c.selection })
	hl("SnacksPickerMatch", { fg = c.sage, bold = true })

	-- ── Indent guides ─────────────────────────────────────────────
	hl("IblIndent", { fg = c.border })
	hl("IblScope", { fg = c.fg_dim })
	hl("IndentBlanklineChar", { fg = c.border })
	hl("SnacksIndent", { fg = c.border })
	hl("SnacksIndentScope", { fg = c.fg_dim })

	-- ── which-key ─────────────────────────────────────────────────
	hl("WhichKey", { fg = c.teal })
	hl("WhichKeyGroup", { fg = c.amber })
	hl("WhichKeyDesc", { fg = c.fg })
	hl("WhichKeySeparator", { fg = c.fg_dim })
	hl("WhichKeyValue", { fg = c.fg_dim })
	hl("WhichKeyNormal", { fg = c.fg, bg = c.bg_float })
	hl("WhichKeyBorder", { fg = c.border, bg = c.bg_float })

	-- ── File explorers ────────────────────────────────────────────
	hl("NeoTreeNormal", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NeoTreeNormalNC", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NeoTreeDirectoryName", { fg = c.teal })
	hl("NeoTreeDirectoryIcon", { fg = c.teal })
	hl("NeoTreeRootName", { fg = c.amber, bold = true })
	hl("NeoTreeGitAdded", { fg = c.sage })
	hl("NeoTreeGitModified", { fg = c.teal })
	hl("NeoTreeGitDeleted", { fg = c.clay })
	hl("NeoTreeGitUntracked", { fg = c.fg_dim })
	hl("NeoTreeGitIgnored", { fg = c.fg_dim })
	hl("NvimTreeNormal", { fg = c.fg, bg = get_bg(c.bg) })
	hl("NvimTreeFolderName", { fg = c.teal })
	hl("NvimTreeOpenedFolderName", { fg = c.fg })
	hl("NvimTreeRootFolder", { fg = c.amber, bold = true })
	hl("NvimTreeGitDirty", { fg = c.teal })
	hl("NvimTreeGitNew", { fg = c.sage })
	hl("NvimTreeGitDeleted", { fg = c.clay })
	hl("OilDir", { fg = c.teal })
	hl("OilDirIcon", { fg = c.teal })
	hl("OilFile", { fg = c.fg })
	hl("OilLink", { fg = c.amber })

	-- ── Jump labels ───────────────────────────────────────────────
	hl("FlashLabel", { fg = c.bg, bg = c.amber, bold = true })
	hl("FlashMatch", { fg = c.fg, bg = c.selection })
	hl("FlashCurrent", { fg = c.bg, bg = c.teal })
	hl("FlashBackdrop", { fg = c.fg_dim })
	hl("LeapLabel", { fg = c.bg, bg = c.amber, bold = true })
	hl("LeapMatch", { fg = c.bg, bg = c.teal })
	hl("LeapBackdrop", { fg = c.fg_dim })

	-- ── Lazy / Mason ──────────────────────────────────────────────
	hl("LazyH1", { fg = c.bg, bg = c.teal, bold = true })
	hl("LazyButton", { fg = c.fg, bg = c.bg_alt })
	hl("LazyButtonActive", { fg = c.bg, bg = c.teal, bold = true })
	hl("LazySpecial", { fg = c.teal })
	hl("LazyCommit", { fg = c.sage })
	hl("MasonHeader", { fg = c.bg, bg = c.teal, bold = true })
	hl("MasonHighlight", { fg = c.teal })
	hl("MasonHighlightBlock", { fg = c.bg, bg = c.teal })
	hl("MasonMuted", { fg = c.fg_dim })

	-- ── Health / misc ─────────────────────────────────────────────
	hl("healthSuccess", { fg = c.sage })
	hl("healthWarning", { fg = c.amber })
	hl("healthError", { fg = c.clay })
	hl("MiniCursorword", { bg = c.selection })
	hl("MiniIndentscopeSymbol", { fg = c.fg_dim })
	hl("RenderMarkdownCode", { bg = c.bg_alt })
	hl("RenderMarkdownCodeInline", { fg = c.sage, bg = c.bg_alt })
end

return M
