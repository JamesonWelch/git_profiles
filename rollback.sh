#!/bin/bash

search_string="gitconfig"
dest_directory="$HOME/.gitconfig_versions"

find_latest_files() {
    ls -t "$dest_directory"/*"$search_string"*
}


extract_base_name() {
    local file_path=$1
    local base_name=$(basename "$file_path")
    echo "${base_name%_*}.${base_name##*.}"
}


file_exists_in_home() {
    local file_name=$1
    [ -e "$HOME/$file_name" ]
}


move_files_to_home() {
    local files=("$@")
    for file in "${files[@]}"; do
        mv "$file" "$HOME"
    done
}


display_files() {
    local files=("$@")
    printf '%s\n' "${files[@]}"
}


latest_files=$(find_latest_files)


files_to_delete=()
files_to_replace=()

# Loop through the latest files and populate the arrays
for file in $latest_files; do
    base_name=$(extract_base_name "$file")
    if file_exists_in_home "$base_name"; then
        files_to_replace+=("$base_name")
    else
        files_to_delete+=("$file")
    fi
done

# Display the files to be deleted and the files to be replaced
echo "Files to be deleted:"
display_files "${files_to_delete[@]}"
echo
echo "Files to be replaced:"
display_files "${files_to_replace[@]}"
echo

# Prompt the user for confirmation
read -p "Are you sure you want to continue? (y/n) " answer

# Check the user's response
if [[ "$answer" == [Yy] ]]; then
    # User confirmed, proceed with the rollback

    # Move the files to be deleted back to the home directory
    move_files_to_home "${files_to_delete[@]}"

    # Move the files to be replaced back to the home directory
    move_files_to_home "${files_to_replace[@]/#/$dest_directory/}"

    echo "Files have been rolled back to the home directory without the date appended."
else
    echo "Rollback cancelled. No changes were made."
fi
