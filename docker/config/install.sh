#!/bin/sh
SV="0.1.0"
WV="0.0.6"

# see if smoked exists
if [ ! -f ~/.smoke/smoked ]; then 
	cd ~/.smoke || exit 1

	printf "Do you wish to run an RPC node?\n"
	printf "Please do not run an RPC node if you intend to use this server to witness or a seed node. (y|n) "
	read -r isRPC

	if [ "$isRPC" = "n" ]; then
		printf "Do you wish to run a Seed node?\n"
		printf "Please do not run an Seed node if you intend to use this server to witness or as an RPC node. (y|n) "
		read -r isSeed
	fi

	if [ "$isRPC" = "n" ] && [ "$isSeed" = "n" ]; then
		printf "Installing Witness... \n"
	elif [ "$isRPC" = "y" ]; then
		printf "Installing RPC node... \n"
	elif [ "$isSeed" = "y" ]; then
		printf "Installing Seed node... \n"
	fi

	if [ "$isRPC" = "y" ]; then # download and extract full smoked
		wget https://github.com/smokenetwork/smoked/releases/download/v${SV}/smoked-${SV}-x86_64-linux.tar.gz
		tar -xzf smoked-${SV}-x86_64-linux.tar.gz
		rm smoked-${SV}-x86_64-linux.tar.gz
	else # download and extract light version
		wget https://github.com/smokenetwork/smoked/releases/download/v${SV}/smoked_lm-${SV}-x86_64-linux.tar.gz
		tar -xzf smoked_lm-${SV}-x86_64-linux.tar.gz
		rm smoked_lm-${SV}-x86_64-linux.tar.gz
	fi

	# download and extract wallet
	wget https://github.com/smokenetwork/smoked/releases/download/v${WV}/cli_wallet-${WV}-x86_64-linux.tar.gz
	tar -xzf cli_wallet-${WV}-x86_64-linux.tar.gz
	rm cli_wallet-${WV}-x86_64-linux.tar.gz
	
	# wait two seconds
	printf "Starting Smoked to build directories...\n"
	sleep 2

	# Launch script in background
	~/.smoke/smoked &
	# Get its PID
	smokePID=$!
	# Wait for 2 seconds
	sleep 2
	# Kill it
	kill -INT $smokePID
	sleep 4

	# move preset configs
	if [ "$isRPC" = "y" ]; then
		cp ~/.config/rpc-config.ini witness_node_data_dir/config.ini
	elif [ "$isSeed" = "y" ]; then
		cp ~/.config/seed-config.ini witness_node_data_dir/config.ini
	else
		cp ~/.config/witness-config.ini witness_node_data_dir/config.ini
	fi
	# move to home dir
	cd || exit 1
fi

# run tmux with multiple window created.
session="Hotbox v2.2.0 | ctrl+b # to swich | ctrl+h to leave"

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s "$session"

# create a new window called scratch
tmux new-window -t "$session":1 -n wallet

# return to main vim window
tmux select-window -t "$session":0

# Finished setup, attach to the tmux session!
tmux attach-session -t "$session"

exit
