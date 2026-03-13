-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",       -- 依赖 mason
    "neovim/nvim-lspconfig",         -- 依赖 lspconfig
  },
  config = function()
    require("mason-lspconfig").setup({
      -- 确保自动安装以下语言服务器（可选）
      ensure_installed = {
        "clangd",         -- C/C++
        -- "pyright",     -- Python
        -- "lua_ls",      -- Lua
      },
      automatic_installation = true, -- 如果发现缺少服务器，自动安装
	  -- 空 handlers 防止自动调用旧版 lspconfig 的 setup
      handlers = { function() end },
  })
  end,
}
