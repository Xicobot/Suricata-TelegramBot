
## Configuration
Suricata configuration file is located at:
```bash
/etc/suricata/suricata.yaml
```
Here's an example of my case.
![image](https://github.com/user-attachments/assets/c845dff4-b5dc-4046-9611-74c89c25efa1)

This is the basic configuration, the purpose of this is to make suricata catch the ethernet packets.

## Rules
You can customize rules and settings based on your security needs in `/var/lib/suricata/rules/local.rules`, you can check out my rules [here!](/docs.rules.txt)
to have permanently updated the suricata rules and checkout the sites, you can use this command:
```bash
sudo suricata-update update-sources
sudo suricata-update list-sources
```

## Logs & Monitoring
Suricata logs network activity in:
```bash
/var/log/suricata/
```

## To monitor logs in real-time:
```bash
tail -f /var/log/suricata/fast.log
```

## Disabling or Removing a Specific Source in Suricata

If you need to **disable** or **completely remove** a specific rule source in Suricata, follow these steps:

## **Disable a Specific Source**
To disable a specific rule source, such as `et/pro`, use the following command:
```bash
suricata-update disable-source et/pro
```
This will prevent Suricata from using rules from `et/pro`, but they will remain installed.

## **Remove a Specific Source Completely**
If you want to **remove** the source entirely, use this command:
```bash
suricata-update remove-source et/pro
```
This will **delete** the `et/pro` source from Suricata.

## **Apply the Changes**
After disabling or removing a source, update the rules to apply the changes:
```bash
suricata-update
```
Then, restart Suricata to load the new configuration:
```bash
sudo systemctl restart suricata
```

Now, Suricata will no longer use the `et/pro` rule source. 🚀



## More Information
- [Official Website](https://suricata.io/)
- [Suricata Documentation](https://suricata.readthedocs.io/en/latest/)
- [GitHub Repository](https://github.com/OISF/suricata)
