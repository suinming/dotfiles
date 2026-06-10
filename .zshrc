# =====================================================================
# 1. CORE SHELL & ENVIRONMENT VARIABLES
# =====================================================================

# Set language and character encoding
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme selection
ZSH_THEME="robbyrussell"

# Core plugins (keep minimal for faster shell startup)
plugins=(git)

# Load Oh My Zsh framework
source $ZSH/oh-my-zsh.sh


# =====================================================================
# 2. RUNTIME ENVIRONMENTS & DEVELOPMENT TOOLS
# =====================================================================

# --- NVM (Node Version Manager) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"           # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # Load nvm bash_completion

# --- Java Setup ---
export JAVA_HOME="$HOME/tools/jdk-17.0.19.jdk/Contents/Home"

# --- Maven Setup ---
export MAVEN_HOME="$HOME/tools/apache-maven-3.9.16"

# --- Path Configuration ---
# Update PATH with Java and Maven binary locations
export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"


# =====================================================================
# 3. INTERACTIVE CLI PLUGINS & ENHANCEMENTS
# =====================================================================

# zsh-autosuggestions (installed via Homebrew)
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# fzf (fuzzy finder shell integrations)
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi


# =====================================================================
# 4. ZMX SESSION MANAGER CONFIGURATION & FUNCTIONS
# =====================================================================

# Enable ZMX autocompletions if installed
if command -v zmx &> /dev/null; then
  eval "$(zmx completions zsh)"
fi

# Dynamically prepend current ZMX session name to your prompt
if [[ -n $ZMX_SESSION ]]; then
  export PS1="[$ZMX_SESSION] ${PS1}"
fi

# --- ZMX Interactive Fuzzy Switcher ---
# Lists active ZMX sessions inside fzf for quick attachment or creation
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

# --- ZMX Helper: Attach to a session by name ---
attach_session() {
  local session_name="$1"

  if [[ -z "$session_name" ]]; then
    echo "session name required"
    return 1
  fi

  zmx attach "$session_name"
}

# --- ZMX Helper: Kill all running sessions ---
zka() { 
  zmx list --short | xargs zmx kill; 
}


# =====================================================================
# 5. TERMINAL BEHAVIOR & VI-MODE BINDINGS
# =====================================================================

# Enable Vi command line editing mode
bindkey -v

# Change cursor shape based on active Vi mode (Block for Cmd, Beam for Insert)
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[1 q' # Block cursor
  else
    echo -ne '\e[5 q' # Beam cursor
  fi
}
zle -N zle-keymap-select

# Ensure the prompt defaults to an Insert mode beam cursor on initialization
function zle-line-init {
  echo -ne '\e[5 q'
}
zle -N zle-line-init


# =====================================================================
# 6. DIRECTORY JUMPING (MUST BE LAST)
# =====================================================================

# Initialize zoxide for smart 'cd' tracking
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi
