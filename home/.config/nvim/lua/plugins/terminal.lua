return {
    {
        'akinsho/toggleterm.nvim',
        event = 'VeryLazy',
        lazy = true,
        version = '*',
        keys = {
            { '<C-t>', '<CMD>ToggleTerm<CR>', desc = 'Toggle terminal' },
        },
        config = function()
            require('toggleterm').setup({
                size = 20,
                direction = 'float',
                float_opts = {
                    height = 40,
                },
            })

            local function set_terminal_keymaps(bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
                vim.keymap.set('t', '<C-_>', '<CMD>ToggleTerm<CR>', opts)
            end

            vim.api.nvim_create_autocmd('TermOpen', {
                pattern = 'term://*',
                callback = function(args)
                    set_terminal_keymaps(args.buf)
                end,
            })
        end,
    },
}
