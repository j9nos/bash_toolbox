#!/bin/bash

function get_extensions() {
    find . -type f -name '*.*' ! -name "$(basename "$0")" | awk -F'.' '{print $NF}' | sort -u
}

function create_folders_and_move_files() {
    for ext in $(get_extensions); do
        local folder_name="${ext}s"
        if [ ! -d "$folder_name" ]; then
            mkdir "$folder_name"
        fi
        find . -type f -name "*.${ext}" -print0 | xargs -0 -I {} mv {} "$folder_name"
    done
}

create_folders_and_move_files
