local lspconfig = require('lspconfig')

-- Define capabilities (for nvim-cmp compatibility)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Optional: on_attach function for keymaps
local on_attach = function(client, bufnr)
  -- Add your LSP keymaps here
  local function goto_definition()
    vim.lsp.buf.definition({
      on_list = function(options)
        local items = options.items
        if #items > 0 then
          local filtered = {}
          for _, item in ipairs(items) do
            -- Filter out .nuxt auto-generated declaration files
            if item.filename and not string.match(item.filename, "%.nuxt/") then
              table.insert(filtered, item)
            end
          end
          -- If we filtered out the .nuxt file, but we have valid alternatives, use them
          if #filtered > 0 then
            items = filtered
          else
            -- If we only got .nuxt files (like components.d.ts), let's parse it to find the real path!
            for _, item in ipairs(items) do
              if item.filename and string.match(item.filename, "%.nuxt/components%.d%.ts") then
                -- Read the specific line from components.d.ts
                local line = ""
                local file = io.open(item.filename, "r")
                if file then
                  for i = 1, item.lnum do
                    line = file:read("*l")
                  end
                  file:close()

                  -- Look for import path: import('...path.vue')
                  local import_path = string.match(line, "import%(['\"](.-)['\"]%)")
                  if import_path then
                    -- Resolve the path relative to components.d.ts directory (.nuxt)
                    local nuxt_dir = vim.fn.fnamemodify(item.filename, ":h")
                    local resolved_path = vim.fn.resolve(nuxt_dir .. "/" .. import_path)

                    if vim.fn.filereadable(resolved_path) == 1 then
                      item.filename = resolved_path
                      item.lnum = 1
                      item.col = 1
                      items = { item } -- replace all items with our single resolved file
                      break
                    end
                  end
                end
              end
            end
          end
        end

        if #items == 1 then
          -- Jump directly if there's only one result
          vim.cmd("edit " .. items[1].filename)
          if items[1].lnum and items[1].col then
            pcall(vim.api.nvim_win_set_cursor, 0, { items[1].lnum, math.max(1, items[1].col) - 1 })
          end
        elseif #items > 1 then
          -- Open quickfix list if multiple results
          vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
          vim.cmd('copen')
        end
      end
    })
  end

  vim.keymap.set('n', 'gd', goto_definition, { buffer = bufnr })
end

local vue_ls = { 'vue-language-server', '--stdio' }
local lspconfig_util = require 'lspconfig.util'
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

local node_bin = vim.fn.trim(vim.fn.system("which node"))
local node_prefix = vim.fn.fnamemodify(node_bin, ":h:h")
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
        location = node_prefix .. "/lib/node_modules/@vue/language-server",
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
      tsdk = node_prefix .. "/lib/node_modules/typescript/lib"
    },
    vue = {
      hybridMode = true,
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

vim.lsp.config("stylelint_lsp", {
  filetypes = { "css", "scss", "less", "sass" },
})

vim.lsp.enable("stylelint_lsp")
