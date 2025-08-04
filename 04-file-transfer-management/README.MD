#### File transfer
File transferring among Ubuntu, Window & MacOS can be done few way. Here we are going to discuss some popular methods. As per our need we will discussed `scp` & `ssh`
1. Via Secure Copy (scp)

```bash
cp sourceDirectory destinationDirectory
cp oldDirectory/oldFile newDirectory/newFile
scp -p DestinationPcSSHPort FileInHost(hello.txt) DestinationPcUser@DestinationPcIP:/home/DestinationPcUser
scp -p 22 hello.txt nodetwo@172.16.102.133:/home/nodetwo
scp -p 22 nodetwo@172.16.102.133:/home/nodetwo/hello.txt /home/ubuntuserver
```
2. Via FTP using SSH
   - FileZilla, 
   - WinSCP
3. Via Samba Server
4. Via Shared Network Folders

Global Regular Expression (GREP)
```bash
cat /etc/ssh/ssh_config | wc -l  # total line
cat /etc/ssh/ssh_config | grep Port  # check port no
grep Port /etc/ssh/ssh_config # check port no
grep lorem head.txt # search text named lorem in head.txt file
grep -v lorem head.txt # search text except named lorem in head.txt file
grep -n lorem head.txt # search text named lorem with line no in head.txt file
grep -i lorem head.txt # search text named lorem with not case sensitive in head.txt file
```

Find
```bash
find -name info.txt  # in present location
find -type f  # search by file type
find -type d # search by directory
find -size -4k # search by size of file
find -name *.txt # in present location find by file extension
find -perm 644 # search by given permission of files
find /home -user jakir # search by owner
```