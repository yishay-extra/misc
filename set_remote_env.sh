#! /bin/bash

HOME_PATH=${1:-~}

cat <<EOF | tee -a $HOME_PATH/.bashrc
alias ll='ls -la'
alias cl='clear'
alias di="docker images"
alias dps="docker ps -a"
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
syntax on

"###### MAPS #######

command! W :w
command! Q :q
command! Wq :wq
command! QQ :q!

"###### PLUGINS ######

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-gruvbox8'
Plug 'mtdl9/vim-log-highlighting'
Plug 'LunarWatcher/auto-pairs'
Plug 'maxboisvert/vim-simple-complete'
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()

"####### COLORS #######

set background=dark
colorscheme gruvbox8
EOF

vi -es -u $HOME_PATH/.vimrc -i NONE -c "PlugInstall" -c "qa"

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
