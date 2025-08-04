#### Firewall
Configuring a firewall on Ubuntu is typically done using a utility called ufw (Uncomplicated Firewall).

Install & enable
```bash
ufw --version
sudo apt update
sudo apt install ufw
sudo ufw enable
```

Usable command in ubuntu
```bash
sudo ufw allow ssh
sudo ufw deny ssh
sudo nano /etc/ssh/sshd_config
control + x # save & exit
sudo ufw allow 2020/tcp # allow rule
sudo ufw delete allow 22/tcp # deny rule
sudo systemctl status ssh
sudo systemctl restart ssh
ufw enable
sudo ufw disable
sudo ufw reload
sudo apt update
sudo ufw status verbose
ss -an | grep 2020 # To verify that SSH daemon is listening on the new port 2020, type:
sudo systemctl disable --now ssh # if we need to disable SSH service
sudo systemctl enable --now ssh
```