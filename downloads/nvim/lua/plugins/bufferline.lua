-- ~/.config/nvim/lua/plugins/bufferline.lua
return {
  -- 核心插件：bufferline.nvim
  "akinsho/bufferline.nvim",
  version = "*", -- 使用最新稳定版，也可以固定为 "v4.*" 等 [citation:2]
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 必须，用于显示文件图标 [citation:2]
  },
  event = "VeryLazy", -- 延迟加载，不影响启动速度

  config = function()
    -- 基础设置：开启真彩色支持，这是必须的 [citation:1][citation:5][citation:7]
    vim.opt.termguicolors = true

    -- 引入 bufferline 模块
    local bufferline = require("bufferline")

    -- 核心配置
    bufferline.setup({
      options = {
        -- 模式: "buffers" 显示所有缓冲区， "tabs" 只显示真实的 tab [citation:1][citation:3][citation:6]
        mode = "buffers",

        -- 在标签上显示数字编号，方便用快捷键跳转 [citation:1][citation:3]
        numbers = "ordinal", -- 可以选 "ordinal" (顺序号), "buffer_id", 或 "both"

        -- 关闭标签的命令 (使用 Neovim 内置的 :bdelete)
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",

        -- 标签栏样式: 可选 "slant" (倾斜), "slope" (斜坡), "thin" (细线), "thick" (粗线) 等 [citation:2][citation:6]
        separator_style = "slant",

        -- 始终显示标签栏，即使只有一个标签
        always_show_bufferline = true,

        -- 显示图标
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,

        -- 颜色图标 (依赖 nvim-web-devicons)
        color_icons = true,

        -- 集成 LSP 诊断信息，在标签上显示错误/警告数量 [citation:2][citation:5][citation:10]
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,

        -- 偏移设置：为 nvim-tree 留出空间，让标签栏从文件树右侧开始 [citation:5][citation:10]
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    })

    -- ========== 常用快捷键映射 ==========
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- 1. 切换上一个/下一个标签
    map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", opts)        -- 下一个
    map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)     -- 上一个
    -- 也可以使用你更习惯的键位，例如 <C-h> 和 <C-l> [citation:5]
    -- map("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
    -- map("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", opts)

    -- 2. 按数字跳转到指定标签 (如果设置了 numbers = "ordinal")
    for i = 1, 9 do
      map("n", "<leader>" .. i, function()
        require("bufferline").go_to_buffer(i, true)
      end, { desc = "跳转到缓冲区 " .. i })
    end

    -- 3. 关闭缓冲区
    map("n", "<leader>bd", "<Cmd>bd<CR>", { desc = "关闭当前缓冲区" })                     -- 关闭当前
    map("n", "<leader>bD", "<Cmd>BufferLineCloseOthers<CR>", { desc = "关闭其他缓冲区" })  -- 关闭其他
    map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "关闭右侧缓冲区" })    -- 关闭右侧
    map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "关闭左侧缓冲区" })     -- 关闭左侧

    -- 4. 交互式选择/关闭缓冲区
    map("n", "<leader>bs", "<Cmd>BufferLinePick<CR>", { desc = "选择缓冲区" })            -- 交互式选择
    map("n", "<leader>bp", "<Cmd>BufferLinePickClose<CR>", { desc = "选择关闭缓冲区" })    -- 选择并关闭

    -- 5. 移动缓冲区位置
    map("n", "<leader>bm", "<Cmd>BufferLineMoveNext<CR>", { desc = "向右移动缓冲区" })     -- 向右移动
    map("n", "<leader>bM", "<Cmd>BufferLineMovePrev<CR>", { desc = "向左移动缓冲区" })     -- 向左移动

    -- 注意: 以上快捷键大多以 <leader> 开头，如果你的 leader 键是空格，操作会非常顺手。
  end,
}
