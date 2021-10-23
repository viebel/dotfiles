-- Window management and navigation

vim.o.winminwidth = 0
vim.o.winminheight = 0

function num_windows()
  return vim.api.nvim_exec("echo winnr('$')"
    ,
    true)
end

function close_window(n)
  if (tonumber(n) > 0) then
    vim.cmd(n .. "wincmd c")
  end
end

function close_window_if_small(n)
  local width = tonumber(vim.api.nvim_exec('echo winwidth(' .. n .. ')', true))
  local height = tonumber(vim.api.nvim_exec('echo winheight(' .. n .. ')', true))
  if ((width <  1) or (height < 1)) then
    close_window(n)
  end
end

function close_small_windows()
  for j = num_windows(), 1, -1 do
    close_window_if_small(j)
  end
end

function winkey_cmd(k)
  local basic_cmd = ':wincmd ' .. k 
  if k == '|' or k == '_' then
    return basic_cmd .. ' | lua close_small_windows()<CR>'
  else
    return basic_cmd .. '<CR>'
  end
end

function set_window_management_keymaps()  
  local winkeys = {'j', 'k', 'h', 'l', '=', 'w', 'o', 'x', '+', '-', '>', '<', 'J', 'K', 'H', 'L', '|', '_'}
  for _, winkey in ipairs(winkeys) do
    vim.api.nvim_set_keymap(
      'n',
      '<leader>w' .. winkey, 
      winkey_cmd(winkey),
      { noremap = true, silent = true })
  end
  vim.api.nvim_set_keymap('n', '<leader>wv', ':vsplit<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ws', ':split<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>wd', ':hide<CR>', { noremap = true, silent = true })
end

set_window_management_keymaps()


