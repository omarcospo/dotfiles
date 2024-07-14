# Prompt
setopt PROMPT_SUBST
PROMPT='%F{yellow}[%n]%f %~ '

# Aliases
alias ee='eza'
alias qq='clear'
alias eq='exit'
alias npmi='cd ~/.local && npm install'

# Paths
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export GOPATH="$XDG_DATA_HOME"/go
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$XDG_DATA_HOME/nvim/mason/bin:$PATH"

# FZF
FUZZY_OPTS="--color=bg+:-1,gutter:-1 --reverse --border --bind ctrl-f:accept,ctrl-h:backward-delete-char"
export FZF_DEFAULT_OPTS=$FUZZY_OPTS
export _ZO_FZF_OPTS=$FUZZY_OPTS

# Custom commands
cd() {__zoxide_z "$@" && command eza -lah --color always}

pyenv() {source "$HOME/.local/python/bin/activate"}

eza() {command eza -lah --color always "$@"}

vv() { NVIM_APPNAME=nvim nvim "$@" }

vq() {
  local config=$(fd --max-depth 1 --glob 'nvim*' ~/.config | fzf --prompt="  Neovim Config: " --height=~50% --bind=ctrl-f:accept --color=bg+:-1,gutter:-1 --reverse --border)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename $config) nvim $@
}

###### --------------------------------------
if [[ $- != *i* ]]; then
    return
fi
# completion cache path setup
typeset -g comppath="$HOME/.cache"
typeset -g compfile="$comppath/.zcompdump"
if [[ -d "$comppath" ]]; then
    [[ -w "$compfile" ]] || rm -rf "$compfile" >/dev/null 2>&1
else
    mkdir -p "$comppath"
fi

# COMPLETION
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:approximate:*' max-errors 'reply=($(( ($#PREFIX + $#SUFFIX) / 3 )) numeric)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$comppath"
zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose true
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu select
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:-command-:*:' verbose false
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' completer _complete _match _approximate _ignored
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:messages' format ' %F{green}->%F{purple} %d%f'
zstyle ':completion:*:descriptions' format ' %F{green}->%F{yellow} %d%f'
zstyle ':completion:*:warnings' format ' %F{green}->%F{red} no matches%f'
zstyle ':completion:*:corrections' format ' %F{green}->%F{green} %d: %e%f'
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=36=0=01'
zstyle ':completion:*:functions' ignored-patterns '(prompt*|_*|*precmd*|*preexec*)'
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:(vim|nvim|vi|nano|emacs):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif)'
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle -e ':completion:*:hosts' hosts 'reply=( ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ } ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*} ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}})'
ttyctl -f

# OPTIONS
KEYTIMEOUT=1
SAVEHIST=10000
HISTSIZE=10000
HISTFILE="$HOME/.cache/.zsh_history"
setopt CORRECT
setopt NO_NOMATCH
setopt LIST_PACKED
setopt ALWAYS_TO_END
setopt GLOB_COMPLETE
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt AUTO_CD
setopt AUTO_CONTINUE
setopt LONG_LIST_JOBS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_GLOB
setopt TRANSIENT_RPROMPT
setopt INTERACTIVE_COMMENTS
export MANWIDTH=80
export LESS='-R'
export LESSHISTFILE=-
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[32m'
export LESS_TERMCAP_mb=$'\e[31m'
export LESS_TERMCAP_md=$'\e[31m'
export LESS_TERMCAP_so=$'\e[47;30m'
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# LOAD
autoload -Uz compinit && compinit     # completion
autoload -U terminfo     # terminfo keys
zmodload -i zsh/complist # menu completion

## --- KEYS
autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search
exp_alias() {
  zle _expand_alias
  zle self-insert
}; zle -N exp_alias
bindkey -- ' '     exp_alias
bindkey -- '^A'    beginning-of-line
bindkey -- '^[^M'  self-insert-unmeta # alt-enter to insert a newline/carriage return
bindkey -- '^[05M' accept-line # fix for enter key on some systems
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    zle-line-init() { echoti smkx; }; zle -N zle-line-init
    zle-line-finish() { echoti rmkx; }; zle -N zle-line-finish
fi
[[ -n ${terminfo[kcud1]} ]] && bindkey -- "${terminfo[kcud1]}" down-line-or-beginning-search # down arrow
[[ -n ${terminfo[kdch1]} ]] && bindkey -- "${terminfo[kdch1]}" delete-char                   # delete
[[ -n ${terminfo[kend]}  ]] && bindkey -- "${terminfo[kend]}"  end-of-line                   # end
[[ -n ${terminfo[kcuf1]} ]] && bindkey -- "${terminfo[kcuf1]}" forward-char                  # right arrow
[[ -n ${terminfo[kcub1]} ]] && bindkey -- "${terminfo[kcub1]}" backward-char                 # left arrow
[[ -n ${terminfo[kich1]} ]] && bindkey -- "${terminfo[kich1]}" overwrite-mode                # insert
[[ -n ${terminfo[khome]} ]] && bindkey -- "${terminfo[khome]}" beginning-of-line             # home
[[ -n ${terminfo[kbs]}   ]] && bindkey -- "${terminfo[kbs]}"   backward-delete-char          # backspace
[[ -n ${terminfo[kcbt]}  ]] && bindkey -- "${terminfo[kcbt]}"  reverse-menu-complete         # shift-tab
[[ -n ${terminfo[kcuu1]} ]] && bindkey -- "${terminfo[kcuu1]}" up-line-or-beginning-search   # up arrow
[[ -n ${terminfo[kcud1]} ]] && bindkey -- "${terminfo[kcud1]}" down-line-or-beginning-search # down arrow

# Plugins folder
ZSH_PLUGINS="$ZDOTDIR/.plugins"

zsh_plugin() {
 	local plugin_name=$(echo $1 | cut -d '/' -f 2)
  local plugin_folder="$ZSH_PLUGINS/$plugin_name"
  [[ ! -d $plugin_folder ]] && git clone --depth 1 "https://github.com/$1" "$plugin_folder"
  source "$plugin_folder/$2"
}

# Extensions
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zsh_plugin "hlissner/zsh-autopair" "autopair.zsh"
zsh_plugin "zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"
zsh_plugin "zsh-users/zsh-autosuggestions" "zsh-autosuggestions.plugin.zsh"

autopair-init
eval "$(zoxide init zsh)"
