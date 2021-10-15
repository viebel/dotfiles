-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'folke/trouble.nvim'
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'matcatc/vim-asciidoc-folding'
  use 'junegunn/vim-peekaboo'
  use 'tpope/vim-surround'
  use 'tommcdo/vim-exchange'
  use 'Pocco81/AutoSave.nvim'
  use { 'Olical/conjure', ft = 'clojure' } 
  use 'p00f/nvim-ts-rainbow'
  use 'sheerun/vim-polyglot'

end)

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.linebreak = true
vim.o.relativenumber = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme onedark]]

--Folding
vim.o.foldmethod = "expr"

--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

local keyopts = { noremap = true, silent = true, exp = true } 
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><tab>', '<C-^>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'fd', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'fd', '<Esc>', { noremap = true, silent = true })

-- Window management and navigation
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-W>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ww', '<C-W><C-W>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>wJ', '<C-W>J', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wK', '<C-W>K', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wH', '<C-W>H', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wL', '<C-W>L', { noremap = true, silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '>-2<CR>gv=gv", { noremap = true, silent = true })

-- Quickly open/reload vim
vim.api.nvim_set_keymap('n', '<leader>ev', ':e $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { noremap = true, silent = true })

-- yank buffer name
-- relative path (src/foo.txt)
vim.api.nvim_set_keymap('n', '<leader>yf', ':let @"=expand("%")<CR>', { noremap = true, silent = true })
-- absolute path (/something/src/foo.txt)
vim.api.nvim_set_keymap('n', '<leader>yF', ':let @"=expand("%:p")<CR>', { noremap = true, silent = true })
-- filename (foo.txt)
vim.api.nvim_set_keymap('n', '<leader>yb', ':let @"=expand("%:t")<CR>', { noremap = true, silent = true })
-- directory name (/something/src)
vim.api.nvim_set_keymap('n', '<leader>yd', ':let @"=expand("%:p:h")<CR>', { noremap = true, silent = true })

-- autosave
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = true,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
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

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>rl', [[<cmd>lua require('telescope.builtin').resume()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bB', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bB', [[<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'q:', [[<cmd>lua require('telescope.builtin').command_history()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s/', [[<cmd>lua require('telescope.builtin').search_history()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g/', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mm', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
	ensure_installed = "maintained",
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  rainbow = {
	  enable = true,
	  extended_mode = false,
	  max_file_lines = 4000
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = false, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gg', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>hh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gf', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gs', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ga', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<localleader>ga', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>eL', '<cmd>Trouble lsp_workspace_diagnostics<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>el', '<cmd>Trouble lsp_document_diagnostics<CR>', opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'clojure_lsp', 'rust_analyzer', 'pyright', 'tsserver' }
if not vim.lsp_loaded then
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end
	vim.lsp_loaded = true
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


