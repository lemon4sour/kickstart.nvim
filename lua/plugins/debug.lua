return {
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = false,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = { 'codelldb' },
    }

    -- Nvim DAP
    vim.keymap.set('n', '<Leader>dl', "<cmd>lua require'dap'.step_into()<CR>", { desc = 'Debugger step into' })
    vim.keymap.set('n', '<Leader>dj', "<cmd>lua require'dap'.step_over()<CR>", { desc = 'Debugger step over' })
    vim.keymap.set('n', '<Leader>dk', "<cmd>lua require'dap'.step_out()<CR>", { desc = 'Debugger step out' })
    vim.keymap.set('n', '<Leader>dc', "<cmd>lua require'dap'.continue()<CR>", { desc = 'Debugger continue' })
    vim.keymap.set('n', '<Leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = 'Debugger toggle breakpoint' })
    vim.keymap.set(
      'n',
      '<Leader>dd',
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      { desc = 'Debugger set conditional breakpoint' }
    )
    vim.keymap.set('n', '<Leader>de', "<cmd>lua require'dap'.terminate()<CR>", { desc = 'Debugger reset' })
    vim.keymap.set('n', '<Leader>dr', "<cmd>lua require'dap'.run_last()<CR>", { desc = 'Debugger run last' })
    vim.keymap.set('n', '<Leader>dp', "<cmd>lua require'dapui'.toggle()<CR>", { desc = 'Debugger see last session' })
    -- rustaceanvim
    vim.keymap.set('n', '<Leader>dt', "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = 'Debugger testables' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  end,
}
