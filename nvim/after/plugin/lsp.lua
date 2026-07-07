-- Native LSP setup for nvim 0.11+ (vim.lsp.config / vim.lsp.enable).
-- mason installs the servers; mason-lspconfig auto-enables them.

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		-- "ts_ls",
		"eslint",
		"gopls",
		"lua_ls",
	},
	-- After vim.lsp.config below, auto-enable every installed server.
	automatic_enable = true,
})

-- Advertise nvim-cmp's completion capabilities to every server.
vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- lua_ls: teach it the `vim` global and the runtime files so editing this
-- config doesn't throw "undefined global vim" warnings everywhere.
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = { library = { vim.env.VIMRUNTIME } },
		},
	},
})

-- LSP keymaps, attached per-buffer when a server connects.
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
		vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
	end,
})
