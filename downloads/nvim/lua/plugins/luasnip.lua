-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",  -- 使用稳定版本
  build = "make install_jsregexp",  -- 可选，用于提高正则表达式性能
  dependencies = {
    "rafamadriz/friendly-snippets",  -- 常用片段库
  },
  config = function()
    -- 加载友好的片段
    require("luasnip.loaders.from_vscode").lazy_load()

    -- 可选：配置 Luasnip 的一些选项
    -- 例如：
    -- vim.keymap.set({"i", "s"}, "<C-k>", function() require("luasnip").jump(1) end, {silent = true})
    -- vim.keymap.set({"i", "s"}, "<C-j>", function() require("luasnip").jump(-1) end, {silent = true})
  end,
}
