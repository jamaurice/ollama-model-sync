# Ollama Model Sync

📦 Automatically install and sync all Ollama models into a 5TB volume on your system.

## Features

- Installs Ollama if missing
- Pulls every available model from Ollama.com
- Deletes incomplete downloads before retrying
- Runs daily via cron
- Logs all output to `/mnt/models/ollama_install.log`

## Setup

```bash
sudo cp ollama-model-sync.sh /usr/local/bin/ollama-model-sync.sh
sudo chmod +x /usr/local/bin/ollama-model-sync.sh
