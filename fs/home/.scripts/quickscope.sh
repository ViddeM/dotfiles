#!/usr/bin/env bash

QS="/home/vmagnus3/Documents/projects/vcrs/tools/quickscope-cli/target/release/quickscope_rs"

# SELECTED="$($QS list | fzf --header-lines 1 | cut -d ' ' -f3)"
SELECTED="$($QS list -p | fuzzel -d --log-level none)"
echo $SELECTED
$QS get $SELECTED -p | tail -1 | wl-copy 

