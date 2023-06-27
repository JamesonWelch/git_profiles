#!/bin/bash

search_string=".gitconfig"
dest_directory="$HOME/.gitconfig_versions"
configs_directory="configs"

# Create the destination directory if it doesn't exist
mkdir -p "$dest_directory"

# Get the current date in the format: YYYY-MM-DD
current_date=$(date +%Y-%m-%d)

# Find files in the home directory containing the search string
files=$(find "$HOME" -maxdepth 1 -type f -name "*$search_string*")


echo "Moving files: $files"

# Initialize a counter
counter=0

for file in $files; do
    # Check if the file name contains the search string
    if [[ $file == *"$search_string"* ]]; then
        # Extract the base name of the file
        base_name=$(basename "$file")

        # Append the current date to the base name
        new_file_name="${base_name%.*}_$current_date.${base_name##*.}"

        # Copy the file to the destination directory with the new name
        cp "$file" "$dest_directory/$new_file_name"
        ((counter++))
    fi
done

# Counter doesn't include the main .gitconfig file
((counter--))

echo "Files containing '$search_string' have been copied " \
    "to $dest_directory with the date appended."
echo "Number of profile configuration files copied: $counter"

# Copy files from the configs directory to the home directory
cd configs
cp -R . "$HOME"
echo "Git configuration copy complete"