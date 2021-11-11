vim.api.nvim_set_keymap('n', '<leader>en', ':lua require("my_telescope").edit_neovim()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gn', ':lua require("my_telescope").grep_neovim_files()<CR>', { noremap = true, silent = true })
 
