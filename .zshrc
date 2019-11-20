HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
setopt share_history hist_reduce_blanks hist_ignore_all_dups correct prompt_subst
autoload -Uz compinit vcs_info && compinit

precmd() {
    print -Pn '\e]0;%~\a'
    vcs_info ; case $vcs_info_msg_0_ in '' )  ;;
        *  ) local t=green p=([ ])            ;|
        US*) p=(%F{yellow}\[%f %F{yellow}]%f) ;&
        U* ) t=red                            ;|
        S* ) t=yellow                         ;&
    *) vcs_info_msg_0_=$p[1]%F{$t}${vcs_info_msg_0_#*:}%f$p[2] ; esac
}

preexec() print -Pn '\e]0;$1\a'

cold() {
    (( 0 < ${p=`date +%-H`} && $p < 8 )) && t=red
    (( 9 < $p && $p < 23 )) && t=green
    echo ${t=yellow}
}

chhm() { [[ $PWD = $HOME* ]] && t=blue ; echo ${t=cyan} }

PROMPT='%B[%F{$(cold)}%T%f][%F{$(chhm)}%~%f]${vcs_info_msg_0_}%F{%(?.green.red)}$%f%b '
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

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format "%F{yellow}%B---%d---%b%f"
zstyle ':completion:*:messages' format '%F{red}%B%d%b%f'
#zstyle ':completion:*:warnings' format "%F{red}No matches for:%f %d"
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%u%c:%b:%a'
zstyle ':vcs_info:*' formats '%u%c:%b'
