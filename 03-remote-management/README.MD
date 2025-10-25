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

#### Server Clinet's remote connectivity

##### Way One (Recommended: Automated using ssh-copy-id)

- On Server Machine

```bash
ssh-keygen
```

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub jakir@192.168.68.118
```

```bash
ssh jakir@192.168.68.118
```

##### Way Two (Manual: Copy-Paste Public Key)

- On Server Machine

```bash
ssh-keygen -t ed25519 -C "root@ubuntu-master"
```

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

```bash
cat ~/.ssh/id_ed25519.pub # copy all content with `root@ubuntu-master`
sudo vi ~/.ssh/authorized_keys # and paste here
```

```bash
ssh jakir@192.168.68.118
```
