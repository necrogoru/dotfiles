return {
  "luukvbaal/statuscol.nvim", config = function()
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.HINT] = signs.Hint,
          [vim.diagnostic.severity.INFO] = signs.Info,
        }
      }
    })

    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      -- configuration goes here, for example:
      relculright = true,
      setopt = true,
      segments = {
        {
          sign = {
            namespace = { "gitsigns.*" },
            name = { "gitsigns.*" },
          },
        },
        {
          sign = {
            namespace = { ".*" },
            name = { ".*" },
            auto = true,
          },
        },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa"
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
        { text = { " " } }
      }
    })
  end,
}
