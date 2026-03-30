return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup({
      formatting = {
        format = require("nvim-highlight-colors").format
      }
    })
  end,
}
