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
  use {'viebel/halonot', 
    config = function() 
      require('halonot').setup({main_key = 'w'})
    end
  }
  use 'wbthomason/packer.nvim' -- Package manager
  use {'Olical/aniseed',  tag = "v3.23.0" }
  use 'tami5/sqlite.lua'
  use 'tami5/lispdocs.nvim'
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-abolish'
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
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
      signs = {
        add = { hl = 'GitGutterAdd', text = '+' },
        change = { hl = 'GitGutterChange', text = '~' },
        delete = { hl = 'GitGutterDelete', text = '_' },
        topdelete = { hl = 'GitGutterDelete', text = '‾' },
        changedelete = { hl = 'GitGutterChange', text = '~' },
      },
      
      current_line_blame = true,
      current_line_blame_formatter_opts = {
          relative_time = true
      }
    }
    end
  }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'ryanoasis/vim-devicons'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'guns/vim-sexp'
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
  use { 'neoclide/coc.nvim', branch= 'release' }
  use {'junegunn/fzf',  run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'pelodelfuego/vim-swoop'
  use 'antoinemadec/coc-fzf'
  -- use 'kristijanhusak/orgmode.nvim'
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { "AckslD/nvim-neoclip.lua",
    requires = {'tami5/sqlite.lua', module = 'sqlite'},
    config = function()
      require('neoclip').setup({
        enable_persistant_history = false,
        default_register = {'"', '+', '*'},
      })
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {
    view = {
        side = 'left'
      }
    } end
  }
end)
vim.g.gitsigns_status = function ()
  return vim.b.gitsigns_status
end

vim.g.folder_name = function()
  return vim.api.nvim_eval('expand("%:h")')
end

--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = {
    right = { {'lineinfo', 'percent'}, {'foldername'}},
    left = { { 'mode', 'paste' }, { 'gitbranch', 'gitstatus', 'readonly', 'filename', 'modified' } } },
  component_function = {
    gitstatus = 'gitsigns_status',
    foldername = 'folder_name',
    gitbranch = 'fugitive#head' },
}

local keyopts = { noremap = true, silent = true, exp = true } 
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
-- NvimTree
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- COC settings for stuff not working with native LSP
vim.api.nvim_command [[nmap <localleader>gn <Plug>(coc-rename)]]

-- Autosave
require("autosave").setup(
  {
    enabled = true,
    execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    events = {"InsertLeave", "TextChanged"},
    conditions = {
      exists = false,
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
-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = actions.delete_buffer,
      },
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
  },
}

-- Buffer management
vim.api.nvim_set_keymap('n', '<leader>bd', ':bp|bd#<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bB', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bB', [[<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<CR>]], { noremap = true, silent = true })

-- Clipboard
vim.api.nvim_set_keymap('n', '<leader>cc', [[<cmd>lua require('telescope').extensions.neoclip.default()<CR>]], { noremap = true, silent = true })

-- Telescope stuff
vim.api.nvim_set_keymap('n', '<leader>rl', [[<cmd>lua require('telescope.builtin').resume()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'q:', [[<cmd>lua require('telescope.builtin').command_history()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s/', [[<cmd>lua require('telescope.builtin').search_history()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g/', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mm', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { noremap = true, silent = true })

-- Git
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gz', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]], { noremap = true, silent = true })

-- Conjure
vim.api.nvim_set_keymap('n', '<localleader>eR', [[<cmd>ConjureEval (do (in-ns 'dev) (reset))<CR>]], { noremap = true, silent = true })


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
  print("LSP initialized")
  vim.lsp.codelens.refresh()
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = false, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gg', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>hh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gf', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gs', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ga', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<localleader>ga', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>g=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_command [[autocmd BufEnter,InsertLeave,TextChanged <buffer> lua vim.lsp.codelens.refresh()]]


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
local servers = { 'clojure_lsp' }
if not vim.lsp_loaded then
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end
	vim.lsp_loaded = true
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- Firenvim
if vim.g.started_by_firenvim then
  vim.o.guifont = "SauceCodePro:h24"
  vim.o.laststatus = 0
end


