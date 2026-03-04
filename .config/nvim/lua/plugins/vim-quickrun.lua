return {
  "thinca/vim-quickrun",
  event = "VeryLazy",
  config = function()
    vim.g.quickrun_config = {
      javascript = { command = "node" },
    }
  end,
}
