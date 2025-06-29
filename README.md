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
