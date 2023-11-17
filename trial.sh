#!/bin/bash

# Check if the correct number of command-line arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <username> <password> <directory>"
    exit 1
fi

# Extract command-line arguments
username=$1
password=$2
directory=$3

# Validate username and password
if [ "$username" != "PES2UG22CS043" ] || [ "$password" != "$(echo "$username" | rev)" ]; then
    echo "Invalid username or password"
    exit 254
fi

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory not found: $directory"
    exit 1
fi

# Count the number of PNg files
count=0
for file in "$directory"/*.PNg; do
    if [ -f "$file" ]; then
        ((count++))
    fi
done

# Display the number of matching files
echo "Username and password are correct"
echo "The no of matching files are $count"

# Rename PNg files to png
for file in "$directory"/*.PNg; do
    if [ -f "$file" ]; then
        mv "$file" "$(dirname "$file")/$(basename "$file" .PNg).png"
        echo "Changed $file to $(dirname "$file")/$(basename "$file" .PNg).png"
    fi
done

# Exit with success status
exit 0
