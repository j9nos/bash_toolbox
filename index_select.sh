#!/bin/bash
# author:j9nos

function select_by_index() {
    : '
        1. output reference
        2. read message
        3. mapfile
    '
    local outref=$1; shift
    local readonly message=$1; shift
    local readonly options=("$@")
    for i in "${!options[@]}"; do
        echo "[$i] --> ${options[$i]}"
    done
    local selected=""
    while [[ -z "$selected" ]]; do
        read -p "$message" index
        if [[ "$index" =~ ^[0-9]+$ ]] && [ "$index" -ge 0 ] && [ "$index" -lt ${#options[@]} ]; then
            selected="${options[$index]}"
        fi
    done
    eval $outref='$selected'
}

function select_action() {
    local actions
    mapfile -t actions < <(echo -e "GO UP\nGO DOWN\nGO RIGHT\nGO LEFT")
    select_by_index action "Select an action by index: " "${actions[@]}"
    echo "You selected: $action"
}


select_action
