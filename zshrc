# My zsh config file :)
# This is an amalgomation of code from various rcfiles which came before me

# if we're not running interactively, don't configure the shell
case $- in
    *i*) ;;
      *) return;;
esac


## Prompt
autoload -Uz promptinit
autoload -Uz vcs_info
promptinit
precmd() { vcs_info }

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:git:*' formats       'on %F{green}%b %F{default}%F{yellow}%u%c%F{default} '
zstyle ':vcs_info:git:*' actionformats 'on %F{green}%b %F{default}%F{yellow}%a%u%c%F{default} '
setopt PROMPT_SUBST
PROMPT='%B%F{blue}${PWD/#$HOME/~}%F{default}%b ${vcs_info_msg_0_}%% '


## Shell Configuration
bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


## Environment
export EDITOR='vim'

alias mkdir='mkdir -p'
alias python='python3'
alias pip='pip3'
alias py='python3'
alias newsboat='newsboat -r'
alias todo="$EDITOR $HOME/Desktop/todo.md"

alias ll='ls -alF'
alias la='ls -A'

# try to find a rust installation
if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
fi

# try to find the asdf version manager
# https://asdf-vm.com/
if [ -f "$HOME/.asdf/asdf.sh" ]; then
    . "$HOME/.asdf/asdf.sh"
else
    # we install asdf using brew on macos
    if [ `uname -s` = 'Darwin' ]; then
        if [ -f "$(brew --prefix asdf)/asdf.sh" ]; then
            . $(brew --prefix asdf)/asdf.sh
        fi
    fi
fi

# set machine-specific environment configs
# useful for java home etc.
if [ -f "$HOME/.zsh_environment" ]; then
    source "$HOME/.zsh_environment"
fi


case `uname -s` in
	'Darwin')
		alias ls='ls -G'
		alias grep='grep -G'
		alias fgrep='fgrep -G'
		alias egrep='egrep -G'
		;;
	'Linux')
		export GCM_CREDENTIAL_STORE='secretservice'
		alias ls='ls --color=auto'
		;;
esac

