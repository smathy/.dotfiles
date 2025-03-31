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
bo.cindent = true
opt.mousefocus = true
opt.laststatus = 3
opt.titlestring = '%(  %{substitute(expand("%:~"), "/work/", "", "")}%)'

opt.tabstop = 2
opt.shiftwidth = 0
opt.expandtab = true
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

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_opacity = 0.9
vim.g.neovide_transparency = vim.g.neovide_opacity
vim.g.neovide_window_blurred = true

opt.winblend = 70
opt.pumblend = 20

opt.termguicolors = true

opt.guifont = "JetBrainsMono Nerd Font:h12"
opt.guicursor= { "a:Cursor-blinkwait300-blinkoff300-blinkon450", "i:ver25" }

opt.selectmode:append "mouse"
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
    },
  },

  {
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { "<leader>s", group = "search" },
      }
    },
  },

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
        lualine_b = {},
        lualine_c = {{
          'buffers',
          mode = 4,
          symbols = { modified = ' ' },
        }},
        lualine_x = {'diff', 'diagnostics'},
        lualine_y = {'progress'},
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
      {
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        version = "^1.0.0",
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippet_overrides" }})
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.keymap.set({"i", "s"}, "<TAB>", function() return require("luasnip").expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<TAB>" end, {expr=true})
    end,
  },

  {
    'benfowler/telescope-luasnip.nvim',
    module = "telescope._extensions.luasnip",
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  "RRethy/nvim-treesitter-endwise",
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
    opts = {},
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = {
        enabled = true,
        win = {
          -- input window
          input = {
            keys = {
              ["<space><space>"] = { "edit_vsplit", mode = { "n", "i" } },
            },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>*", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>r", function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      -- search
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },

  {
    "folke/noice.nvim",
    config = function()
      require('noice').setup({
        notify = {
          enabled = false,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
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

  {
    "Funk66/jira.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("jira").setup()
    end,
    cond = function()
      return vim.env.JIRA_API_TOKEN ~= nil
    end,
    keys = {
      { "<leader>jv", ":JiraView<cr>", desc = "View Jira issue", silent = true },
      { "<leader>jo", ":JiraOpen<cr>", desc = "Open Jira issue in browser", silent = true },
    },
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

km.set('n', '<M-Right>', ':bn<CR>')
km.set('n', '<M-Left>', ':bp<CR>')
km.set('n', '<M-BS>', ':bd!<CR>')
km.set('n', '<M-Del>', ':bd!<CR>')
km.set('n', '<Del>', ':bd!<CR>')

km.set('', '<C-]>', 'g<C-]>')
km.set('', 'g<C-]>', '<C-]>')
km.set('', '<C-W><C-]>', '<C-W>g<C-]>')
km.set('', '<C-W>g<C-]>', '<C-W><C-]>')

km.set('', '<D-=>', '<C-W>=')

km.set('', '<C-W><C-^>', '<C-W><C-V><C-^>')
km.set('', '<C-W>^', '<C-W><C-V>^')

km.set('n', '^', ':<C-U>vs #<C-R>=v:count<CR><CR>')

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
vim.api.nvim_create_autocmd({'BufEnter'}, { callback = function() vim.diagnostic.disable() end })
vim.api.nvim_create_autocmd({'BufNewFile'}, {
  pattern = "*.rb",
  command = "0r "..vim.fn.stdpath'config'.."/skel.rb",
})

-- Diagnostic keymaps
km.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
km.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
km.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
km.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Todo keymaps
local tc = require 'todo-comments'
km.set("n", "]t", function() tc.jump_next() end, { desc = "Next todo comment" })
km.set("n", "[t", function() tc.jump_prev() end, { desc = "Previous todo comment" })

-- }}}

-- {{{ telescope extensions (fzf, luasnip, etc)
local actions = require 'telescope.actions'

local telescope = require('telescope')
local lga_actions = require"telescope-live-grep-args.actions"

telescope.setup {
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
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-w>"] = lga_actions.quote_prompt({ postfix = " -w"}),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --glob !/spec* --glob !/tests" }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = actions.to_fuzzy_refine,
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
  },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'luasnip')
pcall(telescope.load_extension, 'live_grep_args')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
local lga = telescope.extensions.live_grep_args
local lga_shortcuts = require"telescope-live-grep-args.shortcuts"

local function word_grep_string()
  lga_shortcuts.grep_word_under_cursor{postfix = "", quote = false}
end

-- vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[b] Find existing buffers' })
-- vim.keymap.set('n', '<leader>g', builtin.git_files, { desc = 'Search [G]it files' })
-- vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = '[ ] Search files' })
-- vim.keymap.set('n', '<leader>/', lga.live_grep_args, { desc = '[/] Search by rg' })
-- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>*', word_grep_string, { desc = '[*] Search current word' })
-- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- }}}

-- {{{ treesitter (syntax highlighting)
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "ruby", "bash", "sql", "lua", "html", "css", "scss", "diff", "elixir", "eex", "heex", "csv", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "javascript", "jq", "json", "markdown", "markdown_inline", "nginx", "nix", "passwd", "perl", "readline", "regex", "ssh_config", "surface", "terraform", "tmux", "toml", "typescript", "vim", "vimdoc", "xml", "yaml", },

    auto_install = false,

    highlight = { enable = true },
    indent = { enable = false },
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
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']M'] = '@function.outer',
          [']C'] = '@class.outer',
          [']B'] = '@block.outer',
        },
        goto_next_end = {
          [']m'] = '@function.outer',
          [']c'] = '@class.outer',
          [']b'] = '@block.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[b'] = '@block.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[C'] = '@class.outer',
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

  -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

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
      diagnostics = { globals = { "vim", "Snacks" }, disable = { 'missing-fields' } },
    },
  },

  gopls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

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
      excluded_patterns = { "CHEETO-*/**/*", "APPS-*/**/*", "MDF-*/**/*", "NUM-*/**/*", "RACH-*/**/*", "RELEASE-*/**/*" },
    },
  },
}

-- vim.lsp.set_log_level("debug")
-- }}}

-- {{{ completion

-- }}}

vim.api.nvim_set_hl(0, "TreesitterContextBottom", {})
vim.api.nvim_set_hl(0, "Cursor", { bg="orange" })
-- vim: ts=2 sts=2 sw=2 et
