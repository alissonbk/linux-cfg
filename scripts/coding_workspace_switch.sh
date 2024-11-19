#!/bin/bash

curr_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true) | .num')

if [ "$curr_workspace" == "10" ]; then
    i3 workspace 3
else
    i3 workspace 10
fi