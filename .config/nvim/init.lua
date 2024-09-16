-- {{{ settings
local bo = vim.bo
local wo = vim.wo
local go = vim.go
local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.g.ruby_host_prog = '~/.asdf/shims/neovim-ruby-host'

opt.scrolloff = 999
opt.cursorline = true
opt.smartcase = true
opt.ignorecase = true
opt.showmode = false
bo.swapfile = true
opt.backup = false
opt.writebackup = false
opt.backupskip:append { '/tmp/*', '/private/tmp/*' }
opt.backupdir = '$TEMP,.'
opt.undofile = true
opt.incsearch = true
opt.hlsearch=true
opt.hidden = true
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
bo.autoindent = true
-- bo.cindent = true
opt.mousefocus = true
opt.laststatus = 3
opt.titlestring = '%(  %{substitute(expand("%:~"), "/work/", "", "")}%)'


opt.tabstop = 2
opt.shiftwidth = 0
-- opt.expandtab = true
opt.smarttab = true

wo.wrap = true
opt.whichwrap = '<,>,[,],b,s'
opt.breakindent=true
-- o.breakindentopt = 'shift:2 sbr'
opt.linebreak = true
opt.showbreak = '> '
opt.breakat = ' ^I}.('

opt.splitbelow = true
opt.splitright = true

opt.fileencodings = { 'ucs-bom', 'utf-8', 'latin1', 'default' }

opt.foldmethod = 'marker'

opt.backspace = { 'indent', 'eol', 'start' }

opt.wildmenu = true
opt.wildmode= 'list:longest,list:full'
opt.wildignore:append { '*/tmp/*', '*.so', '*.swp', '*.zip' }

opt.tags = { '~/.tags', '.tags', '../.tags', '../../.tags', '../../../.tags' }

opt.helpheight = 10
opt.cmdheight=2
opt.showcmd=true

opt.formatoptions='crq'
go.title = true

-- Keep signcolumn on by default
wo.signcolumn = 'auto'

-- Decrease update time
opt.timeoutlen = 300
opt.shortmess:append "S"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
-- }}}

-- {{{ lazy
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-abolish',
  'yosssi/vim-ace',
  'equalsraf/neovim-gui-shim',

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    -- See `:help lualine`
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {'branch'},
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {{
          'buffers',
          mode = 4,
        }},
      },
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'onsails/lspkind.nvim',
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  'nvim-treesitter/nvim-treesitter-context',

  'iamcco/markdown-preview.nvim',

  'tpope/vim-rails',
  'slim-template/vim-slim',

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },

  {
    'levouh/tint.nvim',
    config = function()
      require("tint").setup({
        transforms = {
          require("tint.transforms").tint_with_threshold(-100, "#1C1C1C", 150),
          require("tint.transforms").saturate(0.5),
        }
      })
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        render = 'compact',
      })
    end,
  },

  {
    "folke/noice.nvim",
    config = function()
      require('noice').setup({})
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  "sindrets/diffview.nvim",
  {
    "RaafatTurki/hex.nvim",
    config = function()
      require 'hex'.setup()
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
}, {})
-- }}}

-- {{{ theme and statusline
require('tint').setup()
-- }}}

-- {{{ keymaps and commands
local km = vim.keymap
km.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

km.set('n', '<S-Tab>', '<C-O>')
km.set('n', 'ZZ', ':xa<CR>')
km.set('', '<F1>', '<nop>')
km.set('!', '<F1>', '<nop>')

km.set('n', '<M-Up>', ':bn<CR>')
km.set('n', '<M-Down>', ':bp<CR>')
km.set('n', '<M-BS>', ':bd!<CR>')
km.set('n', '<M-Del>', ':bd!<CR>')
km.set('n', '<Del>', ':bd!<CR>')

km.set('', '<C-]>', 'g<C-]>')
km.set('', 'g<C-]>', '<C-]>')
km.set('', '<C-W><C-]>', '<C-W>g<C-]>')
km.set('', '<C-W>g<C-]>', '<C-W><C-]>')

km.set('', '<C-W><C-^>', '<C-W><C-V><C-^>')
km.set('', '<C-W>^', '<C-W><C-V>^')

km.set('', '<C-W><C-V>f', ':vert winc f<CR>')
km.set('', '<C-W>vf', ':vert winc f<CR>')
km.set('', ']]', '][')
km.set('', '][', ']]')

km.set('n', 'j', 'Jx')
km.set('n', '\\', ':s<Up><CR>')
km.set('n', 'Y', 'y$')

km.set('', '<D-Right>', '<C-PageDown>')
km.set('', '<D-Left>', '<C-PageUp>')

km.set('n', '<F5>', ':tabe '..vim.fn.stdpath'config'..'/init.lua<CR>')

km.set('n', '<D-w>', '<C-W>c')
km.set('n', '<C-TAB>', '<C-W>w')
km.set('n', '<C-S-TAB>', '<C-W>W')

km.set('v', '<D-c>', '"+y')
km.set('v', '<D-x>', '"+d')
km.set('', '<D-v>', '"+P')
km.set('!', '<D-v>', '<C-R>+')

km.set('n', '<S-PageUp>', '<C-U>')
km.set('n', '<S-PageDown>', '<C-D>')

km.set('n', '<M-D-Right>', 'w')
km.set('n', '<M-D-Left>', 'W')
km.set('n', '<M-D-Up>', '<Up>')
km.set('n', '<M-D-Down>', '<Down>')

km.set('n', '', 'p')

vim.api.nvim_create_user_command('ZZ', 'xa', {})
vim.api.nvim_create_user_command('W', 'Gw', {})
vim.api.nvim_create_user_command('H', 'vert help', {})
vim.api.nvim_create_user_command('FF', "let @* = expand('%:.')", {})
vim.api.nvim_create_user_command('LL', "let @* = printf('%s:%d', expand('%:.'), line('.'))", {})
vim.api.nvim_create_user_command('Gblame', 'Git blame', {})

local function write_with_path()
  os.execute('mkdir -p '..vim.fn.expand'%:h')
  vim.cmd'write'
end

vim.api.nvim_create_user_command('WW', write_with_path, {})
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI'}, {
  command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = 'help',
  command = 'wincmd L',
})

-- Diagnostic keymaps
km.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
km.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
km.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
km.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- }}}

