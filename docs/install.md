## Installation Steps

### 1. Update System Packages
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Install Required Dependencies
```bash
sudo apt install -y software-properties-common
```

### 3. Install Suricata
```bash
sudo apt install -y suricata
```

### 4. Verify Installation
```bash
suricata --version
```

### 5. Start and Enable Suricata Service
```bash
sudo systemctl enable --now suricata
```

### 6. Check Suricata Status
```bash
sudo systemctl status suricata
```

### 7. Test Suricata
To test if Suricata is running properly, use the following command:
```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```
You can use my script to automatize the installation and configuration [here!](script.sh)
