-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  -- 主插件
  "nvim-treesitter/nvim-treesitter",

  -- 版本锁定（可选，建议使用最新）
  -- version = "v0.9.3",

  -- 依赖：文本对象扩展（用于更丰富的选择）
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  -- 主配置函数
  config = function()
    -- 引入 treesitter 配置模块
    local ts_config = require("nvim-treesitter.configs")

    -- 基础配置
    ts_config.setup({
      -- 自动安装的语言解析器
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        -- 可以按需添加其他语言，如 "python", "rust" 等
      },

      -- 启用语法高亮
      highlight = {
        enable = true,
        -- 禁用某些文件类型的高亮（如大文件）
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- 使用 treesitter 高亮还是正则（建议 true）
        additional_vim_regex_highlighting = false,
      },

      -- 启用基于 treesitter 的缩进
      indent = {
        enable = true,
      },

      -- 增量选择（按语法结构逐级扩展选区）
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",   -- 初始化选区（可自定义）
          node_incremental = "<C-space>", -- 扩展到上级节点
          scope_incremental = false,      -- 扩展到更大作用域（可选）
          node_decremental = "<bs>",      -- 回退到下级节点（按退格键）
        },
      },

      -- 文本对象选择（需要 nvim-treesitter-textobjects 插件）
      textobjects = {
        select = {
          enable = true,
          -- 向前搜索（自动查找匹配的文本对象）
          lookahead = true,
          keymaps = {
            -- 函数
            ["af"] = "@function.outer", -- 外含整个函数
            ["if"] = "@function.inner", -- 内含函数体（不含签名）
            -- 类
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- 块
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            -- 条件/循环
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            -- 注释
            ["ac"] = "@comment.outer",
            ["ic"] = "@comment.inner",
            -- 参数/参数列表
            ["a,"] = "@parameter.outer",
            ["i,"] = "@parameter.inner",
            -- 返回值
            ["ar"] = "@return.outer",
            ["ir"] = "@return.inner",
            -- 数字常量
            ["an"] = "@number.outer",
            ["in"] = "@number.inner",
          },
        },
        -- 交换（swap）功能（如果需要）
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner", -- 交换下一个参数
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
          },
        },
        -- 移动（move）功能（跳转到下一个/上一个对象）
        move = {
          enable = true,
          set_jumps = true, -- 记录跳转历史，方便 <C-o> 返回
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })

    -- ========== 自定义快捷键 ==========
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- 1. 查看当前光标下的语法节点类型（用于调试 treesitter）
    map("n", "<leader>tn", function()
      local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
      if node then
        print("Node type: " .. node:type())
      else
        print("No node under cursor")
      end
    end, { desc = "显示当前节点类型" })

    -- 2. 切换 treesitter 高亮（临时关闭/开启）
    map("n", "<leader>th", function()
      local current = vim.bo.syntax
      vim.cmd("TSBufToggle highlight")
      print("Treesitter highlight toggled")
    end, { desc = "切换语法高亮" })

    -- 3. 列出所有已安装的解析器
    map("n", "<leader>ti", function()
      require("telescope.builtin").find_files({
        prompt_title = "Treesitter Parsers",
        cwd = vim.fn.stdpath("data") .. "/tree-sitter",
        search_dirs = { vim.fn.stdpath("data") .. "/tree-sitter" },
      })
    end, { desc = "查看已安装解析器" })

    -- 4. 更新所有解析器
    map("n", "<leader>tU", function()
      vim.cmd("TSUpdate all")
    end, { desc = "更新所有解析器" })

    -- 5. 手动触发增量选择（如果不想用 <C-space> 等，可自定义）
    -- 已经通过 incremental_selection.keymaps 配置了，无需重复

    -- 6. 使用文本对象时的辅助提示（可选）
    -- 例如：在 visual 模式下按 af 会选中函数
    -- 这个已经通过 textobjects.select.keymaps 配置

    -- 注意：文本对象快捷键直接可用，例如 `vaf` 选中一个函数，`vif` 选中函数体
    -- 更多用法参见 :help nvim-treesitter-textobjects
  end,
}
