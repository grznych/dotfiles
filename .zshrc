HISTSIZE=500 SAVEHIST=1000 HISTFILE=~/.zsh_history

setopt -g share_history hist_reduce_blanks hist_ignore_all_dups
setopt -JN0 pushd_ignore_dups complete_in_word

autoload -Uz vcs_info compinit && compinit

preexec() print -n "\e]0;$1\a"

precmd() {
    print -Pn '\e]0;%~\a' ; vcs_info
    psvar[1,4]=(yellow magenta blue "${vcs_info_msg_0_#*:}")
    local hs=`date +%-H` US=red U=yellow S=green
    (( 0 < $hs && $hs <  7 ))            && psvar[1]=red
    (( 9 < $hs && $hs < 22 ))            && psvar[1]=green
    [[ $PWD:A = $HOME* ]]                && psvar[2]=cyan
    [[ ${hs::=${vcs_info_msg_0_%%:*}} ]] && psvar[3]=${(P)hs}
}

psvar[5]=$ ; [[ $RANGER_LEVEL ]] && psvar[5]=r

PROMPT='%B[%F{%v}%T%f][%F{%2v}%~%f]%(4V.[%F{%3v}%4v%f].)%F{%(?.green.red)}%5v%f%b '
RPROMPT='%B[%F{%(?.green.red)}%?%f]%b'
SPROMPT='Correct %B%F{red}%R%f%b to %B%F{yellow}%r%f%b [nyae]? '
MENUPROMPT='%S%F{green}%P%f%s'

alias diff='diff --color=auto' grep='grep --color=auto' ls='ls --color=auto'
alias htop='htop -d 10' syu='sudo pacman -Syu'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export LESS_TERMCAP_mb=$'\e[1;33m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESS_TERMCAP_ue=$'\e[0m'

export SYSTEMD_LESS=FRXMK

eval `dircolors`

bindkey -v

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu true select
zstyle ':completion:*' list-colors "${LS_COLORS}ma=7;33"
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B[%F{yellow}%d%f]%b'
zstyle ':completion:*:messages' format '%B[%F{red}%d%f]%b'
zstyle ':completion:*:corrections' format '%B[%F{red}%d:%e%f]%b'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%u%c:%b:%a'
zstyle ':vcs_info:*' formats '%u%c:%b'
zstyle ':vcs_info:*' check-for-changes true
