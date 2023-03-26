#!/bin/bash 
#! /usr/bin/env zsh
session=$1
tmux new-session -d -s $session

# set up window 1
window=1
tmux rename-window -t $session:$window 'nvim'
tmux send-keys -t $session:$window 'cd ~/repo/cambrian/admin_e_commerce_front/' C-m

# set up window 2
window=2
tmux new-window -t $session:$window -n 'shoppin'
tmux send-keys -t $session:$window 'cd ~/repo/cambrian/admin_e_commerce_front/' C-m

# set up window 3
window=3
tmux new-window -t $session:$window -n 'storybook'
tmux send-keys -t $session:$window 'cd ~/repo/cambrian/' C-m

tmux attach-session -t $session

