# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

#NVM
source /usr/share/nvm/init-nvm.sh

# ANDROID_HOME
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

#python Venv
alias venv="source ~/Apps/Venvs/default/bin/activate"

#aliases
alias tsinit="sh /home/zeit/Apps/tsinit.sh"
alias g="googler"
alias crun="sh ~/Apps/cRunner.sh"
alias bfmt="numfmt --to=iec-i --suffix=B --format=\"%9.2f\""
alias dblog="sh ~/Apps/pgLogs.sh"
alias postman-agent="exec ~/Apps/postman-agent/agent"

# Load Angular CLI autocompletion.
source <(ng completion script)




# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/zeit/.opam/opam-init/init.zsh' ]] || source '/home/zeit/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# Home, End, Del, Ctrl left, Ctrl right
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#fzf
source <(fzf --zsh)
