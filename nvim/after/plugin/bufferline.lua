vim.opt.termguicolors = true
require("bufferline").setup {
	options = {
		numbers = "both",
		show_buffer_close_icons = false,
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "Directory",
				text_align = "center",
				separator = true,
			}
		}

	}
}
