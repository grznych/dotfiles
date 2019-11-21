HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt share_history hist_reduce_blanks hist_ignore_all_dups correct
autoload -Uz compinit vcs_info && compinit

preexec() print -Pn "\e]0;$1\a"

precmd() {
    print -Pn '\e]0;%~\a' ; vcs_info
    psvar=(yellow cyan cyan ${vcs_info_msg_0_#*:})
    local hs=`date +%-H`
    (( 0 < $hs && $hs <  8 )) && psvar[1]=red
    (( 9 < $hs && $hs < 23 )) && psvar[1]=green
    [[ $PWD = $HOME* ]]       && psvar[2]=blue
    case ${vcs_info_msg_0_%%:*} in
        US) psvar[3]=red    ;;
        U ) psvar[3]=yellow ;;
        S ) psvar[3]=green
    esac
}

PROMPT='%B[%F{%v}%T%f][%F{%2v}%~%f]%(4V.[%F{%3v}%4v%f].)%F{%(?.green.red)}$%f%b '
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

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format "%F{yellow}%B---%d---%b%f"
zstyle ':completion:*:messages' format '%F{red}%B%d%b%f'
#zstyle ':completion:*:warnings' format "%F{red}No matches for:%f %d"
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%u%c:%b:%a'
zstyle ':vcs_info:*' formats '%u%c:%b'
zstyle ':vcs_info:*' check-for-changes true

#. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
