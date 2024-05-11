-- change the tab width to 4
vim.opt.tabstop = 4

-- enable the sign column
vim.opt.signcolumn = "yes"

-- enable line numbers
vim.opt.number = true

-- Set auto text formatting options see :help fo-table for more 
vim.opt.formatoptions = "tcqj"

-- show whitespace characters
vim.opt.list = true

vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    extends = "⟩",
    precedes = "⟨",
    nbsp = "␣",
	eol = "↲",
}
