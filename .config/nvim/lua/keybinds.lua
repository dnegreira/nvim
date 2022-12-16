local default_opts = {
  noremap = true,
  silent = true,
  expr = false,
  nowait = false,
  script = false,
  unique = false,
}


local keymap = function(mode, keys, cmd)
  vim.api.nvim_set_keymap(mode, keys, cmd, default_opts)
end
keymap('n', '[b', [[<Cmd>bprevious<CR>]], nil)
keymap('n', ']b', [[<Cmd>bnext<CR>]], nil)
keymap('n', '[c', [[<Cmd>bdelete<CR>]], nil)

keymap('n', '<C-n>', '[[<Cmd>NvimTreeToggle<CR>]]', nil)
