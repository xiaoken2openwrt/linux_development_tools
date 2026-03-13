-- ~/.config/nvim/lua/plugins/gitsigns.lua
return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup({
      -- 开启行级追溯
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- 导航
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- 操作
        map('n', '<leader>gs', gs.stage_hunk)
        map('n', '<leader>gr', gs.reset_hunk)
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>gS', gs.stage_buffer)
        map('n', '<leader>gR', gs.reset_buffer)
        map('n', '<leader>gp', gs.preview_hunk)
        map('n', '<leader>gb', function() gs.blame_line{full=true} end)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function() gs.diffthis('~') end)
        map('n', '<leader>gB', gs.toggle_current_line_blame)
      end
    })
  end
}
