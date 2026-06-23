return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git hunk' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git hunk' })

        -- Actions

        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset current hunk in visual mode' })

        map('n', '<leader>hs', gitsigns.stage_buffer, { desc = 'Stage current buffer (file)' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview current hunk in a separate window' })
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview current hunk in a separate window inline' })

        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'Blame current line' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git diff current buffer' })

        map('n', '<leader>hD', function()
          gitsigns.diffthis '~'
        end, { desc = 'Git diff only changes' })

        map('n', '<leader>hQ', function()
          gitsigns.setqflist 'all'
        end, { desc = 'List all the changes in a new window at the bottom' })
        map('n', '<leader>hq', gitsigns.setqflist, { desc = 'List all changes at the bottom' })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle current line blame' })
        map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff and highlight it' })

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Allows the current hunk to be manipulated on (yank, delete, etc.' })
      end,
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'tpope/vim-fugitive',
    options = {},
  },
}
