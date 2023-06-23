# !/bin/bash 
session="develop"
tmux new-session -d -s $session  

# nvim window
tmux rename-window -t $session:1 "nvim" 
tmux send-keys -t $session:1 'cd ~/repo/glad' C-m

# serve window
tmux new-window -t $session
tmux rename-window -t $session:2 "serve" 
tmux send-keys -t $session:2 'cd ~/repo/glad' C-m

# obs window
tmux new-window -t $session
tmux rename-window -t $session:3 "obs"  
tmux send-keys -t $session:3 'cd ~/repo/digitalMind' C-m

# cht window
tmux new-window -t $session
tmux rename-window -t $session:4 "cht" 
tmux send-keys -t $session:4 'cd ~/repo/cht' C-m 

# tmp window
tmux new-window -t $session
tmux rename-window -t $session:5 "tmp" 
tmux send-keys -t $session:5 

# focus on first window 
tmux select-window -t $session:1 

tmux attach-session -t $session

