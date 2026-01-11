### Firewall
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

### Server–Client Remote Connectivity Using SSH

- Server Machine: `192.168.68.130`
- Client Machine: `192.168.68.135`

#### On both machine

```bash
udo apt install -y openssh-server openssh-client
sudo systemctl enable ssh
sudo systemctl start ssh
```

#### Way One: Automated using ssh-copy-id - `Recommended`

##### Step-01: On Client Machine `192.168.68.135`

```bash
# Non-root user
ssh-keygen
cd ~/.ssh/ # For checking
sudo chmod 700 ~/.ssh/
sudo chmod 600 ~/.ssh/id_ed25519
sudo chmod 644 ~/.ssh/id_ed25519.pub
```

##### Step-02: Copy `Authorized_Keys` key to Server Machine `192.168.68.130`

```bash
# On Client Machine
sudo ssh-copy-id -i ~/.ssh/id_ed25519.pub jakir@192.168.68.130
# authorized_keys file on Server Machine
cat authorized_keys
```

##### Step-03: Test SSH (from client)

```bash
ssh jakir@192.168.68.130
```

> You should log in without a password.

#### Way Two: Manual Method `Copy–Paste Public Key`

##### Step-01: On Client Machine `192.168.68.135`

```bash
# Generate key (Recommended Modern Algorithm)
ssh-keygen -t ed25519 -C "jakir@192.168.68.135"
```

```bash
sudo chmod 700 ~/.ssh
sudo chmod 600 ~/.ssh/id_ed25519
sudo chmod 644 ~/.ssh/id_ed25519.pub
```

```bash
cat ~/.ssh/id_ed25519.pub # Copy the key
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDIA7n4RvpTmCZKYW6ekUVioTuLdjV4mEBV6ym2hSV/z jakir@192.168.68.135
```

##### Step-02: On Server Machine `192.168.68.132`

```bash
ssh jakir@192.168.68.132
sudo mkdir -p ~/.ssh
sudo chmod 700 ~/.ssh
sudo vi ~/.ssh/authorized_keys # Paste here
chmod 600 ~/.ssh/authorized_keys
```

##### Step-03: Test SSH (from client)

```bash
ssh jakir@192.168.68.130
```

> You should log in without a password.
