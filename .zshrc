HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt share_history hist_reduce_blanks hist_ignore_all_dups correct prompt_subst

autoload -U compinit && compinit
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format "%F{yellow}%B---%d---%b%f"
zstyle ':completion:*:messages' format '%F{red}%B%d%b%f'
#zstyle ':completion:*:warnings' format "%F{red}No matches for:%f %d"
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

precmd () print -Pn '\e]0;%~\a'
preexec () print -Pn '\e]0;$1\a'

cold()case `date +%-H` in;[1-7])echo red;;[089]|23)echo yellow;;*)echo green;esac
chhm(){[[ $PWD = $HOME* ]]&&echo blue||echo cyan}

#precmd() { [[ $? != 0 && $beep == on ]] && echo rassol }

PROMPT='%B[%F{$(cold)}%T%f][%F{$(chhm)}%~%f]%F{%(?.green.red)}$%f%b '
RPROMPT='%B[%F{%(?.green.red)}%?%f]%b'

export SYSTEMD_LESS=FRXMK

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias htop='htop -d 10'
alias syu='sudo pacman -Syu'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export LESS=-R
#export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
#export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_mb=$'\E[1;33m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

#man() {
#    LESS_TERMCAP_md=$'\e[01;31m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[01;44;33m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[01;32m' \
#    command man "$@"
#}
