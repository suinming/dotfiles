# !/bin/bash 
session=$1
tmux new-session -d -s $session

# Initialize a window counter variable
window=1

# Loop through all input arguments starting from the second argument
for arg in "${@:2}"
do
    # Perform some action with each argument
    echo "Processing argument: $arg"

    if [$counter -eq 1] 
    then
        # code to execute if this is the first argument 
        tmux rename-window -t $session:$window $arg 
        tmux send-keys -t $session:$window 'cd ~/repo/' C-m
    else
        tmux new-window -t $session:$window -n $arg 
        tmux send-keys -t $session:$window 'cd ~/repo/' C-m
    fi
    # Increment the window counter by 1
    window=$((window+1))
done

tmux attach-session -t $session

