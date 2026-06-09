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

# PlatformIO
export PATH=$PATH:/home/zeit/.platformio/penv/bin

#python Venv
alias venv="source ~/Apps/Venvs/default/bin/activate"

#aliases
alias tsinit="sh /home/zeit/Apps/tsinit.sh"
alias g="googler"
alias crun="sh ~/Apps/cRunner.sh"
alias bfmt="numfmt --to=iec-i --suffix=B --format=\"%9.2f\""
alias dblog="sh ~/Apps/pgLogs.sh"
alias get_idf=". /opt/esp-idf/export.sh"
alias kill-monitor="ps -ef | grep \"idf.py monitor\" | awk 'NR==1 {print \$2}' | xargs -I {} kill -9 {}"
alias prod-nix="ssh zeit@193.123.113.29"
#alias postman-agent="exec ~/Apps/postman-agent/agent"

#bat-aliases
#alias cat="bat"
alias diff="batdiff"
#alias grep="batgrep"
alias ls="eza"
alias update-qualis="sh ~/Apps/update-qualis-sqlite.sh"
alias connect-adb="sh ~/Apps/connect-adb.sh"

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

export EDITOR="code --wait"

#fzf
source <(fzf --zsh)
JAVA_HOME=/usr/lib/jvm/java-17-openjdk

# opencode
export PATH=/home/zeit/.opencode/bin:$PATH

export XDG_SESSION_TYPE=x11

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
