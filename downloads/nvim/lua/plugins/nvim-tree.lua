-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
  -- 插件名称
  "nvim-tree/nvim-tree.lua",

  -- 依赖项：文件图标支持（强烈推荐）
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  -- 设置懒加载：仅在调用命令时加载
  -- 这里使用 cmd 触发加载，这样不会在启动时自动打开文件树
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },

  -- 配置函数（插件加载后自动执行）
  config = function()
    -- 禁用 netrw（Neovim 内置文件浏览器），避免冲突
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- 可选：设置 nvim-tree 在打开目录时自动打开（例如使用 vim 打开目录时）
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   callback = function()
    --     if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    --       require("nvim-tree").open()
    --     end
    --   end,
    -- })

    -- 调用 setup 函数进行配置
    require("nvim-tree").setup({
      -- 基本视图设置
      view = {
        width = 30,                -- 文件树窗口宽度
        side = "left",              -- 显示在左侧
      },

      -- 渲染设置
      renderer = {
        icons = {
          show = {
            file = true,            -- 显示文件图标
            folder = true,          -- 显示文件夹图标
            folder_arrow = true,    -- 显示文件夹箭头
            git = true,             -- 显示 git 状态图标
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      -- 过滤规则
      filters = {
        dotfiles = false,           -- 是否显示点开头的文件（如 .gitignore）
        custom = { "^\\.git$" },    -- 额外隐藏 .git 文件夹（可选）
      },

      -- 文件操作
      actions = {
        open_file = {
          quit_on_open = false,      -- 打开文件后是否自动关闭文件树
          resize_window = true,      -- 打开文件后调整窗口大小
        },
      },

      -- 更新文件系统时的行为
      update_focused_file = {
        enable = true,               -- 当焦点切换到其他文件时，文件树自动定位到该文件
        update_cwd = false,           -- 是否同时更新根目录
      },

      -- 系统剪贴板集成（可选）
      system_open = {
        cmd = "xdg-open",             -- Linux 下使用系统默认程序打开文件
      },
    })

    -- 自定义快捷键（在普通模式下）
    -- 建议将快捷键放在这里，以便与插件一起管理
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- 切换文件树显示/隐藏
    keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
    -- 聚焦到文件树
    keymap("n", "<leader>f", ":NvimTreeFocus<CR>", opts)
    -- 在文件树中定位当前文件
    keymap("n", "<leader>ff", ":NvimTreeFindFile<CR>", opts)
  end,
}
