" My VIM Configurations | CodexLink (https://github.com/CodexLink)
"
" Compiled from the following sources:
" TODO This was outdated!!!

" https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
" https://www.twilio.com/blog/5-must-have-vim-plugins-that-will-change-your-workflow
" https://gist.github.com/jdah/4b4d98c2ced36eb07b017c4ae2c94bab
" https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim

call plug#begin('~/.vim/plugged')

Plug 'andweeb/presence.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'cespare/vim-toml'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'https://gitlab.com/code-stats/code-stats-vim.git'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Note [markdown-preview]: Used this method to avoid dependency on local machine.
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/fern.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'luochen1990/rainbow'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'stephpy/vim-yaml'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'

call plug#end()

set autoindent
set cursorline
set encoding=utf-8
set hlsearch
set incsearch
set number
set ruler
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smarttab
set tabstop=2
set termguicolors
set wildmenu

colorscheme dracula
syntax on

" Notes: Some of these lua modules depends on the set attributes of vim,
" therefore has to put it somewhere below it so that it will stop complaining.
lua require('Comment').setup()
lua require('colorizer').setup()

" Discord Presence Configuration (https://github.com/andweeb/presence.nvim)
let g:presence_auto_update         = 1
let g:presence_neovim_image_text   = "Neovim Editor"
let g:presence_main_image          = "file"
let g:presence_client_id           = "793271441293967371"
let g:presence_debounce_timeout    = 10
let g:presence_enable_line_number  = 1
let g:presence_blacklist           = []
let g:presence_buttons             = 1

let g:presence_editing_text        = "Editing %s"
let g:presence_file_explorer_text  = "Browsing %s"
let g:presence_git_commit_text     = "Committing changes"
let g:presence_plugin_manager_text = "Managing plugins"
let g:presence_reading_text        = "Reading %s"
let g:presence_workspace_text      = "Working on %s"
let g:presence_line_number_text    = "At Line %s out of %s"

" Rainbow on Parenthesis
let g:rainbow_active = 1

" For antoinemadec/FixCursorHold.nvim in regards to using Fern drawer.
let g:cursorhold_updatetime = 100

" Custom Functions
augroup highlight_yank
autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" CodeStats API key
let g:codestats_api_key = 'SFMyNTY.UTI5a1pYaE1hVzVyIyNNVEEwTXpnPQ.nnR-iNOq0hJ40bYk1CxCmm3O5g9_x7KEfFyO386s2lc'

" ! vim-airline customizations
" vim-airline to display status for CodeStats
let g:airline_section_x = airline#section#create_right(['filetype', '%{CodeStatsXp()}'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1

"! indent_blankline customizations
" !! Please note that this plugin prefers using lua, but since I already have
" !! a configured '.vim' startup, I will use vim commands and variables here.

let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_current_context_start = v:true
let g:indent_blankline_show_end_of_line = v:true

" Colors were based on Material Design Color Tool.
" The order of the colors were ascending from Deep Orange (Bottom) to Red (Top) using A200 color.
" I used outstanding strong color because preference.
highlight IndentBlanklineIndent1 guifg=#FF6E40 gui=nocombine
highlight IndentBlanklineIndent2 guifg=#FFAB40 gui=nocombine
highlight IndentBlanklineIndent3 guifg=#FFD740 gui=nocombine
highlight IndentBlanklineIndent4 guifg=#FFFF00 gui=nocombine
highlight IndentBlanklineIndent5 guifg=#EEFF41 gui=nocombine
highlight IndentBlanklineIndent6 guifg=#B2FF59 gui=nocombine
highlight IndentBlanklineIndent7 guifg=#C9F0AE gui=nocombine
highlight IndentBlanklineIndent8 guifg=#64FFDA gui=nocombine
highlight IndentBlanklineIndent9 guifg=#18FFFF gui=nocombine
highlight IndentBlanklineIndent10 guifg=#40C4FF gui=nocombine
highlight IndentBlanklineIndent11 guifg=#448AFF gui=nocombine
highlight IndentBlanklineIndent12 guifg=#536DFE gui=nocombine
highlight IndentBlanklineIndent13 guifg=#7C4DFF gui=nocombine
highlight IndentBlanklineIndent14 guifg=#E040FB gui=nocombine
highlight IndentBlanklineIndent15 guifg=#FF4081 gui=nocombine
highlight IndentBlanklineIndent16 guifg=#FF5252 gui=nocombine

let g:indent_blankline_char_highlight_list = ["IndentBlanklineIndent1", "IndentBlanklineIndent2", "IndentBlanklineIndent3", "IndentBlanklineIndent4", "IndentBlanklineIndent5", "IndentBlanklineIndent6", "IndentBlanklineIndent7", "IndentBlanklineIndent8", "IndentBlanklineIndent9", "IndentBLanklineIndent10", "IndentBlanklineIndent11", "IndentBlanklineIndent12", "IndentBlanklineIndent13", "IndentBlanklineIndent14", "IndentBlanklineIndent15", "IndentBlanklineIndent16"]

" Blinking Cursor from the 'help guicursor'
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Overrides: Comments on Code
hi Comment guifg=#957e49

" MarkdownPreview Config
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_page_title = 'mkdp prev. | ${name}'
let g:mkdp_theme = 'light'

" Shortmess: Remove Startup Screen
"
set shm+=sI
