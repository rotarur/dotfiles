return {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
        'nvim-telescope/telescope.nvim', -- Only needed if you want to use session lens
    },
    opts = {
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        -- log_level = 'debug',
    }
}
