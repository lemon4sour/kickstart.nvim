return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, silent = true }

            vim.keymap.set('n', 'K', function()
              vim.cmd.RustLsp { 'hover', 'actions' }
            end, opts)

            vim.keymap.set('n', '<Leader>dt', function()
              vim.cmd.RustLsp 'testables'
            end, vim.tbl_extend('force', opts, { desc = 'RustLsp testables' }))

            vim.keymap.set('n', '<Leader>ds', function()
              vim.cmd.RustLsp 'debuggables'
            end, vim.tbl_extend('force', opts, { desc = 'RustLsp debuggables' }))
          end,
        },
      }
    end,
  },
  --[[
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    config = function()
      require('crates').setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require('cmp').setup.buffer {
        sources = { { name = 'crates' } },
      }
    end,
  },
  ]]
  --
}
