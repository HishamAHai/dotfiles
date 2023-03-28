# Prompt
preexec() {
    cmd_start="$SECONDS"
}
precmd() {
  local cmd_end="$SECONDS"
  elapsed=$((cmd_end-cmd_start))
  PS1="%F{magenta}%n%f%F{green}@%f%F{blue}%m%f%F{yellow}[took $elapsed%ss]%f%K{red}$(gitstatus -i)%k%F{red}%(3~|%-1~/…/%2~|%3~)%f "
}

setopt autocd # Automaticaly cd into typed directory.

# Colored man pages
function man() {
	env \
		LESS_TERMCAP_md=$(tput bold; tput setaf 4) \
		LESS_TERMCAP_me=$(tput sgr0) \
		LESS_TERMCAP_mb=$(tput blink) \
		LESS_TERMCAP_us=$(tput setaf 2) \
		LESS_TERMCAP_ue=$(tput sgr0) \
		LESS_TERMCAP_so=$(tput smso) \
		LESS_TERMCAP_se=$(tput rmso) \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}


# The following lines were added by compinstall
zstyle ':completion:*' completer _menu _expand _complete _correct _approximate
zstyle ':completion:*' completions 0
zstyle ':completion:*' glob 0
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 10
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/hisham/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

# History configuration
# history file location
HISTFILE=~/.cache/zsh/history
# hisotry file length
HISTSIZE=10000
SAVEHIST=10000
# immediate append
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T]"
# add Timestamp to history
setopt EXTENDED_HISTORY
# disable duplication
setopt HIST_FIND_NO_DUPS

# Set the machine hostname
HOSTNAME=$HOST

# Use vi-mode
bindkey -v

# fast directory switching
if command -v fasd &> /dev/null
then
eval "$(fasd --init auto)"
fi

# End of lines configured by zsh-newuser-install
# Aliases
[[ -f "$HOME/.config/aliases" ]] && source "$HOME/.config/aliases"

# icons for lf file manager
LF_ICONS=$(sed ~/.config/diricons \
            -e '/^[ \t]*#/d'       \
            -e '/^[ \t]*$/d'       \
            -e 's/[ \t]\+/=/g'     \
            -e 's/$/ /')
LF_ICONS=${LF_ICONS//$'\n'/:}
export LF_ICONS

# Startup commands
#color_test.sh
shuf -n 1 /home/hisham/.local/share/quotes | lolcat
#shuf -n 1 /home/hisham/.local/share/quotes | fribidi --nobreak | lolcat
date +%A\ %d\ %B\ %Y\ %H:%M 
uname -nrm
uptime -p | sed "s/up\s/Elapsed Time: /;s/hours,\s/hs:/g;s/minutes/min/"

# Autosuggestion and syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# clone the gitstatus repo
# git clone "https://github.com/xylous/gitstatus.git" gitstatus
#
source $HOME/.config/zsh/gitstatus/gitstatus.plugin.zsh

# zoxide
eval "$(zoxide init zsh)"

# mcfly
#eval "$(mcfly init zsh)"
