## Question

The production support team of `xFusionCorp Industries` is working on developing some bash scripts to automate different day to day tasks. One is to create a bash script for taking websites backup. They have a static website running on `App Server 2` in `Stratos Datacenter`, and they need to create a bash script named `blog_backup.sh` which should accomplish the following tasks. (Also remember to place the script under `/scripts` directory on `App Server 2`).

1. Create a zip archive named `xfusioncorp_blog.zip` of `/var/www/html/blog` directory.
2. Save the archive in `/backup/` on `App Server 2`. This is a temporary storage, as backups from this location will be clean on weekly basis. Therefore, we also need to save this backup archive on `Nautilus Backup Server`.
3. Copy the created archive to `Nautilus Backup Server` server in `/backup/` location.
4. Please make sure script won't ask for password while copying the archive file. Additionally, the respective server user (for example, tony in case of `App Server 2`) must be able to run it.


### Step by Step Solution

#### On App Server 2

##### Create file, directories, give permission and ownership etc.

```bash
ssh steve@stapp02 # here app server 2 password needed
mkdir -p /scripts # if not available
sudo sudo vi /scripts/blog_backup.sh
sudo chown steve:steve /scripts/ # give ownership to steve
sudo chown steve:steve /scripts/blog_backup.sh # give ownership to steve
sudo chmod +x /scripts/blog_backup.sh # give execute permission & just copy paste
sudo mkdir -p /var/www/html/blog # if not available
sudo chown steve:steve /var/www/html/blog # give ownership to steve
sudo chmod -R 755 /var/www/html/blog # give permission to steve
```

##### Make connection to backup server with app server 2

```bash
ssh-keygen -t rsa -b 2048
ssh-copy-id clint@stbkp01
```

#### On Backup Server

```bash
cd /
ls -la
sudo chown clint:clint /backup/ # here backup server password needed
```

#### Again, on App Server 2

##### Execute the script

```bash
sudo /scripts/blog_backup.sh
```

##### We may run CronJob (If needed)

```bash
crontab -e
0 2 * * * /scripts/blog_backup.sh
sudo systemctl status cron
sudo systemctl start cron
grep CRON /var/log/syslog
```
