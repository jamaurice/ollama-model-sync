#!/bin/bash

set -e
LOGFILE="/mnt/models/ollama_install.log"
MODEL_LIST_URL="https://ollama.com/library"
export OLLAMA_MODELS_DIR="/mnt/models"

# Create log file directory if missing
mkdir -p "$OLLAMA_MODELS_DIR"

log() {
    echo "$(date '+%F %T') - $1" | tee -a "$LOGFILE"
}

log "🚀 Starting Ollama installation and model sync..."

# 1. Install Ollama if missing
if ! command -v ollama &>/dev/null; then
    log "📦 Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
    log "✅ Ollama installed."
else
    log "✅ Ollama already installed."
fi

# 2. Ensure Ollama service is running
ollama serve &>/dev/null &
sleep 5

# 3. Fetch model list from Ollama Library
log "🌐 Fetching model list..."
MODEL_NAMES=$(curl -s "$MODEL_LIST_URL" | grep -oP '(?<=href="/library/)[^"]+' | sort -u)

# 4. Download models with cleanup for partials
for model in $MODEL_NAMES; do
    if ollama list | grep -q "^$model"; then
        log "🔁 Model '$model' already exists — skipping."
    else
        log "🧹 Cleaning up any partial data for $model..."
        rm -rf "$OLLAMA_MODELS_DIR"/blobs/*"$model"* 2>/dev/null || true
        rm -rf "$OLLAMA_MODELS_DIR"/manifests/*"$model"* 2>/dev/null || true
        rm -rf "$OLLAMA_MODELS_DIR"/models/*"$model"* 2>/dev/null || true

        log "⬇️ Downloading model: $model"
        script -q -c "ollama pull $model" /dev/null >>"$LOGFILE" 2>&1 \
            && log "✅ Model '$model' downloaded." \
            || log "⚠️ Failed to pull '$model'."
    fi
done

log "✅ All models processed."
log "📊 Disk usage:"
df -h "$OLLAMA_MODELS_DIR" | tee -a "$LOGFILE"
