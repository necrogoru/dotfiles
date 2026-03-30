return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    })
    require("nvim-treesitter").install({ "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript", "html", "css", "json", "bash", "vue", "tsx", "markdown", "markdown_inline", "astro" })
  end
}
