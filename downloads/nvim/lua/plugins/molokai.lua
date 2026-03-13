-- ~/.config/nvim/lua/plugins/molokai.lua
return {
  -- 1. 选择你喜欢的 molokai 配色仓库
  -- 常见的选项：
  --   - 'tomasr/molokai'      (经典 Vim 版本)
  --   - 'fatih/molokai'       (另一个流行版本)
  --   - 如果是 Neovim 专用 Lua 主题，可能是 '~/molokai.nvim' 等
  "tomasr/molokai",

  -- 2. 确保主题在启动时立即加载（不延迟）
  lazy = false,

  -- 3. 设置较高优先级，让主题在其他插件之前加载
  priority = 1000,

  -- 4. 配置函数：实际应用配色方案
  config = function()
    -- 对于大多数传统 Vim 主题，只需执行 colorscheme 命令
    vim.cmd.colorscheme("molokai")

    -- 如果主题是 Lua 风格且需要调用 setup，请改为：
    -- require('molokai').setup({})   -- 先 setup
    -- vim.cmd.colorscheme("molokai") -- 再应用
  end,
}
