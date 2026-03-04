return {
  "cappyzawa/trim.nvim",
  event = "VeryLazy",
  config = function()
    require("trim").setup({
      ft_blocklist = {},
      patterns = {},
      trim_on_write = true,
      trim_trailing = true,
      trim_last_line = false,
      trim_first_line = true
    })
  end
}
