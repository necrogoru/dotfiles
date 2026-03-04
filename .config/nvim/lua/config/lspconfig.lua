local lspconfig = require('lspconfig')

-- Define capabilities (for nvim-cmp compatibility)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Optional: on_attach function for keymaps
local on_attach = function(client, bufnr)
  -- Add your LSP keymaps here
  -- Example:
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
end

local vue_ls = { 'vue-language-server', '--stdio' }
local lspconfig_util = require 'lspconfig.util'
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

local home = os.getenv("HOME")
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "javascript", "vue" },
  root_markers = { "package.json" },
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = home .. "/.nvm/versions/node/v22.14.0/lib/node_modules/@vue/language-server",
        languages = {
          "typescript",
          "vue"
        }
      }
    },
  },
})

vim.lsp.enable("ts_ls")

vim.lsp.config("vue_ls", {
  cmd = vue_ls,
  filetypes = { "vue", "typescript", "javascript", "json" },
  root_markers = { "package.json" },
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = home .. "/.nvm/versions/node/v20.9.0/lib/node_modules/typescript/lib"
    },
    languageFeatures = {
      implementation = true,
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = true,
      rename = true,
      renameFileRefactoring = true,
      signatureHelp = true,
      codeAction = true,
      workspaceSymbol = true,
      completion = {
        defaultTagNameCase = "both",
        defaultAttrNameCase = "kebabCase",
        getDocumentNameCasesRequest = false,
        getDocumentSelectionRequest = false,
      }
    }
  }
})
vim.lsp.enable("vue_ls")

-- Fix: Configure tailwindcss using the new API
vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "vue", "css", "scss", "html", "astro" },
  root_markers = { "tailwind.config.js", "tailwind.config.cjs", "postcss.config.js", "postcss.config.cjs", "package.json" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      rootFontSize = 10
    }
  }
})
vim.lsp.enable("tailwindcss")

vim.lsp.config.stylelint_lsp = {
  filetypes = { "css", "scss", "less", "sass" },
}

vim.lsp.enable("stylelint_lsp")
