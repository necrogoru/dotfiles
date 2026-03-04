return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_config = {
          height = 0.8,
          width = 0.8,
          prompt_position = 'top',
          preview_width = 0.65,
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    })

    -- Autocommand to save colorscheme when it changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function(args)
        local cache_dir = vim.fn.stdpath('cache')
        local colorscheme_file = cache_dir .. '/colorscheme.txt'
        local file = io.open(colorscheme_file, 'w')
        if file then
          file:write(args.match)
          file:close()
        end
      end
    })
  end
}
