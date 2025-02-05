# Integrating Suricata with Telegram

## 1. Create a Bot in Telegram

### Steps:
1. Open Telegram and search for **BotFather**.
2. Type `/newbot` and follow the instructions.
3. Save the **Access Token**.

### Get the Chat ID
1. Send a message to the bot.
2. Use the Telegram API:
   ```bash
   curl "https://api.telegram.org/bot/getUpdates"
   ```
3. Look for the `"chat":{"id":...}` field in the response.
Here's an example:
![image](https://github.com/user-attachments/assets/dffdd02e-1304-4fb9-9cea-c1d6ad32f29a)

## 2. Configure Suricata to Generate Alerts

Edit the configuration file `/etc/suricata/suricata.yaml` and enable JSON logging (is enabled from default):

```yaml
outputs:
  - eve-log:
      enabled: yes
      filetype: json
      filename: /var/log/suricata/eve.json
```
![image](https://github.com/user-attachments/assets/6dd52de9-bb89-44c5-928c-450d536f9b13)

Restart Suricata:
```bash
sudo systemctl restart suricata
```

## 3. Configure the command:

` curl -X POST "https://api.telegram.org/bot<TOKEN_BOT>/sendMessage"      -d "chat_id=<CHAT_BOT>"      -d "text=$(tail -n 10 /var/log/suricata/fast.log | awk '{print $1, $2, $NF-2, "Nmap SYN", $NF}')" `

example:
![image](https://github.com/user-attachments/assets/967952f3-9e07-416d-b4a9-89eb9f8d1e07)

## Done!
Now, Suricata will send alerts to Telegram when you execute it, if you want it.
