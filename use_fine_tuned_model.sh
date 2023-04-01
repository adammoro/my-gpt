#!/bin/bash

# Ask to add OpenAI API key
if [ -z "$OPENAI_API_KEY" ]; then
  echo -e "
\e[0;31mWarning:\e[0m OpenAI API key environment variable is not set.
To set the API key, run the following command, 
replacing <YOUR_API_KEY> with your actual API key:
\e[0;34mexport OPENAI_API_KEY=<YOUR_API_KEY>\e[0m

Add the above command to your .bashrc or .bash_profile file 
to not have to enter it again next time.
"
  exit 1
fi

# Check if OpenAI module is installed
if ! pip list 2>/dev/null | grep -w openai &>/dev/null; then
  echo -e "
###
\e[0;31mWarning:\e[0m OpenAI module is not installed."
  echo -e "Please install with: \e[0;34mpip install openai\e[0m
###
"
fi

# Check if pandas module is installed
if ! pip list 2>/dev/null | grep -w pandas &>/dev/null; then
  echo -e "
###
\e[0;31mWarning:\e[0m pandas module is not installed."
  echo -e "Please install with: \e[0;34mpip install pandas\e[0m
###
"
fi

# Check if both modules are installed before proceeding
if ! pip list 2>/dev/null | grep -w openai &>/dev/null || ! pip list 2>/dev/null | grep -w pandas &>/dev/null; then
  echo -e "\e[1;33mPlease ensure above module(s) are 
installed and then re-run the script.\e[0m

You can easily install the modules 
with the following command:
\e[0;34mpip install -r requirements.txt\e[0m
  "
  exit 1
fi

# List fine-tuned models
models=$(openai api fine_tunes.list | grep 'fine_tuned_model' | awk '{print $2}')

# Static list of models (add your models here, separated by spaces)
static_models=("text-davinci-003" "text-davinci-002")

echo "Available models:"
i=1
declare -A model_map
for model in $static_models $models; do
  cleaned_model=$(echo $model | tr -d '",')
  echo "$i. $cleaned_model"
  model_map[$i]=$cleaned_model
  ((i++))
done

# Select model
read -p "Enter the number of the model you want to use: " model_number

selected_model=${model_map[$model_number]}
echo "You selected: $selected_model"

# Prompt loop
while true; do
  read -p "Enter your prompt (Leave empty and press enter to exit): " prompt
  
  if [[ -z "$prompt" ]]; then
    echo "Goodbye!"
    break
  fi
  
  response=$(openai api completions.create -m $selected_model -p "$prompt" -M 250)

  echo "Response:"
  echo -e "$response"
done
