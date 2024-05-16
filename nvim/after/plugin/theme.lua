-- Theme Settings
local dracula = require('dracula')

local colors = require('dracula').colors()

dracula.setup({
	italic_comment = true,
	overrides = {
		CursorColumn = { bg = colors.selection, },
	}
})

vim.cmd[[colorscheme dracula]]

