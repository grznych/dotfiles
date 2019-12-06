HISTSIZE=1000 SAVEHIST=1000 HISTFILE=~/.zsh_history

setopt share_history hist_ignore_space hist_reduce_blanks hist_ignore_all_dups
setopt correct auto_cd complete_in_word extended_glob

autoload -Uz vcs_info compinit && compinit

preexec() print -n "\e]0;$1\a"

precmd() {
    print -Pn '\e]0;%~\a' ; vcs_info
    psvar=(yellow magenta blue ${vcs_info_msg_0_#*:})
    local hs=`date +%-H` US=red U=yellow S=green
    (( 0 < $hs && $hs <  8 ))            && psvar[1]=red
    (( 9 < $hs && $hs < 23 ))            && psvar[1]=green
    [[ $PWD:A = $HOME* ]]                && psvar[2]=cyan
    [[ ${hs::=${vcs_info_msg_0_%%:*}} ]] && psvar[3]=${(P)hs}
}

PROMPT='%B[%F{%v}%T%f][%F{%2v}%~%f]%(4V.[%F{%3v}%4v%f].)%F{%(?.green.red)}$%f%b '
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

command_not_found_handler() {
    local pkgs=(${(f)"$(pacman -F $1 2>/dev/null)"})
    if [[ $pkgs ]]; then
        print -P "%B%F{red}$1%f%b may be found in the following packages:"
        print -Pf "  %s\n" ${pkgs/\/(#b)(*) //%B%F{yellow}$match%f%b }
    else
        print -P "Command not found: %B%F{red}$1%f%b"
    fi 1>&2
    return 127
}

bindkey -v

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu true select
zstyle ':completion:*' list-colors 'ma=7;33'
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B[%F{yellow}%d%f]%b'
zstyle ':completion:*:messages' format '%B[%F{red}%d%f]%b'
zstyle ':completion:*:corrections' format '%B[%F{red}%d:%e%f]%b'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%u%c:%b:%a'
zstyle ':vcs_info:*' formats '%u%c:%b'
zstyle ':vcs_info:*' check-for-changes true
