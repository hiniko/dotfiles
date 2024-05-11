require("hiniko")

-- change direcotry to home dir if not started with an argument to a file
vim.cmd [[
	if argc() == 0
		cd ~
	endif
]]
