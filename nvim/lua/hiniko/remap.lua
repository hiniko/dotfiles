vim.g.mapleader = " "

vim.keymap.set("n", "<C-J>", "{")
vim.keymap.set("n", "<C-K>", "}")



-- split windows creating a terminal buffer that is already in insert modei
vim.keymap.set("n", "<leader>sh", "o<C-w>sp:term<CR>i")

-- Show the active mappings in a new buffer
function ShowMappings()
	-- redirect the output of the map command to register a
	vim.api.nvim_command('redir @a')
	vim.api.nvim_command('silent map')
	vim.api.nvim_command('redir END')

	-- create a new buffer and set it to be a scratch buffer
	vim.api.nvim_command("vnew")
	vim.api.nvim_command('put a')

	-- setup the new buffer
	vim.api.nvim_command('setlocal buftype=nofile')
	vim.api.nvim_command('setlocal noswapfile')
	vim.api.nvim_command('setlocal nomodifiable')
	vim.api.nvim_command('setlocal nolist')
	vim.api.nvim_command('setlocal nowrap')
	vim.api.nvim_command('setlocal syntax=conf')
	vim.api.nvim_command('setlocal filetype=map')


	-- ouput registered a to the new buffer
	vim.api.nvim_command('silent map')

end

vim.keymap.set("n", "<leader>m", ":lua ShowMappings()<CR>", { desc = "Show Active mappings" })
