vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

do
  vim.opt.termguicolors = true

  local transparent_enabled = false
  local original_hl = {}

  local groups = {
    'Normal',
    'NonText',
    'LineNr',
    'Folded',
    'EndOfBuffer',
    'SignColumn',
    'NormalFloat',
  }

  -- Capture original backgrounds
  local function cache_original()
    for _, group in ipairs(groups) do
      if not original_hl[group] then
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        original_hl[group] = hl.bg
      end
    end
  end

  local function set_transparent(enable)
    cache_original()

    for _, group in ipairs(groups) do
      if enable then
        vim.api.nvim_set_hl(0, group, { bg = 'none' })
      else
        vim.api.nvim_set_hl(0, group, { bg = original_hl[group] })
      end
    end

    transparent_enabled = enable
  end

  -- Toggle
  vim.keymap.set('n', '<leader>\\', function()
    set_transparent(not transparent_enabled)
  end, { desc = 'Toggle background transparency' })
end
