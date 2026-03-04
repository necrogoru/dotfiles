return {
  "nvim-lualine/lualine.nvim",
  -- event = "VimEnter",
  config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine = require('lualine')

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = { left = '', right = '' },
        theme = "auto",
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {
          {
            'mode'
          }
        },
        lualine_b = {
          {
            -- Root directory name
            function()
              local cwd = vim.fn.getcwd()
              local home = os.getenv("HOME")
              if cwd == home then
                return "~"
              else
                return vim.fn.fnamemodify(cwd, ":t")
              end
            end,
            padding = { left = 2 },
          },
          {
            'filename',
            path = 1,
            cond = conditions.buffer_not_empty,
            padding = { left = 2 },
            -- color = { fg = colors.magenta, gui = 'bold' },
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            -- diagnostics_color = {
            --   error = { fg = colors.red },
            --   warn = { fg = colors.yellow },
            --   info = { fg = colors.cyan },
            -- },
          }
        },
        lualine_c = {
          '%=', --[[ add your center components here in place of this comment ]]
        },
        lualine_x = {
          {
            -- Lsp server name .
            function()
              local msg = 'No Active Lsp'
              local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = '',
            -- color = { fg = '#ffffff', gui = 'bold' },
          }
        },
        lualine_y = {
          {
            'filetype',
            icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
            -- color = { fg = colors.green, gui = 'bold' },
          },
          {
            'branch',
            icon = '',
            -- color = { fg = colors.violet, gui = 'bold' },
          },
          {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            cond = conditions.hide_in_width,
          }
        },
        lualine_z = {
          {
            'location',
            separator = { left = '' },
            left_padding = 2
          },
        },
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
