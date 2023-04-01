# MyGPT 
### OpenAI Fine-tuned Model Management & Usage

This repository contains shell scripts to help you fine-tune and manage OpenAI models like `davinci` or `ada` on your local Linux machine. By providing the training data, you can create smarter models on any given subject. The scripts will guide you through the process of preparing training data, creating fine-tuned models, and using them to generate completions.

## Requirements

- A Linux system (tested on Ubuntu 18.04)
- Python and pip installed
- An OpenAI API key with fine-tuning enabled

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/adammoro/my-gpt.git
   cd my-gpt
   ```
   
2. Install the required Python modules with:
   
   ```bash
   pip install -r requirements.txt
   ```
   
3. Give the shell scripts execute permissions:

   ```bash
   chmod +x fine_tune.sh
   chmod +x use_fine_tuned_model.sh
   chmod +x chat.sh
   ```

## Scripts

There are three main shell scripts provided in this repository. You'll only need to use one of them but here are the details about each:

1. `fine_tune.sh`: Fine-tune a new model by providing training data in CSV format.
2. `use_fine_tuned_model.sh`: Use existing fine-tuned models to generate completions with prompts.
3. `chat.sh`: This is the script that ties the above two scripts together and allows you to either create a new fine-tuned model or use an existing model.

## Usage

Open your terminal and navigate to the `my-gpt` folder. Run the script by entering `./chat.sh` into the terminal. From there you can let it guide you through the process of creating a new fine-tuned model or using an existing one.

### Option 1: Create a Fine Tuned Model

If you haven't created any fine-tuned models yet you'll want to do that first by selecting Option 1. However, before you do that you'll need a CSV file with the training data you want to fine tune the model with. The CSV should have two columns titled: `prompt` and `completion` and should have several hundred rows of data at least. 

Once you have the CSV, run the script and provide it with the path to the CSV on your machine. The script will then send the CSV to OpenAI where it'll be converted to JSONL and used to create the new model. At that point you're just waiting for the fine-tuning process to complete. Once it does you'll be able to use it with Option 2. You can also use it in the API Playground now!

### Option 2: Use a Fine Tuned Model

If you select Option 2 you'll be presented with the list of available models you can use for your chat session. Select the model you want to use and start asking your questions. The responses will be displayed in the terminal.

Note: The default `max_tokens` value is set to 250. You can modify that value on Line 80 of `use_fine_tune_model.sh`:

```bash
response=$(openai api completions.create -m $selected_model -p "$prompt" -M <max_tokens>)
```


## Support

If you encounter any issues or need assistance, please open an issue on the repository, and I'll be happy to help.

The "Stream interrupted (client disconnected)" message is normal and does not indicate an error or problem with the fine tuning process. If you want to resume the stream enter the command displayed. Otherwise just check back in a while to see if it's ready.

Please note that this code is unofficial and not directly provided or supported by OpenAI. For official guides and documentation, refer to the [OpenAI platform documentation](https://platform.openai.com/docs/guides/fine-tuning).


## Disclaimer

This code is provided as-is, with no warranties or guarantees of any kind. The author is not responsible for any damages or losses that may occur as a result of using this code. Use at your own risk. Please be aware that this code may contain bugs or other issues that could cause harm to your computer or other devices. The user assumes all risk associated with using this code.



