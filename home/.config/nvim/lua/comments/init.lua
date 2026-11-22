local M = {}
local COMMENT_STYLES = {
    lua = { single = '--' },
    typescript = { single = '//' },
    javascript = { single = '//' },
    typescriptreact = { single = '//', jsx = '{/* */}' },
    javascriptreact = { single = '//', jsx = '{/* */}' },
    rust = { single = '//' },
}

local function is_in_jsx_context()
    if not pcall(require, 'nvim-treesitter.parsers') then
        return false
    end

    local parsers = require 'nvim-treesitter.parsers'
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = parsers.get_buf_lang(bufnr)

    if not parsers.has_parser(lang) then
        return false
    end

    local node = vim.treesitter.get_node()

    if not node then
        return false
    end

    while node do
        local node_type = node:type()
        if
            node_type == 'jsx_element'
            or node_type == 'jsx_self_closing_element'
            or node_type == 'jsx_fragment'
            or node_type == 'jsx_text'
            or node_type == 'jsx_attribute'
        then
            return true
        end

        node = node:parent()
    end

    return false
end

local function comment(type)
    local ft = vim.bo.filetype
    local ft_styles = COMMENT_STYLES[ft]
    local comment_start = '//'
    local comment_end = nil

    if ft_styles then
        if (ft == 'javascriptreact' or ft == 'typescriptreact') and ft_styles.jsx and is_in_jsx_context() then
            local parts = vim.split(ft_styles.jsx, ' ', { plain = true, trimempty = true })
            if #parts == 2 then
                comment_start = parts[1]
                comment_end = parts[2]
            else
                comment_start = ft_styles.single or comment_start
            end
        else
            comment_start = ft_styles.single or comment_start
        end
    else
    end

    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    local current_line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, false)[1] or ''
    local indent = current_line:match '^%s*' or ''

    local comment_text = type .. ': '
    local full_comment_line = indent .. comment_start .. ' ' .. comment_text .. (comment_end or '')

    vim.api.nvim_buf_set_lines(0, line_nr - 1, line_nr - 1, false, { full_comment_line })

    local cursor_col = #indent + #comment_start + 1 + #comment_text
    if comment_end then
        cursor_col = cursor_col - 1
    end

    cursor_col = math.max(1, cursor_col + 1)

    vim.api.nvim_win_set_cursor(0, { line_nr, cursor_col - 1 })

    vim.cmd 'startinsert!'
end

local DEFAULT_OPTS = {
    mapping = {
        ['<leader>et'] = 'TODO(fcasibu)',
        ['<leader>ef'] = 'FIX(fcasibu)',
        ['<leader>eb'] = 'BUG(fcasibu)',
        ['<leader>en'] = 'NOTE(fcasibu)',
        ['<leader>ew'] = 'WARN(fcasibu)',
        ['<leader>ep'] = 'PERF(fcasibu)',
    },
}

M.opts = {}

function M.setup(user_opts)
    M.opts = vim.tbl_deep_extend('force', {}, DEFAULT_OPTS, user_opts or {})

    local wk_ok, wk = pcall(require, 'which-key')
    if wk_ok then
        wk.add {
            { '<leader>e', group = '+todo' },
        }
    end

    for key, value in pairs(M.opts.mapping) do
        vim.keymap.set('n', key, function()
            comment(value)
        end, { noremap = true, silent = true, desc = 'Insert ' .. value .. ' comment' })
    end
end

return M
