-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- telescope - Ui for lists
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	-- Dracula Theme
	use({ 'Mofiqul/dracula.nvim', as = 'dracula' })

	-- Tresitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Harpoon - Quick pinning of files / commands
	use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
	use {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } }
	}

	-- Undo tree  
	use "mbbill/undotree"

	-- fugitive - Git
	use "tpope/vim-fugitive"

	-- Zero-LSP - Managed language server setup
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ 'williamboman/mason.nvim' }, -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	}

	-- Comment Commenting support
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- Github Copilot
	use("github/copilot.vim")

	-- Bufferline - Fancy bugger managmeent (tabs)
	use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
	-- Tree  
	use "nvim-tree/nvim-tree.lua"

	-- ToggleTerm - terminal management
	use {"akinsho/toggleterm.nvim", tag = '*'}

	-- LuaLine - Status Line Mangement
	use { "nvim-lualine/lualine.nvim" }

	-- GuessIndent - Because everyone has to do it differntly
	use { "nmac427/guess-indent.nvim" }

	-- DAP - Debug Adapter Protocol
	 use { 'mfussenegger/nvim-dap' }

	-- Go DAP 
	use { 'leoluz/nvim-dap-go' }




end)
