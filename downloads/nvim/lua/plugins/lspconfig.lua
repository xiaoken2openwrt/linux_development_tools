-- ~/.config/nvim/lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- 不需要直接依赖 blink.cmp，但会在配置中检测
  },
  config = function()
    -- 通用 on_attach 函数，附加快捷键
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }

	  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      -- 悬停显示文档
	  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	  -- 跳转类型定义
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
	  -- 诊断跳转
	  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end

    -- 获取 capabilities：如果 blink.cmp 存在，使用其增强能力
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    -- 使用新 API 配置 clangd
    vim.lsp.config('clangd', {
      cmd = { 'clangd' },                     -- 假设 clangd 已在 PATH 中（mason 会添加）
      root_markers = { '.git', 'compile_commands.json', 'Makefile' },
      filetypes = { 'c', 'cpp' },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- 启用 clangd
    vim.lsp.enable('clangd')

	-- 设置一个更短的更新检测时间（默认是4000ms）
	vim.o.updatetime = 1000

	-- 创建一个自动命令：当光标停留时，打开诊断信息的浮动窗口
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		callback = function()
			vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
		end,
	})
	end,
}
