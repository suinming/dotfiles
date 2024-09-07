# print be patient
# figlet -t -f starwars "Be Patient" | lolcat

# prompt the system info
screenfetch

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export path variable
export PATH=~/mybin:$PATH
export PATH=$PATH:~/myscripts
export PATH=$PATH:~/.tmux/plugins/t-smart-tmux-session-manager/bin
export PATH=$PATH:~/bun/bin
export PATH=$PATH:/home/suinming/.local/share/npm
export PATH=$PATH:/home/suinming/.local/share/npm/bin
export PATH=$PATH:/home/suinming/.local/share/bob/nvim-bin
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

# set the vim mode in command line
set -o vi

# cd up to n dirs
# using:  cd.. 10   cd.. dir
function cd_up() {
  case $1 in
    *[!0-9]*)                                          # if no a number
      cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" )     # search dir_name in current path, if found - cd to it
      ;;                                               # if not found - not cd
    *)
      cd $(printf "%0.0s../" $(seq 1 $1));             # cd ../../../../  (N dirs)
    ;;
  esac
}
alias "cd.."="cd_up"                                
alias uu="sudo apt update -y && sudo apt upgrade -y"

# trash cli
alias tp="trash-put"
alias tm="trash-empty"
alias tl="trash-list"
 
# execute pycharm
# alias pycharm="bash ~/Downloads/pycharm-community-2023.2.1/bin/pycharm.sh"

# git alias
alias gs='git status'
alias gbr="git branch"
alias gco="git checkout \$1 \$2"
alias gre="git restore \$1"
alias gaa="git add --all"
alias gcm="git commit"
alias gp="git push origin \$1"
alias gpl="git pull origin \$1"
alias gac="git add --all && git commit"
alias gwc="bash $HOME/dotfiles/myscripts/scripts/gwc.sh" # execute git worktree clone bash script
alias gwl="git worktree list"
alias gwa="git worktree add \$1 \$2" # there might be one or two arguments
alias gwr="git worktree remove \$1"

# zsh plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide
eval "$(zoxide init zsh)"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/home/suinming/.bun/_bun" ] && source "/home/suinming/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# deno
export DENO_INSTALL="/home/suinming/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# start ship 
eval "$(starship init zsh)"

# kulala-fmt
# kulala-fmt
alias kulala-fmt="~/Downloads/kulala-fmt-linux"
