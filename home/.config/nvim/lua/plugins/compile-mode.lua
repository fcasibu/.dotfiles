return {
    event = "VeryLazy",
    'ej-shafran/compile-mode.nvim',
    version = '^5.0.0',
    -- you can just use the latest version:
    -- branch = "latest",
    -- or the most up-to-date updates:
    -- branch = "nightly",
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- if you want to enable coloring of ANSI escape codes in
        -- compilation output, add:
        { "m00qek/baleia.nvim", tag = "v1.3.0", submodules = false },
    },
    config = function()
        ---@type CompileModeOpts
        vim.g.compile_mode = {
            -- to add ANSI escape code support, add:
            baleia_setup = true,
            input_word_completion = true,
            default_command = '',
            recompile_no_fail = true,
            ask_about_save = false,
            ask_to_interrupt = false,

            error_regexp_table = {
                rustc = {
                    regex = [[^\s*-->\s*\([^:]\+\):\(\d\+\):\(\d\+\)]],
                    filename = 1,
                    row = 2,
                    col = 3,
                },
                ols = {
                    regex = [[^\([^(]\+\)(\(\d\+\):\(\d\+\))]],
                    filename = 1,
                    row = 2,
                    col = 3,
                },
            },

            -- to make `:Compile` replace special characters (e.g. `%`) in
            -- the command (and behave more like `:!`), add:
            bang_expansion = true,
        }

        vim.keymap.set('n', '<leader>te', function()
            local target = '*compilation*'
            local bufnr = vim.fn.bufnr(target)

            if bufnr ~= -1 then
                -- Buffer exists, check if it's visible
                local wins = vim.fn.win_findbuf(bufnr)
                if #wins > 0 then
                    -- Convert window ID → window number before closing
                    local winnr = vim.fn.win_id2win(wins[1])
                    vim.cmd(winnr .. 'wincmd c')
                else
                    vim.cmd('split | buffer ' .. bufnr)
                end
            else
                -- Buffer doesn't exist yet → open it
                vim.cmd('split ' .. target)
            end
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>tr', "<CMD>Recompile<CR>", { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>tqf', "<CMD>QuickfixErrors<CR>", { noremap = true, silent = true })
    end,
}
