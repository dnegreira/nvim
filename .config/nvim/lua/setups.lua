require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.indentscope').setup()
require('mini.pairs').setup()
require('mini.fuzzy').setup()
require('mini.trailspace').setup()
require('nvim-tree').setup()
require('nvim-surround').setup()


require 'nvim-treesitter.configs'.setup {
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
	signs                        = {
		add          = { text = '+' },
		change       = { text = '~', },
		delete       = { text = '-', },
		topdelete    = { text = '-', },
		changedelete = { text = '-', },
	},
	signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff                    = true, -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame           = true,
	current_line_blame_formatter = '<author>, <author_time:%R> - <summary> - <abbrev_sha>',
})
-- LSP confs
require("mason").setup()
require("mason-lspconfig").setup()
require("nvim-lastplace").setup()
require("go").setup()
require("mason-null-ls").setup()
require("lsp_signature").setup({
	bind = true,
	handler_opts = {
		border = "shadow"
	},
	floating_window_above_cur_line = false,
	hint_prefix = "",
})
