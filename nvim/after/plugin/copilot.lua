-- Github Copilot
vim.keymap.set("i", "<C-j>n", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-j>p", "<Plug>(copilot-previous)")
vim.keymap.set("i", "<C-j>s", "<Plug>(copilot-suggest)")
vim.keymap.set('i', '<C-j>a', 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
