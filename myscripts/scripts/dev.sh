#!/bin/bash

# Define session names
session="backstage"
sessionTwo="enterprise"
sessionThree="note"

# Define window numbers
windowOne=0
windowTwo=1

# Create session 1 -----
tmux new-session -d -s $session

# nvim window
tmux rename-window -t $session:1 "nvim"
tmux send-keys -t $session:1 'cd ~/repo/glad/backstage-frontend-v2 && nvm use 14' C-m

# serve window
tmux new-window -t $session
tmux rename-window -t $session:2 'serve' 
tmux send-keys -t $session:2 'cd ~/repo/glad/backstage-frontend-v2 && nvm use 14' C-m

# Focus on first window
tmux select-window -t $session:1


# Create session 2 -----
tmux new-session -d -s $sessionTwo

# nvim window
tmux rename-window -t $sessionTwo:1 "nvim"
tmux send-keys -t $sessionTwo:1 'cd ~/repo/glad/enterprise-project && nvm use 14' C-m

# serve window
tmux new-window -t $sessionTwo
tmux rename-window -t $sessionTwo:2 'serve' 
tmux send-keys -t $sessionTwo:2 'cd ~/repo/glad/enterprise-project && nvm use 14' C-m

# Focus on first window
tmux select-window -t $sessionTwo:1

# Create session 3 -----
tmux new-session -d -s $sessionThree

# obsidian window
tmux rename-window -t $sessionThree:1 "obsidian"
tmux send-keys -t $sessionThree:1 'nvim ~/repo/digitalMind' C-m

# cheat sheet window
tmux new-window -t $sessionThree
tmux rename-window -t $sessionThree:2 'cheatSheet' 
tmux send-keys -t $sessionThree:2 'nvim ~/repo/cht' C-m

# Focus on first window
tmux select-window -t $sessionThree:1

# Attach to sessions
tmux attach-session -t $session
tmux attach-session -t $sessionTwo
tmux attach-session -t $sessionThree
