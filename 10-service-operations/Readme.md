## Service in Linux?

A service is

- Runs in the background,
- Starts automatically at boot (optional),
- Is managed by the init system (systemd) &
- Usually does not interact directly with users

## systemd?

systemd is the `init` system and `service` manager in modern Linux distributions.

Main responsibilities:

- Starts the system during boot
- Manages services (daemons)
- Handles process supervision
- Manages dependencies
- Collects logs (via journald)
- Controls system state (targets)

## systemctl?

systemctl is the command-line tool used to control and query systemd.

👉 systemd = engine
👉 systemctl = remote control

## systemd Boot Process
`BIOS/UEFI` > `Bootloader (GRUB)` > `Kernel` > `systemd (PID 1)` > `Targets` → `Services`

## systemd manages units

| Unit Type | Extension  | Purpose            |
| --------- | ---------- | ------------------ |
| Service   | `.service` | Background service |
| Target    | `.target`  | System state       |
| Timer     | `.timer`   | Scheduled tasks    |
| Mount     | `.mount`   | Mount points       |
| Socket    | `.socket`  | Socket activation  |

## List Services

```bash
systemctl list-units --type=service
systemctl list-unit-files --type=service
```

## systemd Service File Structure

```bash
[Unit]
Description=My App
After=network.target

[Service]
ExecStart=/usr/bin/myapp
Restart=always
User=appuser

[Install]
WantedBy=multi-user.target
```

## NGINX in systemd terms?

1. `NGINX` → the daemon/process (`nginx`)
2. `nginx.service` → the systemd service unit that manages it

### nginx.service

```bash
[Unit]
Description=A high performance web server and a reverse proxy server
After=network.target

[Service]
Type=forking
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/usr/sbin/nginx -s quit
PIDFile=/run/nginx.pid

[Install]
WantedBy=multi-user.target
```
