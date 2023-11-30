# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"
plugins=(
    git
    python
    npm
    yarn
    kubectl
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
DISABLE_AUTO_TITLE="true"
alias set_tab_name='f(){ [ "$1" ] && echo -ne "\e]1;$1\a" || true } ; f'
export AXONIUS_DEV=1

## Basic Commands
alias ~='cd ~'
alias ll='exa -la'
alias cl='clear'

## K8s
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

## Terraform
alias tfa="terraform apply -auto-approve"
alias tfd="terraform destroy -auto-approve"
alias tfp="terraform plan"
alias tff="terraform fmt"
alias tfi="terraform init"

## Git
alias gup="git checkout develop; git fetch upstream; git pull upstream develop; git push origin develop"

## AWS
alias ssm-prod="aws ssm start-session --profile ax-prod-rnd  --region us-east-2 --target"
alias ssm-legacy="aws ssm start-session --profile ax-prod-legacy --region us-east-2 --target"
alias ssm-dev="aws ssm start-session --profile ax-dev-rnd --region us-east-2 --target"
alias aws-prod="aws --profile ax-prod-rnd  --region us-east-2 "
alias aws-legacy="aws --profile ax-prod-legacy --region us-east-2 "
alias aws-dev="aws --profile ax-dev-rnd --region us-east-2 "
alias prod-login="aws sso login --profile ax-prod-rnd"
alias dev-login="aws sso login --profile ax-dev-rnd"
alias legacy-login="aws sso login --profile ax-prod-legacy"

# Docker
alias di="docker images "
alias dps="docker ps -a "
alias de="docker exec "
alias deit="docker exec -it "

## PATH
export PATH="$HOME/.local/bin:$PATH"
export KUBECONFIG="$HOME/.kube/config"

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

## Functions
function tcolorset {
    echo -e "\033]6;1;bg;red;brightness;$1\a\r\033[A"
    echo -e "\033]6;1;bg;green;brightness;$2\a\r\033[A"
    echo -e "\033]6;1;bg;blue;brightness;$3\a\r\033[A"
}

function tcolor {
    choice=$((1 + $RANDOM % 12))
    case $choice in
    1) tcolorset 255 51 51;;
    2) tcolorset 255 153 51;;
    3) tcolorset 255 255 51;;
    4) tcolorset 153 255 51;;
    5) tcolorset 51 255 51;;
    6) tcolorset 51 255 153;;
    7) tcolorset 51 255 255;;
    8) tcolorset 51 153 255;;
    9) tcolorset 51 51 255;;
    10) tcolorset 153 51 255;;
    11) tcolorset 255 51 255;;
    12) tcolorset 255 51 153;;
    esac
}
