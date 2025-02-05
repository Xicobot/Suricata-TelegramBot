# Suricata-Telegram

## System Information
- **Operating System:** Ubuntu 24.04 LTS
- **Suricata Version:** Latest stable release

## Installation Steps

### 1. Update System Packages
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Install Required Dependencies
```bash
sudo apt install -y software-properties-common
```

### 3. Add the Suricata PPA Repository
```bash
sudo add-apt-repository -y ppa:oisf/suricata-stable
sudo apt update
```

### 4. Install Suricata
```bash
sudo apt install -y suricata
```

### 5. Verify Installation
```bash
suricata --version
```

### 6. Start and Enable Suricata Service
```bash
sudo systemctl enable --now suricata
```

### 7. Check Suricata Status
```bash
sudo systemctl status suricata
```

### 8. Test Suricata
To test if Suricata is running properly, use the following command:
```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```

## Conclusion
You have successfully installed Suricata on Ubuntu 24.04 LTS. You can now configure and customize it according to your network security needs.
