#!/bin/bash

# Check if OpenAI module is installed
if ! pip list 2>/dev/null | grep -w openai &>/dev/null; then
  echo -e "
###
\e[0;31mWarning:\e[0m OpenAI module is not installed."
  echo -e "Please install with: \e[0;34mpip install openai\e[0m
###
"
else
  echo -e "\e[0;32mOpenAI module is installed. Great!\e[0m"
fi

# Check if pandas module is installed
if ! pip list 2>/dev/null | grep -w pandas &>/dev/null; then
  echo -e "
###
\e[0;31mWarning:\e[0m pandas module is not installed."
  echo -e "Please install with: \e[0;34mpip install pandas\e[0m
###
"
else
  echo -e "\e[0;32mpandas module is installed. Great!\e[0m"
fi

# Check if both modules are installed before proceeding
if ! pip list 2>/dev/null | grep -w openai &>/dev/null || ! pip list 2>/dev/null | grep -w pandas &>/dev/null; then
  echo -e "\e[1;33mPlease ensure above module(s) are 
installed and then re-run the script.\e[0m
  "
  exit 1
fi

# Ask to add OpenAI API key
read -p "Do you need to add your OpenAI API key to your environment? (Y/n): " choice
if [[ $choice == "Y" || $choice == "y" || $choice == "" ]]; then
  read -sp "Please enter your OpenAI API key: " api_key
  echo "export OPENAI_API_KEY=$api_key" >> ~/.bashrc
  source ~/.bashrc
  echo
  echo "API key added to the .bashrc file and environment."
else
  echo "Skipping API key addition."
fi

# Ask for input CSV and model
read -p "Please enter the path of your CSV file: " csv_file
read -p "Please enter the model to fine-tune (davinci, ada, babbage, or curie): " base_model

# Convert CSV to JSONL
prepared_data="${csv_file%.csv}_prepared.jsonl"

echo "Follow the instructions and provide required input:"
openai tools fine_tunes.prepare_data -f "$csv_file"
echo "When you're done, press any key to continue..."
read -n 1 -s
echo

# Send JSONL to OpenAI
openai api fine_tunes.create -t "$prepared_data" -m "$base_model"

echo "The training data has been sent to OpenAI. This process can take up to several hours."
echo "To monitor progress, run the following command: "
echo "openai api fine_tunes.follow -i <YOUR_FINE_TUNE_JOB_ID>"

