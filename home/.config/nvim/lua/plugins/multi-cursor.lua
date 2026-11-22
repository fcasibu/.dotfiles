return {
    {
        'jake-stewart/multicursor.nvim',
        event = 'VeryLazy',
        lazy = true,
        branch = '1.0',
        config = function()
            local mc = require 'multicursor-nvim'
            mc.setup()

            vim.keymap.set({ 'n', 'x' }, '<C-k>', function()
                mc.lineAddCursor(-1)
            end)
            vim.keymap.set({ 'n', 'x' }, '<C-j>', function()
                mc.lineAddCursor(1)
            end)

            vim.keymap.set({ 'n', 'x' }, '<C-n>', function()
                mc.matchAddCursor(1)
            end)

            mc.addKeymapLayer(function(layerSet)
                layerSet('n', '<esc>', function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
            end)

            local hl = vim.api.nvim_set_hl
            hl(0, 'MultiCursorCursor', { link = 'Cursor' })
            hl(0, 'MultiCursorVisual', { link = 'Visual' })
            hl(0, 'MultiCursorSign', { link = 'SignColumn' })
            hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
            hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
            hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
            hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
        end,
    },
}
