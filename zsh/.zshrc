autoload -U compinit; compinit
autoload -U colors; colors
autoload -U promptinit; promptinit

unsetopt beep
setopt PROMPT_SUBST
setopt NO_CORRECT

zstyle ':completion:*:cd:*' tag-order local-directories
zstyle ':completion:*' menu select
unsetopt menu_complete

ZSH=$HOME/.zsh
source $ZSH/git.zsh
source $ZSH/functions.zsh

HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
bindkey -e

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
export PATH=$PATH:~/.tang

export WORKON_HOME=$HOME/.virtualenvs
export WORKSPACE_HOME=$HOME/workspace
export PROJECT_HOME=$HOME/projects
export VIRTUAL_ENV_DISABLE_PROMPT=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
source "/usr/local/bin/virtualenvwrapper.sh"

# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.1.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# AWS credentials
#export AWS_ACCESS_KEY_ID=<Enter Access Key Id>
#export AWS_SECRET_ACCESS_KEY=<Enter Secret Access Key>

# AWS zsh autocompletion
source /usr/local/share/zsh/site-functions/_aws

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='mvim'
fi

bindkey '^[[Z' reverse-menu-complete

alias ls="ls -hGp"

bindkey "\e[3~" delete-char

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pyvenv command line shortcuts
# source activate in virtual env and export all env vars in .env file
alias pva='source .venv/bin/activate; eval $(cat .env | sed -e "s/^/export /")'
# create new virtual env, active it, and upgrade pip
alias pvc='find . -name ".venv" | egrep ".*" || python3 -m venv .venv && pva && pip install -U pip'
# deactivate virtualenv
alias pvd='deactivate'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    if [[ -z $TMUX ]]; then
        tmux attach;
        exit;
    fi
fi

# docker-machine env var for default vm
eval $(docker-machine env default)

# GO lang env vars
export GOPATH=$HOME/projects/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Because why not
archey
