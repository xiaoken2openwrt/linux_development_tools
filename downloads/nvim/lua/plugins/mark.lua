-- ~/.config/nvim/lua/plugins/mark.lua
return {
  -- 使用经典的 mark.vim 仓库
  "vim-scripts/Mark",

  -- 可选：设置懒加载，当需要使用其快捷键或命令时再加载
  -- 这样不会影响 Neovim 启动速度
  event = "VeryLazy",
  -- 或者你也可以用 keys 来触发加载，例如：
  -- keys = { "\\m", "\\n" },

  -- 配置部分（传统 Vim 插件通常不需要 setup）
  config = function()
    -- 这里可以设置一些全局变量来定制插件行为
    -- 例如：设置高亮颜色（可选）
    -- vim.cmd("highlight MarkWord1 ctermbg=Cyan ctermfg=Black guibg=#8CCBEA guifg=Black")
    -- vim.cmd("highlight MarkWord2 ctermbg=Green ctermfg=Black guibg=#A4E57E guifg=Black")
    -- 你可以根据需要定义更多颜色

    -- 如果你已经设置了 leader 键为空格，那么下面这些快捷键会自动以空格开头
    -- 例如：默认的 <Leader>m 会变成 <space>m
    -- 如果你不喜欢默认的 leader 键，可以在 init.lua 开头设置：
    -- vim.g.mapleader = " "

    -- 提示：插件本身会自动加载，无需额外调用
  end,
}