-- {{{ telescope (fuzzy finder)
local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    vimgrep_arguments = { "rg", "--color=never", "--vimgrep" },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-w>'] = "select_horizontal",
        ['<C-e>'] = "select_default",
        ['<CR>'] = "select_vertical",

        ["<S-Up>"] = actions.cycle_history_prev,
        ["<S-Down>"] = actions.cycle_history_next,

      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'

local function word_grep_string()
  builtin.grep_string{word_match = "-w"}
end
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[b] Find existing buffers' })
vim.keymap.set('n', '<leader>g', builtin.git_files, { desc = 'Search [G]it files' })
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = '[ ] Search files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[/] Search by rg' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>*', word_grep_string, { desc = '[*] Search current word' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- }}}

-- {{{ treesitter (syntax highlighting)
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "ruby", "bash", "sql", "lua", "html", "css", "scss", "diff", "elixir", "eex", "heex", "csv", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "javascript", "jq", "json", "markdown", "markdown_inline", "nginx", "nix", "passwd", "perl", "readline", "regex", "ssh_config", "surface", "terraform", "tmux", "toml", "typescript", "vim", "vimdoc", "xml", "yaml", },

    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
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
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)
-- }}}

-- {{{ LSP
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local lspconfig = require'lspconfig'
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { disable = { 'missing-fields' } },
    },
  },

  gopls = {},
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      init_options = (servers[server_name] or {}).init_options,
    }
  end
}

local configs = require("lspconfig.configs")

local lexical_config = {
  filetypes = { "html", "elixir", "eelixir", "heex" },
  cmd = { os.getenv('HOME') .. "/bin/lexical/bin/start_lexical.sh" },
  settings = { dialyzerEnabled = false },
}

if not configs.lexical then
  configs.lexical = {
    default_config = {
      filetypes = lexical_config.filetypes,
      cmd = lexical_config.cmd,
      root_dir = function(fname)
        return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
      end,
      -- optional settings
      settings = lexical_config.settings,
      on_attach = on_attach,
    },
  }
end

lspconfig.lexical.setup({})

lspconfig.ruby_lsp.setup {
  on_attach = on_attach,
  init_options = {
    indexing = {
      excluded_patterns = { "**/spec/**/*.rb", "CHEETO-*/**/*", "APPS-*/**/*", "MDF-*/**/*", "NUM-*/**/*", "RACH-*/**/*", "RELEASE-*/**/*" },
    },
  },
}

-- vim.lsp.set_log_level("debug")
-- }}}

-- {{{ completion
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local lspkind = require('lspkind')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
  window = {
    completion = {
      col_offset = -3 -- align the abbr and word on cursor (due to fields order below)
    }
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      menu = ({ -- showing type in menu
        nvim_lsp = "[LSP]",
        path = "[Path]",
        buffer = "[Buffer]",
      }),
      before = function(entry, vim_item) -- for tailwind css autocomplete
        if vim_item.kind == 'Color' and entry.completion_item.documentation then
          local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
          if r then
            local color = string.format('%02x', r) .. string.format('%02x', g) ..string.format('%02x', b)
            local group = 'Tw_' .. color
            if vim.fn.hlID(group) < 1 then
              vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
            end
            vim_item.kind = "■" -- or "⬤" or anything
            vim_item.kind_hl_group = group
            return vim_item
          end
        end
        -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
        -- or just show the icon
        vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
        return vim_item
      end
    })
  },
}
-- }}}

vim.cmd "hi clear TreesitterContextBottom"
-- vim: ts=2 sts=2 sw=2 et
