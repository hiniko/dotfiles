local current_file = debug.getinfo(1, "S").source:sub(2)

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print("Installing packer close and reopen Neovim...")
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("failed to call packer")
  return
end

local function get_file_hash(file_path)
	local file = io.open(file_path, "rb")  -- Read file in binary mode
	if not file then
	  return nil
	end
	local content = file:read("*all")      -- Read the entire file
	file:close()
  
	return vim.fn.sha256(content)          -- Return the hash of the file content
  end
  
  local function get_stored_hash(hash_file)
	local file = io.open(hash_file, "r")
	if not file then
	  return nil
	end
	local stored_hash = file:read("*all")
	file:close()
  
	return stored_hash
  end
  
  local function store_hash(hash_file, hash)
	local file = io.open(hash_file, "w")
	if file then
	  file:write(hash)
	  file:close()
	end
  end
  
  local function sync_if_needed(plugin_file)
	local hash_file = vim.fn.stdpath('config') .. '/plugin_hash.txt'
	local current_hash = get_file_hash(plugin_file)
	local stored_hash = get_stored_hash(hash_file)

	if current_hash and current_hash ~= stored_hash then
	  -- Hash has changed, sync plugins and update the hash file
	  print("Plugin definitions have changed, running packer.sync()...")
	  require('packer').sync()
	  store_hash(hash_file, current_hash)
	else
	  print("No changes in plugin definitions.")
	end
  end
  


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

	-- Golang tooling https://github.com/ray-x/go.nvim	
	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua' -- recommended if need floating window support
	use 'neovim/nvim-lspconfig'
	-- already have this
	-- use 'nvim-treesitter/nvim-treesitter'
	use  'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'nvim-neotest/nvim-nio'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

  	sync_if_needed(current_file)

end)
