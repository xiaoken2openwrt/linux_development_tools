-- ~/.config/nvim/lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- 用于显示文件图标
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",           -- 自动匹配当前 colorscheme
        component_separators = { left = "", right = "" }, -- 组件间分隔符
        section_separators = { left = "", right = "" },   -- 区块分隔符
        disabled_filetypes = {     -- 禁用状态栏的文件类型
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},         -- 忽略焦点的窗口
        always_divide_middle = true, -- 分割线居中
      },
      sections = {  -- 定义左侧、右侧各区域显示的内容
        lualine_a = { "mode" },     -- 模式
        lualine_b = { "branch", "diff", "diagnostics" }, -- Git 分支、增删改、诊断信息
        lualine_c = { "filename" }, -- 文件名
        lualine_x = { "encoding", "fileformat", "filetype" }, -- 编码、格式、文件类型
        lualine_y = { "progress" }, -- 进度
        lualine_z = { "location" }, -- 位置（行号、列号）
      },
      inactive_sections = {  -- 非活跃窗口的显示
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},   -- 标签栏（可留空，或配置 bufferline 等插件）
      winbar = {},    -- 窗口栏（类似 VSCode 的面包屑）
      inactive_winbar = {},
      extensions = { "fzf" }, -- 为 fzf 等插件提供额外支持（可选）
    })
  end,
}
