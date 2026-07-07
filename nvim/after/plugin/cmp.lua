local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
	snippet = {
		expand = function(args) luasnip.lsp_expand(args.body) end,
	},
	sources = {
		{ name = 'nvim_lsp' },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-j>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-k>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

		-- Navigate between snippet placeholders
		['<C-f>'] = cmp.mapping(function() if luasnip.jumpable(1) then luasnip.jump(1) end end, { 'i', 's' }),
		['<C-b>'] = cmp.mapping(function() if luasnip.jumpable(-1) then luasnip.jump(-1) end end, { 'i', 's' }),
	},
})
