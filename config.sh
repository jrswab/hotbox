#!/bin/bash

if [ $# -eq 0 ]; then
	nano .smoke/witness_node_data_dir/config.ini
else
	$1 .smoke/witness_node_data_dir/config.ini
fi

