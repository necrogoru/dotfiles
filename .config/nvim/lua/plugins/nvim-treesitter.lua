return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    require("nvim-treesitter").install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "python",
      "javascript",
      "typescript",
      "html",
      "css",
      "json",
      "bash",
      "vue",
      "tsx",
      "markdown",
      "markdown_inline",
      "astro",
    })

    local treesitter_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = treesitter_group,
      pattern = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "bash",
        "vue",
        "typescriptreact",
        "javascriptreact",
        "markdown",
        "astro",
      },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end
}
