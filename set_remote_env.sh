#! /bin/bash

HOME_PATH=${1:-~}

cat <<EOF | tee -a $HOME_PATH/.bashrc
alias ll='ls -la'
alias cl='clear'
alias di="docker images"
alias dps="docker ps -a"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias _="sudo "
EOF

curl -fLo $HOME_PATH/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat <<EOF | tee $HOME_PATH/.vimrc 
"###### SETS ######

set nocompatible
set number
set hlsearch
set ignorecase
set encoding=utf-8
set fileencoding=utf-8
set path+=**
set wildmenu
set belloff=all
syntax on
filetype plugin on

set tabstop=4
set shiftwidth=4
set expandtab

"###### MAPS #######

map <leader>n :set invnumber<CR>
map <leader>nr :set invnumber invrelativenumber<CR>
map <leader>j 10j<CR>
map <leader>k 10k<CR>
map <leader>w :w<CR>
map <leader>ww :wq<CR>
map <leader>q :q<CR>
map <leader>qq :q!<CR>
map <leader>c ^vg_"*y
map <leader>cb (v)k$"*y
map <leader>cw wbvwh"*yw
map <leader>ca ggvG$"*yw

nnoremap <C-[> 10k<CR>
nnoremap <C-]> 10j<CR>

"###### PLUGINS ######

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-gruvbox8'
Plug 'mtdl9/vim-log-highlighting'
Plug 'LunarWatcher/auto-pairs'
Plug 'maxboisvert/vim-simple-complete'
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vimwiki/vimwiki'
Plug 'yegappan/mru'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-commentary'
call plug#end()

"####### COLORS #######

set background=dark
colorscheme gruvbox8

"####### PlUGINS CONFIG #######

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

let g:vimwiki_list = [{'path': '~/vimwiki/'}]
let g:vimwiki_hl_headers=1
let g:vimwiki_hl_cb_checked=1

let g:yankstack_yank_keys = ['y', 'd']
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

let MRU_Max_Entries = 100
map <leader>f :MRU<CR>
EOF

cat <<EOF | sudo tee $HOME_PATH/.tmux.conf
#### COLOUR (Solarized 256)

# default statusbar colors
set-option -g status-style fg=colour136,bg=colour235 #yellow and base02

# default window title colors
set-window-option -g window-status-style fg=colour244,bg=default #base0 and default
#set-window-option -g window-status-style dim

# active window title colors
set-window-option -g window-status-current-style fg=colour166,bg=default #orange and default
#set-window-option -g window-status-current-style bright

# pane border
set-option -g pane-border-style fg=colour235 #base02
set-option -g pane-active-border-style fg=colour240 #base01

# message text
set-option -g message-style fg=colour166,bg=colour235 #orange and base02

# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange

# clock
set-window-option -g clock-mode-colour colour64 #green

# bell
set-window-option -g window-status-bell-style fg=colour235,bg=colour160 #base02, red


# Vi Coloscheme compatibility
set -g default-terminal "screen-256color"
EOF

source $HOME_PATH/.bashrc
vi -es -u $HOME_PATH/.vimrc -i NONE -c "PlugInstall" -c "qa"