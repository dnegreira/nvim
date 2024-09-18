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
    use {'lewis6991/gitsigns.nvim', tag = 'v0.9.0'}
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
    use 'wellle/context.vim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'ethanholz/nvim-lastplace'
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
    use 'jay-babu/mason-null-ls.nvim'
    use 'kylechui/nvim-surround'

    require('mini.statusline').setup()
    require('mini.indentscope').setup()
    require('mini.pairs').setup()
    require('mini.fuzzy').setup()
    require('mini.trailspace').setup()
    require('mini.completion').setup()
    require('mini.tabline').setup()
    require('nvim-tree').setup()
    require('nvim-surround').setup()


    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "lua", "go" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = { "javascript" },

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }

    require('gitsigns').setup({
      signs = {
          add          = {text = '+'},
          change       = {text = '~',},
          delete       = {text = '-',},
          topdelete    = {text = '-',},
          changedelete = {text = '-',},
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame = true,
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary> - <abbrev_sha>',
    })
    -- LSP confs
   require("mason").setup()
   require("mason-lspconfig").setup({
   })
   require("null-ls").setup({
	sources = {
		-- require("null-ls").builtins.diagnostics.golangci_lint, -- This is done by mason/lspconfig/gopls
		require("null-ls").builtins.formatting.goimports_reviser,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.diagnostics.flake8,
	},
  })
  require("nvim-lastplace").setup()
  require("go").setup()
  require("mason-null-ls").setup()

   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
