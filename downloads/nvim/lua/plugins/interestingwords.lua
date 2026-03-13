-- ~/.config/nvim/lua/plugins/interestingwords.lua
return {
  -- 插件地址
  "lfv89/vim-interestingwords",

  -- 懒加载：在需要时加载（例如按下快捷键时）
  keys = {
    { "<leader>i", mode = "n" },  -- 切换高亮
    { "<leader>iC", mode = "n" }, -- 清除所有高亮
    { "]i", mode = "n" },         -- 下一个高亮词
    { "[i", mode = "n" },         -- 上一个高亮词
  },

  config = function()
    -- 可选：自定义插件行为（如果需要）
    -- 例如，让高亮词保留颜色，或者设置导航键
    vim.g.interestingwords_use_default_nav = 0   -- 禁用默认的 n/N 导航（避免与原生搜索冲突）
    vim.g.interestingwords_highlight_colors = {  -- 自定义高亮颜色（最多可定义 6 种）
      'gui=bold ctermfg=16 ctermbg=154',
      'gui=bold ctermfg=16 ctermbg=121',
      'gui=bold ctermfg=16 ctermbg=197',
      'gui=bold ctermfg=16 ctermbg=103',
      'gui=bold ctermfg=16 ctermbg=180',
      'gui=bold ctermfg=16 ctermbg=222',
    }

    -- 定义快捷键映射（推荐使用自定义键位，避免干扰原生 n/N）
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- 1. 切换光标下单词的高亮（标记/取消标记）
    map("n", "<leader>i", ":call interestingwords#toggle()<CR>", opts)

    -- 2. 清除所有高亮
    map("n", "<leader>iC", ":call interestingwords#clear_all()<CR>", opts)

    -- 3. 跳转到下一个高亮词
    map("n", "]i", ":call interestingwords#goto_next()<CR>", opts)

    -- 4. 跳转到上一个高亮词
    map("n", "[i", ":call interestingwords#goto_prev()<CR>", opts)

    -- 5. （可选）在可视模式下高亮选中的文本
    -- map("v", "<leader>i", ":call interestingwords#visual_toggle()<CR>", opts)

    -- 如果你仍然希望使用默认的 n/N 导航，请将上面的 interestingwords_use_default_nav 设为 1，
    -- 并移除或注释掉 ]i 和 [i 的映射。
  end,
}
