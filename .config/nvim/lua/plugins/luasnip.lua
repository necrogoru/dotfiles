return {
 	"L3MON4D3/LuaSnip",
	-- follow latest release.
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = {
        "~/.vscode/extensions/deinsoftware.vitest-snippets-1.8.0",
        "~/.vscode/extensions/sdras.vue-vscode-snippets-3.2.0",
        "~/.config/nvim/lua/custom/my_snippets",
      }
    })

    require("luasnip").filetype_extend("typescript", { "javascript" })
  end,
}
