return {
    'voldikss/vim-floaterm',

    config = function()
        -- Floaterm
        vim.keymap.set('n', '<leader>ft',
            ':FloatermNew --height=0.9 --width=0.4 --wintype=float --name=floaterm1 --position=topright --autoclose=2<CR>',
            { desc = 'Open Floating Term' })
    end
}
