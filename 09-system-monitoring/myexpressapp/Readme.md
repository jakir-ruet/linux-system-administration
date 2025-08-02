## Complete Node.js Deployment & systemd Setup on Ubuntu Server

### Prepare Ubuntu & Install Node.js
```bash
sudo apt update && sudo apt upgrade -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v
nvm current
npm -v
```

### Make a Node.js App

```bash
mkdir myexpressapp
cd myexpressapp
npm init -y
npm install express
node app.js
```

### Give ownership and test manually

```bash
sudo chown -R jakir:jakir /home/jakir/myexpressapp
node app.js
```

### Create systemd Service File

```bash
sudo vi /etc/systemd/system/myexpressapp.service
```

```bash
[Unit]
Description=Node.js App run by jakir
After=network.target

[Service]
Environment=PORT=3000
Type=simple
User=jakir
Group=jakir
WorkingDirectory=/home/jakir/myexpressapp
ExecStart=/usr/bin/node /home/jakir/myexpressapp/app.js
Restart=on-failure
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

### Enable and Start the Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable myexpressapp
sudo systemctl start myexpressapp
```

### Check status and logs

```bash
sudo systemctl status myexpressapp
sudo journalctl -u myexpressapp -f
```

### Setup Nginx Reverse Proxy (Optional)

```bash
sudo vi /etc/nginx/sites-available/myexpressapp
```

```json
server {
    listen 80;
    server_name your_server_ip_or_domain;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### Enable site and reload Nginx

```bash
sudo ln -s /etc/nginx/sites-available/myexpressapp /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

