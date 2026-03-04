return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufNewFile" },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript", "html", "css", "json", "bash", "vue", "tsx", "markdown", "markdown_inline", "astro" },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    }
  end
}
