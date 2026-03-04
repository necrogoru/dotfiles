return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ["<C-o>"] = function(prompt_bufnr)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local picker = action_state.get_current_picker(prompt_bufnr)
            local multi = picker:get_multi_selection()
            if #multi > 0 then
              actions.close(prompt_bufnr)
              for _, entry in ipairs(multi) do
                local file_path = entry.path or entry[1] or entry.value
                vim.cmd("edit " .. vim.fn.fnameescape(file_path))
              end
            else
              actions.select_default(prompt_bufnr)
            end
          end,
        },
        n = {
          ["<C-o>"] = function(prompt_bufnr)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local picker = action_state.get_current_picker(prompt_bufnr)
            local multi = picker:get_multi_selection()
            if #multi > 0 then
              actions.close(prompt_bufnr)
              for _, entry in ipairs(multi) do
                local file_path = entry.path or entry[1] or entry.value
                vim.cmd("edit " .. vim.fn.fnameescape(file_path))
              end
            else
              actions.select_default(prompt_bufnr)
            end
          end,
        },
      },
    },
  }
  end,
  keys = {
    "ga", -- Default invocation prefix
    { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    "Subs",
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
  -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
  -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
  -- available after the first executing of it or after a keymap of text-case.nvim has been used.
  lazy = false,
}
