-- Bootstaped from https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/plugins.lua
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
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
	return
end

-- Install your plugins here
return packer.startup(function(use)
  -- make sure to add this line to let packer manage itself
    use 'wbthomason/packer.nvim'
    use 'echasnovski/mini.nvim'
    -- for mini.statusline
    use 'lewis6991/gitsigns.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'}, {'nvim-treesitter/nvim-treesitter'} }
    }
    use({
      "neovim/nvim-lspconfig",
      requires = { {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"} },
    })
    --Theme
    use 'joshdick/onedark.vim'
    use 'bluz71/vim-moonfly-colors'
    use "EdenEast/nightfox.nvim"
    use { 'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    require('mini.statusline').setup()
    require('mini.indentscope').setup()
    require('mini.pairs').setup()
    require('mini.fuzzy').setup()
    require('mini.trailspace').setup()
    require('mini.completion').setup()
    require('mini.tabline').setup()
    require('nvim-tree').setup()
    require('nvim-treesitter').setup()
    require('gitsigns').setup({
      signs = {
          add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '-', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame = true,
    })
    -- LSP confs
   require("mason").setup()
   require("mason-lspconfig").setup({
  	 ensure_installed = {"jedi_language_server", "sumneko_lua"}
   })
   require'lspconfig'.jedi_language_server.setup{}
   require'lspconfig'.sumneko_lua.setup{}
   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
