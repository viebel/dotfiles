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
  use 'ray-x/lsp_signature.nvim'
  use 'kamykn/spelunker.vim'
  use 'kamykn/popup-menu.nvim'
  use 'mbbill/undotree'
  use 'VincentCordobes/vim-translate'
  use 'wbthomason/packer.nvim' -- Package manager
  use {'Olical/aniseed',  tag = "v3.23.0" }
  use 'tami5/sqlite.lua'
  use 'tami5/lispdocs.nvim'
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-abolish'
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use {'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end
  }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-github.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'folke/trouble.nvim'
  use 'mzlogin/vim-markdown-toc'
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
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
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'SirVer/ultisnips'
  use 'guns/vim-sexp'
  use 'matcatc/vim-asciidoc-folding'
  use 'junegunn/vim-peekaboo'
  use 'tpope/vim-surround'
  use 'tommcdo/vim-exchange'
  use 'Pocco81/AutoSave.nvim'
  use { 'Olical/conjure', ft = 'clojure' } 
  use 'p00f/nvim-ts-rainbow'
  use 'sheerun/vim-polyglot'
  use { 'neoclide/coc.nvim', branch= 'release' }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
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
    gitbranch = 'FugitiveHead' },
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
local trouble = require("trouble.providers.telescope")

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden"
    },
    path_display = {'smart'},
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = actions.delete_buffer,
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
    }
  },
  pickers = {
    buffers = {
      ignore_current_buffer = false,
      sort_lastused = true,
    },
  },
}

require('telescope').load_extension('gh')
require('telescope').load_extension('fzf')

-- Buffer management
vim.api.nvim_set_keymap('n', '<leader>bd', ':bp|bd#<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bB', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files( { cwd = require('telescope.utils').buffer_dir() })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fe', [[<cmd>lua require('telescope.builtin').file_browser( { cwd = require('telescope.utils').buffer_dir(), hidden = true })<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fE', [[<cmd>lua require('telescope.builtin').file_browser( { hidden = true })<CR>]], { noremap = true, silent = true })

-- Clipboard
vim.api.nvim_set_keymap('n', '<leader>cc', [[<cmd>lua require('telescope').extensions.neoclip.default()<CR>]], { noremap = true, silent = true })

-- Telescope stuff

vim.api.nvim_set_keymap('n', '<leader>rl', [[<cmd>lua require('telescope.builtin').resume()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s/', [[<cmd>lua require('telescope.builtin').search_history()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p/', [[<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.input("> "),})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g/', [[<cmd>lua require('telescope.builtin').live_grep({})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f/', [[<cmd>lua require('telescope.builtin').live_grep({cwd=require('telescope.utils').buffer_dir()})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mm', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { noremap = true, silent = true })

-- Git
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gz', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]], { noremap = true, silent = true })

-- Conjure
vim.api.nvim_set_keymap('n', '<localleader>eR', [[<cmd>ConjureEval (do (require 'dev) (in-ns 'dev) (reset))<CR>]], { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<localleader>eU', [[<cmd>ConjureEval (do (clojure.core/println "Removing aliases and mappings of" (clojure.core/ns-name clojure.core/*ns*)) (clojure.core/doseq [[s] (clojure.core/ns-refers (clojure.core/ns-name clojure.core/*ns*))] (clojure.core/ns-unmap (clojure.core/ns-name clojure.core/*ns*) s)) (clojure.core/doseq [[s] (clojure.core/ns-aliases (clojure.core/ns-name clojure.core/*ns*))] (clojure.core/ns-unalias (clojure.core/ns-name clojure.core/*ns*) s)))<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
	ensure_installed = "all",
  ignore_install = { "phpdoc", "markdown" },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader>v',
      node_incremental = 'v',
      scope_incremental = 'grc',
      node_decremental = 'V',
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
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gf', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>gs', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
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

-- Firenvim
if vim.g.started_by_firenvim then
  vim.o.guifont = "SauceCodePro:h24"
  vim.o.laststatus = 0
end

-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>gr", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xn", "<cmd>Trouble<cr><cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xp", "<cmd>Trouble<cr><cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", {silent = true, noremap = true})


-- LSP Signature
require "lsp_signature".setup()

-- Spelunker
vim.g.enable_spelunker_vim = 0
