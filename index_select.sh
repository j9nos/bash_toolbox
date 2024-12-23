#!/bin/bash

function select_by_index() {
    : '
        1. Output reference
        2. Read message
        3. Mapfile
    '
    declare -r outref="$1"; shift
    declare -r message="$1"; shift
    declare -r options=("$@")
    
    for i in "${!options[@]}"; do
        echo "[$i] --> ${options[$i]}"
    done
    
    local selected=""
    while [[ -z "$selected" ]]; do
        read -r -p "$message" index
        
        if [[ "$index" =~ ^[0-9]+$ ]] && [ "$index" -ge 0 ] && [ "$index" -lt ${#options[@]} ]; then
            selected="${options[$index]}"
        else
            echo "Your options are between 0 and $(( ${#options[@]} - 1 ))."
        fi
    done
    printf -v "$outref" '%s' "$selected"
}

mapfile -t actions < <(echo -e "GO UP\nGO DOWN\nGO RIGHT\nGO LEFT")
select_by_index action "Select an action by index: " "${actions[@]}"
echo "$action"