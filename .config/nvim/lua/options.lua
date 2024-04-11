local o = vim.o
local bo = vim.bo
local wo = vim.wo
local go = vim.go
local opt = vim.opt

opt.smartcase = true
opt.ignorecase = true
opt.showmode = false
bo.swapfile = true
opt.directory = '.'
opt.backup = false
opt.writebackup = false
opt.backupskip:append { '/tmp/*', '/private/tmp/*' }
opt.backupdir = '$TEMP,.'
go.undodir = vim.fn.stdpath('config') .. '/undo'
opt.undofile = true
opt.incsearch = true
opt.hlsearch=true
opt.hidden = true
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
bo.autoindent = true
-- bo.cindent = true
opt.mousefocus = true

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
