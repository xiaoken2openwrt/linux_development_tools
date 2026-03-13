-- ~/.config/nvim/lua/plugins/mason.lua
return {
  "mason_org/mason.nvim",
  build = ":MasonUpdate", -- 可选，更新 mason 的注册源
  config = function()
    require("mason").setup({
      -- 这里可以添加 mason 的配置选项
      -- 例如设置安装路径、UI 等，一般默认即可
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
