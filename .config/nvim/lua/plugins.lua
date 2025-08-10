-- Bootstaped from https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/plugins.lua
local fn = vim.fn

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Install your plugins here
return require('packer').startup(function(use)
	-- make sure to add this line to let packer manage itself
	use 'wbthomason/packer.nvim'
	use 'echasnovski/mini.nvim'
	-- for mini.statusline
	-- use { 'lewis6991/gitsigns.nvim', tag = 'v0.9.0' }
	use { 'lewis6991/gitsigns.nvim'}
	use 'kyazdani42/nvim-web-devicons'
	use {
		-- 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-treesitter/nvim-treesitter', tag = 'v0.9.1' } }
		'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-treesitter/nvim-treesitter' } }
	}
	use({
		"neovim/nvim-lspconfig",
		requires = { { "williamboman/mason.nvim" }, { "williamboman/mason-lspconfig.nvim" } },
	})
	--Theme
	use 'joshdick/onedark.vim'
	use 'bluz71/vim-moonfly-colors'
	use "EdenEast/nightfox.nvim"
	use { 'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' }
	}
	use 'nvimtools/none-ls.nvim'
	use 'wellle/context.vim'
	use 'ethanholz/nvim-lastplace'
	use { 'ray-x/go.nvim', tag = 'v0.9.0' }
	use 'ray-x/guihua.lua'
	use 'jay-babu/mason-null-ls.nvim'
	use 'kylechui/nvim-surround'

	use("onsails/lspkind.nvim") -- fancy cmp menu
	use("ray-x/lsp_signature.nvim") -- get func signature help

	-- autocompletion
	use("hrsh7th/nvim-cmp")                -- completion plugin
	use("hrsh7th/cmp-buffer")              -- source for text in buffer
	use("hrsh7th/cmp-path")                -- source for file system paths
	use("hrsh7th/cmp-nvim-lsp")            -- source for nvim_lsp
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- source for nvim_lsp

	-- snippets
	use("L3MON4D3/LuaSnip")         -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
