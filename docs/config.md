
## Configuration
Suricata configuration file is located at:
```bash
/etc/suricata/suricata.yaml
```
Here's an example of my case.
![image](https://github.com/user-attachments/assets/c845dff4-b5dc-4046-9611-74c89c25efa1)

This is the basic configuration, the purpose of this is to make suricata catch the ethernet packets.

You can customize rules and settings based on your security needs in `/var/lib/suricata/rules/local.rules`, you can check out my rules [here!](/docs.rules.txt)

## Logs & Monitoring
Suricata logs network activity in:
```bash
/var/log/suricata/
```

## To monitor logs in real-time:
```bash
tail -f /var/log/suricata/fast.log
```



## More Information
- [Official Website](https://suricata.io/)
- [Suricata Documentation](https://suricata.readthedocs.io/en/latest/)
- [GitHub Repository](https://github.com/OISF/suricata)
