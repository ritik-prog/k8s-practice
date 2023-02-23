#!/bin/bash

# Delete the .env file if it exists
if [ -f ".env" ]; then
  rm .env
  echo "File .env deleted."
fi

# Check if .env file exists, if not, create it
if [ ! -f ".env" ]; then
  touch .env
  echo "File .env created."
fi

# Function to add a key-value pair to the .env file
add_to_env() {
  local key=$1
  local value=$2

  # Check if key already exists in the .env file, if yes, update the value
  if grep -q "^$key=" .env; then
    if [ "$(uname)" == "Darwin" ]; then
      # On macOS
      sed -i '' "s/^$key=.*/$key=$value/" .env
    else
      # On Linux
      sed -i "s/^$key=.*/$key=$value/" .env
    fi
  else
    echo "$key=$value" >> .env
  fi
}

# Function to remove a key-value pair from the .env file
remove_from_env() {
  local key=$1

  # Check if key exists in the .env file, if yes, remove the line
  if grep -q "^$key=" .env; then
    if [ "$(uname)" == "Darwin" ]; then
      # On macOS
      sed -i '' "/^$key=.*/d" .env
    else
      # On Linux
      sed -i "/^$key=.*/d" .env
    fi
  else
    echo "Key not found in .env file."
  fi
}

# Function to display all key-value pairs in the .env file
display_env() {
  cat .env
}

# Add example key-value pair to the .env file
add_to_env "EXAMPLE_KEY" "EXAMPLE_VALUE"

# Display all key-value pairs in the .env file
display_env

# Remove example key-value pair from the .env file
remove_from_env "EXAMPLE_KEY"

# Display all key-value pairs in the .env file
display_env
