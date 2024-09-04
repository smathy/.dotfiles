" let &rtp.=',/opt/homebrew/Cellar/neovim-qt/0.2.17/nvim-qt.app/Contents/Resources/runtime'

" Enable Mouse
set mouse=a
set lines=84
set columns=272

" Set Editor Font
if exists(':GuiFont')
  " Use GuiFont! to ignore font errors
  GuiFont JetBrainsMono Nerd Font:h12
endif

" Disable GUI Tabline
if exists(':GuiTabline')
  GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
  GuiScrollBar 1
endif

if exists(':GuiClipboard')
  GuiClipboard
endif

hi Cursor gui=NONE guibg=orange guifg=NONE
set guicursor=a:Cursor-blinkwait500-blinkoff500-blinkon500,i:ver25

set selectmode+=mouse
