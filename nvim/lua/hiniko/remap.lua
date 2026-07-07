vim.g.mapleader = " "

-- Better block movement
vim.keymap.set("n", "<C-J>", "{")
vim.keymap.set("n", "<C-K>", "}")


-- Resource the lua config
vim.keymap.set("n","<leader>qq", ":luafile $MYVIMRC<CR>")


-- Curated keymap help screen. Edit the groups below to keep it in sync.
-- Shown on empty startup, or on demand via :Keymap / <leader>m.
local KEYMAP_HELP = {
	{ "General", {
		{ ":keymap / <leader>m", "Show this help screen" },
		{ "<leader>qq", "Reload nvim config ($MYVIMRC)" },
		{ "<C-J> / <C-K>", "Jump to prev/next blank-line block" },
	}},
	{ "LSP  (active in a file with a language server)", {
		{ "gd / gD / gi", "Go to definition / declaration / implementation" },
		{ "gr", "List references" },
		{ "K", "Hover docs (capital K)" },
		{ "<leader>rn", "Rename symbol" },
		{ "<leader>ca", "Code action" },
		{ "[d / ]d", "Prev / next diagnostic" },
	}},
	{ "Completion  (insert mode, nvim-cmp)", {
		{ "<C-Space>", "Trigger completion menu" },
		{ "<CR>", "Confirm selected completion" },
		{ "<C-j> / <C-k>", "Select prev / next item" },
		{ "<C-f> / <C-b>", "Jump fwd / back in snippet" },
	}},
	{ "Files & Search (Telescope)", {
		{ "<leader>pf", "Find files" },
		{ "<leader>pg", "Find git files" },
		{ "<leader>ps", "Grep for a string" },
		{ "<leader>pv", "Focus file tree (nvim-tree)" },
	}},
	{ "Harpoon", {
		{ "<leader>ha", "Add file to harpoon" },
		{ "<leader>ho", "Open harpoon menu (telescope)" },
		{ "<C-h/j/k/l>", "Jump to harpoon file 1/2/3/4" },
		{ "<C-S-P> / <C-S-N>", "Prev / next harpoon file" },
	}},
	{ "Git", {
		{ "<leader>gs", "Git status (fugitive)" },
		{ "<leader>u",  "Toggle undotree" },
	}},
	{ "Go", {
		{ "<leader>gt / gtf / gts", "Go test / test func / test func -s" },
		{ "<leader>gta", "Go add test" },
		{ "<leader>grd", "Go doc" },
		{ "<leader>gd", "Go debug (gd/gdb/gds/gdt/gdr for variants)" },
		{ "<leader>gd?", "Go debug keys" },
	}},
	{ "Terminal", {
		{ "<leader>tt", "Toggle terminal" },
		{ "<C-Space>", "Terminal: exit to normal mode" },
		{ "<C-h/j/k/l>", "Terminal: move between windows" },
	}},
	{ "Editor settings (from settings.lua, FYI)", {
		{ "tabs", "4-wide (tabstop/shiftwidth = 4)" },
		{ "clipboard", "yanks go to system clipboard" },
		{ "whitespace", "shown: » tab · trail ↲ eol" },
	}},
}

function ShowMappings()
	local leader = vim.g.mapleader == " " and "Space" or tostring(vim.g.mapleader)
	local lines = { "", "  NVIM KEYMAPS   (leader = " .. leader .. ")   (q to close)", "" }
	for _, group in ipairs(KEYMAP_HELP) do
		table.insert(lines, "  " .. group[1])
		for _, m in ipairs(group[2]) do
			table.insert(lines, string.format("    %-24s %s", m[1], m[2]))
		end
		table.insert(lines, "")
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].filetype = "keymaphelp"
	vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = buf, silent = true })

	vim.api.nvim_set_current_buf(buf)
end

vim.api.nvim_create_user_command("Keymap", ShowMappings, { desc = "Show keymap help" })
-- User commands must be Capitalised; let lowercase `:keymap` expand to `:Keymap`.
vim.cmd("cabbrev keymap Keymap")
vim.keymap.set("n", "<leader>m", ShowMappings, { desc = "Show keymap help" })

-- Show help on startup when nvim opens with no file argument.
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line("$")) == -1 then
			ShowMappings()
		end
	end,
})
