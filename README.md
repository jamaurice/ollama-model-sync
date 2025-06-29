# 🧠 Ollama Model Sync

A daily sync script that automatically installs [Ollama](https://ollama.com) and downloads **all available models** into a dedicated storage mount (e.g., `/mnt/models`). Ideal for high-capacity servers with 5TB+ disks.

---

## 🚀 Features

- ✅ Installs Ollama automatically (if not already installed)
- ✅ Fetches the complete model list from https://ollama.com/library
- ✅ Deletes incomplete or partial downloads before retrying
- ✅ Logs all output to `/mnt/models/ollama_install.log`
- ✅ Designed for systems with large storage volumes (5TB+)
- ✅ Cron-ready for automated daily execution

---

## 📦 Requirements

- Ubuntu / Debian Linux
- 5TB+ mounted storage volume (e.g., `/mnt/models`)
- Internet connection
- `curl`, `script`, and basic Linux utilities installed

---

## 🛠 Setup

### 1. Mount a 5TB LVM Volume

If not done already:

```bash
sudo lvcreate -L 5000G -n ollama-vm ubuntu-vg
sudo mkfs.ext4 /dev/ubuntu-vg/ollama-vm
sudo mkdir -p /mnt/models
sudo mount /dev/ubuntu-vg/ollama-vm /mnt/models
echo "/dev/ubuntu-vg/ollama-vm /mnt/models ext4 defaults 0 2" | sudo tee -a /etc/fstab


```
sudo cp ollama-model-sync.sh /usr/local/bin/ollama-model-sync.sh
sudo chmod +x /usr/local/bin/ollama-model-sync.sh

### 2. Clone the Repository

```bash
git clone https://github.com/jamaurice/ollama-model-sync.git
cd ollama-model-sync
```

### 3. Install the Script

```bash
sudo cp ollama-model-sync.sh /usr/local/bin/ollama-model-sync.sh
sudo chmod +x /usr/local/bin/ollama-model-sync.sh
```

### 4. Test It Manually

Run the sync script and watch it pull all available models:

```bash
/usr/local/bin/ollama-model-sync.sh
```

All logs will be saved to:

```
/mnt/models/ollama_install.log
```

### 5. Automate with Cron (Daily Sync)

To schedule the script to run **daily at 2:30 AM**, use the following steps:

1. Open the crontab editor:

```bash
crontab -e
```

2. Add this line at the bottom:

```cron
30 2 * * * /usr/local/bin/ollama-model-sync.sh >> /mnt/models/cron_ollama.log 2>&1
```

This will ensure the script:

* Runs every night at 2:30 AM
* Logs cron output to `/mnt/models/cron_ollama.log`

## 📁 Output Directory Structure

```
/mnt/models/
├── blobs/               # Model binary chunks
├── models/              # Installed models
├── manifests/           # Model metadata
├── ollama_install.log   # Manual + cron script logs
├── cron_ollama.log      # Cron job output (if enabled)
```

## 📄 License

MIT License © 2025 Jamaurice Holt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction...

## 🌐 Resources

* [Ollama Official Site](https://ollama.com)
* [Model Library](https://ollama.com/library)
* [Ollama GitHub](https://github.com/ollama/ollama)

```
---

✅ Copy this entire file as your `README.md`  
✅ It includes everything GitHub expects — clean, professional, and functional.



