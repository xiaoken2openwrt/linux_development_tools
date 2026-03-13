-- ~/.config/nvim/lua/plugins/blink.lua
return {
  "saghen/blink.cmp",
  version = '1.*', -- 或者去掉版本号，使用最新代码
  -- --- 关键修改：添加 build 命令，让 lazy.nvim 在安装/更新时编译
  build = {
    -- 如果 Rust 环境已经配置好，cargo 会自动检测并使用合适的工具链。
    -- 如果担心工具链问题，可以在这里强制指定使用 nightly：
    -- 'rustup run nightly cargo build --release',
    'cargo build --release',
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- 如果你需要兼容某些 nvim-cmp 源，可以取消下面这行的注释
    -- { "saghen/blink.compat", opts = {} },
  },
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    -- --- 关键修改：告诉插件使用本地编译的 Rust 模糊匹配器
    fuzzy = {
      implementation = "rust",
      -- 或者使用 "prefer_rust" 让它优先用 Rust，没有则用 Lua 回退
    },
    snippets = { preset = 'luasnip' },
  },
}
