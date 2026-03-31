return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = {
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '                                                                                                                ',
          '                 ████ ██████                                  █████      ██                               ',
          '                ███████████                                    █████                                       ',
          '                █████████ ██████████████████████████████████████ ███   ███████████             ',
          '               █████████  ███     ███     ███  ████████████████ █████ ██████████████             ',
          '              █████████ ████████ ███     ████████████ █████████ █████ █████ ████ █████             ',
          '            ███████████ ███     ███     ██████  ███ █████████ █████ █████ ████ █████            ',
          '           ██████  ████████████████████████  ███ █████████ ████ █████ █████ ████ ██████           ',
          '                                                                                                                  ',
          '',
          '',
          '',
          '',
          '',
        },
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            action = 'Telescope find_files'
          },
          {
            icon = ' ',
            desc = 'Recent Files        ',
            key = 'r',
            action = 'Telescope oldfiles'
          },
          {
            icon = ' ',
            desc = 'Find Text           ',
            key = 'g',
            action = 'Telescope live_grep'
          },
          {
            icon = ' ',
            desc = 'Config              ',
            key = 'c',
            action = 'edit ~/.config/pureNvim/init.lua'
          },
          {
            icon = ' ',
            desc = 'Quit                ',
            key = 'q',
            action = 'quit'
          },
        },
        footer = {

        }  -- your footer
      }
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
