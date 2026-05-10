export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins (keep minimal for faster startup)
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh


# ==============================
# NVM (Node Version Manager)
# ==============================

# Default location
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# XDG-compatible location (overrides above if applicable)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# ==============================
# Plugins & Enhancements
# ==============================

# zsh-autosuggestions (via Homebrew)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf (fuzzy finder)
source <(fzf --zsh)


# ==============================
# ZMX (Session Manager)
# ==============================

# Enable zmx completions if installed
if command -v zmx &> /dev/null; then
  eval "$(zmx completions zsh)"
fi

# Show current ZMX session in prompt
if [[ -n $ZMX_SESSION ]]; then
  export PS1="[$ZMX_SESSION] ${PS1}"
fi

# Fuzzy search + attach/create ZMX session
fs() {
  local display
  display=$(zmx list 2>/dev/null | while IFS=$'\t' read -r name pid clients created dir; do
    name=${name#*=}
    printf "%-20s\n" "$name"
  done)

  local output query key selected session_name
  output=$({ [[ -n "$display" ]] && echo "$display"; } | fzf \
    --print-query \
    --expect=ctrl-n \
    --height=80% \
    --reverse \
    --prompt="zmx> " \
    --header="Enter: select | Ctrl-N: create new" \
    --preview='zmx history {1}' \
    --preview-window=right:60%:follow \
  )
  local rc=$?

  query=$(echo "$output" | sed -n '1p')
  key=$(echo "$output" | sed -n '2p')
  selected=$(echo "$output" | sed -n '3p')

  if [[ "$key" == "ctrl-n" && -n "$query" ]]; then
    session_name="$query"
  elif [[ $rc -eq 0 && -n "$selected" ]]; then
    session_name=$(echo "$selected" | awk '{print $1}')
  elif [[ -n "$query" ]]; then
    session_name="$query"
  else
    return 130
  fi

  zmx attach "$session_name"
}


# ==============================
# zoxide (must be last)
# ==============================

eval "$(zoxide init zsh)"
