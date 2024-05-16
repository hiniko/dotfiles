require("go").setup()

-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- Remapes for go usage
-- Testing 
vim.keymap.set("n", "<leader>gt", ":GoTest<CR>")
vim.keymap.set("n", "<leader>gtf", ":GoTestFunc<CR>", { noremap = true})
vim.keymap.set("n", "<leader>gts", ":GoTestFunc -s<CR>",  { noremap = true})

-- Add tests
vim.keymap.set("n","<leader>gta", ":GoAddTest<CR>")

-- Docs
vim.keymap.set("n", "<leader>grd", ":GoDoc<CR>")


-- Debug
vim.keymap.set("n", "<leader>gd", ":GoDebug<CR>")
-- Set breakpoint
vim.keymap.set("n", "<leader>gdb", ":GoDebug -b<CR>", { noremap = true })
-- Stop Debugging
vim.keymap.set("n", "<leader>gds", ":GoDebug -s<CR>", { noremap = true })
-- Debug Test
vim.keymap.set("n", "<leader>gdt", ":GoDebug -n<CR>", { noremap = true })
-- Restart debug 
vim.keymap.set("n", "<leader>gdr", ":GoDebug -R<CR>", { noremap = true })
-- Debug show bindings
vim.keymap.set("n", "<leader>gd?", ":GoDbgKeys<CR>", { noremap = true })
