local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
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
  use { 'kyazdani42/nvim-tree.lua',
      requires = {'kyazdani42/nvim-web-devicons'}
  }


  -- use { 'ibhagwan/fzf-lua',
  --   -- optional for icon support
  --   requires = { 'kyazdani42/nvim-web-devicons' }
  -- }
  -- use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  -- use {
  --       "hrsh7th/nvim-cmp",
  --       requires = {
  --           "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
  --           'hrsh7th/cmp-nvim-lua', 'octaltree/cmp-look',
  --           'hrsh7th/cmp-path',
  --           'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
  --       }
  --   }

  -- -- LSP config
  -- require'lspconfig'.jedi_language_server.setup{}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  require('mini.statusline').setup()
  require('mini.indentscope').setup()
  require('mini.pairs').setup()
  require('mini.fuzzy').setup()
  require('mini.trailspace').setup()
  require('mini.completion').setup()
  require('mini.tabline').setup()
  require('nvim-tree').setup()
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
	 ensure_installed = {"jedi_language_server"}
 })
 require'lspconfig'.jedi_language_server.setup{}
  if packer_bootstrap then
    require('packer').sync()
  end
end)
