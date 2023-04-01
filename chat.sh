#!/bin/bash

# Link to both scripts
fine_tune_script="$(dirname "$0")/fine_tune.sh"
use_model_script="$(dirname "$0")/use_fine_tuned_model.sh"

# Make sure they're executable
chmod +x "$fine_tune_script"
chmod +x "$use_model_script"

# Choose action
echo "What do you want to do?"
echo "1. Create a new fine-tuned model"
echo "2. Use an existing fine-tuned (or default) model"
read -p "Enter your choice (1 or 2): " choice

if [[ $choice == "1" ]]; then
  # Run the fine_tune script
  source "$fine_tune_script"
elif [[ $choice == "2" ]]; then
  # Run the use_fine_tuned_model script
  source "$use_model_script"
else
  echo "Invalid choice. Please enter 1 or 2."
  exit 1
fi
