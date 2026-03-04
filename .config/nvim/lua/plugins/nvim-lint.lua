return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPre", "BufNewFile" },
      config = function()
      local lint = require('lint')

      -- Configurar linters por tipo de archivo
      lint.linters_by_ft = {
        typescript = { 'eslint_d', 'oxlint' },
        typescriptreact = { 'eslint_d', 'oxlint' },
        javascript = { 'eslint_d', 'oxlint' },
        javascriptreact = { 'eslint_d', 'oxlint' },
        vue = { 'eslint_d', 'oxlint' },
        markdown = { 'vale' },
        text = { 'vale' },
      }

      lint.linters.vale = {
        cmd = "vale",
        args = { "--config=" .. (os.getenv("HOME") or "") .. "/.config/vale/vale.ini", "$FILENAME" },
        stream = "stdout",
        ignore_exitcode = true,
      }

      -- Crear grupo de autocmds
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Solo ejecutar lint en archivos que tengan linters configurados
          local ft = vim.bo.filetype
          if lint.linters_by_ft[ft] then
            lint.try_lint()
          end
        end,
      })

      -- Comando personalizado para ejecutar lint manualmente
      vim.api.nvim_create_user_command("LintRun", function()
        lint.try_lint()
      end, { desc = "Run linter for current buffer" })

      -- Comando para mostrar información de lint
      vim.api.nvim_create_user_command("LintInfo", function()
        local ft = vim.bo.filetype
        local linters = lint.linters_by_ft[ft] or {}
        if #linters == 0 then
          print("No linters configured for filetype: " .. ft)
        else
          print("Linters for " .. ft .. ": " .. table.concat(linters, ", "))
        end
      end, { desc = "Show linter info for current buffer" })
    end,
}
