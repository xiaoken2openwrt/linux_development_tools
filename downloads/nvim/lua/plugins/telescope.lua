-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  -- 主插件
  "nvim-telescope/telescope.nvim",

  -- 指定 tag（可选，使用最新稳定版）
  tag = "0.1.8",

  -- 依赖项
  dependencies = {
    "nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter", -- 显式依赖
    -- 如果你需要文件系统操作（如删除文件），可以取消下面行的注释
    -- { "nvim-tree/nvim-web-devicons" },
    -- 创建一个模糊查找器（性能增强，可选）
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },

  -- 确保 treesitter 先加载
  after = "nvim-treesitter",

  -- 配置函数
  config = function()
    -- 引入 telescope 模块
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    -- 核心配置
    telescope.setup({
      defaults = {
        -- 文件预览器
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        -- 布局配置
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.85,
          height = 0.9,
        },

        -- 排序策略：升序（结果从上到下排列）
        sorting_strategy = "ascending",
        -- 滚动速度
        scroll_speed = 2,

        -- 快捷键映射（核心部分）
        mappings = {
          i = {  -- 插入模式下的快捷键
            ["<C-j>"] = actions.move_selection_next,        -- 向下移动
            ["<C-k>"] = actions.move_selection_previous,    -- 向上移动
            ["<C-n>"] = actions.cycle_history_next,         -- 历史记录下一条
            ["<C-p>"] = actions.cycle_history_prev,         -- 历史记录上一条
            ["<C-u>"] = actions.preview_scrolling_up,       -- 预览窗口向上滚动
            ["<C-d>"] = actions.preview_scrolling_down,     -- 预览窗口向下滚动
            ["<C-x>"] = actions.select_horizontal,          -- 水平分割打开
            ["<C-v>"] = actions.select_vertical,            -- 垂直分割打开
            ["<C-t>"] = actions.select_tab,                 -- 新标签页打开
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse, -- 多选
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist, -- 发送到 quickfix
            ["<C-c>"] = actions.close,                      -- 关闭
            ["<C-/>"] = actions.which_key,                  -- 显示所有快捷键帮助
            ["<C-l>"] = actions.select_default + actions.center,  -- 选中并居中
          },
          n = {  -- 普通模式下的快捷键
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["q"] = actions.close,
            ["?"] = actions.which_key,
          },
        },
      },

      -- 扩展配置
      extensions = {
        fzf = {
          fuzzy = true,                    -- 启用模糊匹配
          override_generic_sorter = true,  -- 覆盖默认排序器
          override_file_sorter = true,     -- 覆盖文件排序器
          case_mode = "smart_case",        -- 智能大小写
        },
      },
    })

    -- 加载扩展（如果成功编译了 fzf-native）
    pcall(telescope.load_extension, "fzf")

    -- ========== 常用快捷键映射 ==========
    -- 注：<leader> 键建议在 init.lua 中设置为空格键：vim.g.mapleader = " "

    -- 文件查找
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
    vim.keymap.set("n", "<leader>fa", builtin.find_files, { desc = "查找所有文件" })  -- 需要额外配置

    -- 文本搜索
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "全局搜索文本" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "搜索当前光标下单词" })
    vim.keymap.set("v", "<leader>fw", function()
      local text = vim.fn.getreg('v')
      require("telescope.builtin").grep_string({ search = text })
    end, { desc = "搜索选中的文本" })

    -- Git 相关
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git 提交历史" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git 状态" })
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git 分支" })

    -- 缓冲区/文件历史
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "已打开的缓冲区" })
    vim.keymap.set("n", "<leader>fh", builtin.oldfiles, { desc = "最近打开的文件历史" })
    vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "寄存器内容" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "查看快捷键映射" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "查看命令历史" })

    -- 帮助文档
    vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "查找帮助标签" })
    vim.keymap.set("n", "<leader>mn", builtin.man_pages, { desc = "查找手册页" })

    -- 诊断信息（需要 LSP 支持）
    vim.keymap.set("n", "<leader>ld", builtin.diagnostics, { desc = "查看诊断信息" })
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "文档符号" })
    vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "工作区符号" })
  end,
}
