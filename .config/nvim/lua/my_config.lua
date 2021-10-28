
-- Allow h and l to cross lines
vim.o.whichwrap = vim.o.whichwrap .. ',l,h'

-- wrap
vim.o.wrap = true

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--always keep a few lines of context around the cursor 
vim.o.scrolloff = 5

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

-- Tabs
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.relativenumber = true

-- Allow moving the character after the last character of the line
vim.o.ve = 'onemore,block'

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme onedark]]

--Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g')]]
vim.o.fillchars = "fold: "
vim.o.foldminlines = 1


-- Search
vim.api.nvim_set_keymap('n', '<leader>sc', ':noh<CR>', { noremap = true, silent = true })

-- Formatting
vim.api.nvim_set_keymap('n', '<leader>=', "m':% normal ==<CR>`'", { noremap = true, silent = true })

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tw', ':set wrap!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><tab>', '<C-^>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ff', ':close<CR>', { noremap = true, silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Break a line with <C-J>
vim.api.nvim_set_keymap('n', '<NL>', 'i<CR><ESC>', { noremap = true, silent = true })

-- Insert a single character with <C-I>
vim.api.nvim_set_keymap('n', '<C-I>', 'i <ESC>r', { noremap = true, silent = true })

-- Recenter screen
vim.api.nvim_set_keymap('i', '<C-L>', '<Esc>`^zzi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', 'zz', { noremap = true, silent = true })


-- Quickly open/reload config files
function open_plugin_file(filename) 
  local fullname = vim.api.nvim_eval('fnamemodify($MYVIMRC, ":h")') ..  "/lua/" .. filename
  vim.cmd(":e " .. fullname)
end

vim.api.nvim_set_keymap(
  'n',
  '<leader>ev',
  ':lua open_plugin_file(' .. '"my_config.lua"' .. ')<CR>', 
  { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  'n',
  '<leader>ep',
  ':lua open_plugin_file(' .. '"my_plugins.lua"' .. ')<CR>', 
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>sv', ':luafile %<CR>', { noremap = true, silent = true })

-- yank buffer name
-- relative path (src/foo.txt)
vim.api.nvim_set_keymap('n', '<leader>yf', ':let @"=expand("%")<CR>', { noremap = true, silent = true })
-- absolute path (/something/src/foo.txt)
vim.api.nvim_set_keymap('n', '<leader>yF', ':let @"=expand("%:p")<CR>', { noremap = true, silent = true })
-- filename (foo.txt)
vim.api.nvim_set_keymap('n', '<leader>yb', ':let @"=expand("%:t")<CR>', { noremap = true, silent = true })
-- directory name (/something/src)
vim.api.nvim_set_keymap('n', '<leader>yd', ':let @"=expand("%:p:h")<CR>', { noremap = true, silent = true })

-- Completion
vim.api.nvim_set_keymap('i', '<C-o>', '<C-x><C-o>', { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Commands related to the book
vim.api.nvim_command [[:iab ijoe *JOE*:]]
vim.api.nvim_command [[:iab iyou *YOU*:]]
vim.api.nvim_command [[:iab idave *DAVE*:]]
vim.api.nvim_command [[:iab inancy *NANCY*:]]

-- Keymap for executing lua code
vim.api.nvim_command(
  [[
  vnoremap <leader>ee "zy:lua <C-R>z<CR>
]])


-- My fun with sexps
-- -- duplicate a form
vim.cmd
[[
nmap <M-p> yafP`]l<C-j>
]]

-- Abbrevations to clear some clojure-lsp lint warnings
vim.cmd [[:iab cljpub #_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}]]