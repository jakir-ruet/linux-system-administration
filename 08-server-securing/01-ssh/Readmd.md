## Question
You are tasked with securing an SSH server so that:

1. Only the user `john` can access the SSH server.
2. Access is allowed `only from IP address` 192.168.1.113.
3. SSH key authentication must be enforced (no password login).
4. Firewall must block all SSH access `except` from that IP.
5. The client should be able to connect using a convenient shortcut via` ~/.ssh/config`.

Explain and implement the complete configuration on both the server and the client side.

### Scenario

| Item                 | Value               |
| -------------------- | ------------------- |
| Server IP            | `192.168.1.112`      |
| Allowed Client IP    | `192.168.1.113`     |
| SSH User             | `john`               |
| Private Key (Client) | `~/.ssh/id_rsa_john` |
| SSH Port             | `22`                |

### Server-Side Configuration

#### **Step 1**: Create and Prepare User

```bash
sudo adduser john
sudo mkdir -p /home/john/.ssh
sudo vim /home/john/.ssh/authorized_keys
```

```bash
sudo chown -R john:john /home/john/.ssh
sudo chmod 700 /home/john/.ssh
sudo chmod 600 /home/john/.ssh/authorized_keys
```

**NB**: Paste in `john`’s public key from the client (usually from `id_rsa_john.pub`).

#### **Step 2**: Secure SSH Daemon Configuration

```bash
sudo vim /etc/ssh/sshd_config
```

- Add or ensure the following lines exist `OR`

```bash
PasswordAuthentication no
PermitRootLogin no
AllowUsers john@192.168.1.113
```

- Use more flexible matching (`/etc/ssh/sshd_config`)

```bash
PermitRootLogin no
PasswordAuthentication yes  # Default for others
AllowUsers                  # Optional global line (allow others too)

# Match block overrides for specific IP
Match Address 192.168.1.113
    AllowUsers john
    PasswordAuthentication no
```

```bash
sudo systemctl restart sshd
```

#### **Step 3**: Configure UFW Firewall

```bash
sudo ufw allow from 192.168.1.113 to any port 22
sudo ufw deny 22
sudo ufw enable
sudo ufw reload
```

```bash
sudo ufw status numbered
```

### Client-Side Configuration

#### **Step 1**: Store Private Key

```bash
chmod 600 ~/.ssh/id_rsa_john
```

#### **Step 2**: Add SSH Config Entry

```bash
sudo vim ~/.ssh/config
```

```bash
Host secure-server
    HostName 192.168.1.112
    User john
    IdentityFile ~/.ssh/id_rsa_john
    Port 22
```

```bash
ssh secure-server
```

#### From other IPs, access should be blocked:

```bash
ssh john@192.168.1.112
```

- You should see

```bash
Permission denied (publickey).
```
