#!/bin/bash

# Function to display the menu and run the selected script
run_menu() {
    # Find all .sh files in the current directory
    sh_files=$(find . -maxdepth 1 -name "*.sh" -type f -perm +111 | sort)

    # Check if any .sh files were found
    if [[ -z "$sh_files" ]]; then
        echo "No executable .sh files found in the current directory."
        exit 1
    fi

    # Create an array to store the file names
    file_menu=()
    i=1
    while IFS= read -r file; do
        file_name=$(basename "$file")
        file_menu+=("$file")
        echo "$i) $file_name"
        ((i++))
    done <<< "$sh_files"

    # Prompt the user to select a script to run
    read -p "Enter the number of the script to run (or 'q' to quit): " choice

    # Check if the choice is valid
    if [[ "$choice" == "q" ]]; then
        exit 0
    fi

    if [[ ! ${file_menu[$((choice - 1))]} ]]; then
        echo "Invalid choice."
        return 1
    fi

    # Run the selected script
    echo "Running ${file_menu[$((choice - 1))]}"
    bash "${file_menu[$((choice - 1))]}"
    return 0
}

# Keep running the menu until the user quits
while true; do
    if ! run_menu; then
        echo "Going back to menu..."
    fi
done