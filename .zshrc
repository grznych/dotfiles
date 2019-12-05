HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt share_history hist_ignore_space hist_reduce_blanks hist_ignore_all_dups correct auto_cd menu_complete complete_in_word

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

#command_not_found_handler() {
#    local pkgs=(${(f)"$(pacman -Fq $1 2>/dev/null)"})
#    if [[ $pkgs ]]; then
#        print -P "%B%F{red}$1%f%b may be found in the following packages:"
#        for p in $pkgs ; do
#            #echo ${p[(i)/]}
#            p[p[(i)/]]+=%B%F{yellow}
#            print -P "    $p%f%b"
#        done
#    else
#        print -P "Command not found: %B%F{red}$1%f%b"
#    fi 1>&2
#    return 127
#}

bindkey -v

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'ma=7;33'
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B[%F{yellow}%d%f]%b'
zstyle ':completion:*:messages' format '%B[%F{red}%d%f]%b'
zstyle ':completion:*:corrections' format '%B[%F{red}%d:%e%f]%b'

#zstyle ':completion:*:warnings' format "%F{red}No matches for:%f %d"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%u%c:%b:%a'
zstyle ':vcs_info:*' formats '%u%c:%b'
zstyle ':vcs_info:*' check-for-changes true
