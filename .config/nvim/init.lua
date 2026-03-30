vim.g.mapleader = " "

require('config.options')

local cargo_bin = vim.fn.expand("~/.cargo/bin")
if vim.fn.isdirectory(cargo_bin) == 1 and not vim.env.PATH:match(vim.pesc(cargo_bin)) then
  vim.env.PATH = cargo_bin .. ":" .. vim.env.PATH
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    -- "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  { import = "plugins" },
  { import = "themes" },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    -- Keymap to show function signature help
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts) -- Useful in insert mode
    -- Keymap for general hover information (like VS Code hover)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end
})


-- Load saved colorscheme or default to bamboo
local cache_dir = vim.fn.stdpath('cache')
local colorscheme_file = cache_dir .. '/colorscheme.txt'
local file = io.open(colorscheme_file, 'r')
local saved_colorscheme = 'monokai-pro-octagon'

if file then
  saved_colorscheme = file:read('*l')
  file:close()
end
vim.cmd.colorscheme(saved_colorscheme)

vim.schedule(function()
  require("mappings.nvchad")
  require("mappings.default")
end)

vim.opt.termguicolors = true

if vim.g.neovide then
  vim.o.guifont = "VictorMono Nerd Font:h15:b"
  vim.g.neovide_text_contrast = 0.1
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_normal_opacity = 0.9
  vim.g.neovide_window_blurred = true
  vim.g.neovide_cursor_animate_command_line = true

  -- Smooth scrolling settings
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_scroll_animation_enabled = true

  -- Enable window animations
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_window_animation_length = 0.2

  -- Enable floating blur (if your GPU supports it)
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- Refresh rate optimization
  vim.g.neovide_refresh_rate = 60

  -- Reduce input latency
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  -- Enable cursor trail for smoother movement
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_animation_length = 0.08

  vim.g.neovide_padding_top = 10

  -- Set Neovim's internal smooth scrolling
  vim.o.scrolloff = 5
  vim.wo.smoothscroll = true
  vim.g.neovide_scale_factor = 1.0  -- Default scale
  vim.g.neovide_floating_corner_radius = 0.6
end
