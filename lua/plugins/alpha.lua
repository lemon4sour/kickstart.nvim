function _G.project_oldfiles()
  local cwd = vim.fn.getcwd()

  local files = vim.tbl_filter(function(file)
    return file:match('^' .. vim.pesc(cwd))
  end, vim.v.oldfiles)

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Recent Files',
      finder = require('telescope.finders').new_table {
        results = files,
      },
      previewer = require('telescope.config').values.file_previewer {},
      sorter = require('telescope.config').values.generic_sorter {},
    })
    :find()
end

return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }
    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '  > Find file', ':Telescope find_files<CR>'),
      dashboard.button('r', '  > Recent', ':lua project_oldfiles()<CR>'),
      dashboard.button('s', '  > Settings', ':NvimTreeOpen ~/.config/nvim<CR>'),
      dashboard.button('q', '󰩈 > Quit NVIM', ':qa<CR>'),
    }
    alpha.setup(dashboard.opts)
  end,
}
