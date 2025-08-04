### User & Group Access Management

Check user list 
```bash
cat /etc/passwd
```

Add user - `adduser/useradd(Debian)`
```bash
adduser jasim # add a user
id jasim # check user
```

Set password - `passwd`
```bash
passwd jasim # add a user
id jasim # check user's id
usermod -u 5000 jasim # 5000 is new id
```
To check how many groups in system & how many groups a user is a part 
```bash
cat /etc/group
groups jasim
```

Delete user - `userdel/deluser(Debian)`
```bash
deluser jasim
userdel -r jasim # delete from home directory
```

The user **account was deleted**, but the home directory `/home/UserName` was not removed.

Check if Any Files Still Belong to the Deleted User
```bash
ls -ld /home/jasim
ls -l /home/jasim
```
Check for Stale Entries in `/etc/group` and `/etc/shadow`
```bash
grep jasim /etc/group # check group
grep jasim /etc/shadow # check password
```
If you find stale entries, you can remove them manually using `Be careful when editing these system files`
```bash
sudo vi /etc/group # remove, save & exit
sudo vi /etc/shadow # remove, but cannot save, force save `:wq!`
rm -rf jasim # remove user manually
```
Remove the Home Directory `If Safe` - If you are sure the user `jasim` is no longer needed:
```bash
sudo rm -rf /home/jasim
```
`For Group:` 

Good to know `jasim:x:1002:` its get using `sudo vi /etc/group`
```bash
group_name(jasim):password(x):group_ID(1002):user_list(empty)
```

`For Shadow:` 

Good to know `jasim:!!:19547:0:99999:7:::` its get using `sudo vi /etc/shadow`
```bash
username(jasim):password(!!):last_change(19547):min_days(0):max_days(99999):warn(7):inactive(empty):expire(empty)
```

The error message `adduser: user 'jasim' already exists` indicates that there might still be remnants of the user `jasim` in the system, even after removing the `/etc/group` and `/etc/shadow` entries.

Check `/etc/passwd` for Residual Entries
```bash
cat /etc/passwd | grep jasim
jasim:x:1002:1002::/home/jasim:/bin/bash # output
```
Then remove the line from `/etc/passwd`
```bash
sudo vi /etc/passwd
ls /home/
```

The message `Creating mailbox file: File exists` suggests that there is an existing `mailbox file` for the user `jasim`, which is typically `created for users` with a mail system like `Sendmail` / `Postfix` configured.
Check and Remove the Mailbox File from `/var/mail`
```bash
rm -f /var/mail/jasim
```
Check `/var/spool/mail/` Directory: If the file is located in `/var/spool/mail/`, remove it as well:
```bash
rm -f /var/spool/mail/jasim
```

Additionally, The `lsof` `List Open Files` command is a powerful tool in Linux used to list all the files that are currently open by processes.
```bash
lsof +D /home/jasim # +D: Recursively lists all files opened under the specified directory, including files in subdirectories.
```

Finally, create the user named `jasim`. It will work properly
```bash
sudo adduser jasim
```

User is involved how many groups
```bash
groups jasim
```

Create a New Group
```bash
groupadd developer
groupadd designer
```

Replace a user to new group `-g`
```bash
usermod -g mango jasim # replace old/mother group
```
Append/add/assign a user to new group `-aG`
```bash
useradd -m -G grp-developer Rahim # create extra group, old remain unchanged or
useradd -mG grp-designer Karim # create extra group, old remain unchanged
usermod -aG mango jasim # add extra group, old remain unchanged
usermod -aG mango,developer,designer jasim # add multiple - use `no spaces`
```

Remove group from a user
```bash
gpasswd -d jasim developer
```

The sudoers group is a system group. Its `sudoers` group in Linux is a special user group that is typically used to grant `sudo` privileges to users, allowing them to execute commands as the `root`/`superuser` or other users with administrative privileges.

Add a user to the sudoers group in `Debian`
```bash
usermod -aG sudo jasim # here, `sudo` group
```

Add a user to the sudoers group in `RPM`
```bash
sudo usermod -aG wheel jasim # here, `wheel` group
```

`sudoers` Configuration - Privilege
```bash
root  ALL=(ALL)   ALL
jasim ALL=(ALL)   ALL # allow privilege as root
```
Granting `wheel` Privileges to Groups:
```bash
%wheel   ALL=(ALL)   ALL   # Allow members of the 'sudo' group to run any command
```
If jasim is not in the wheel group, you can add him to the group using the following command:
```bash
sudo usermod -aG wheel jasim
```

Verifying Group Membership
```bash
groups jasim
```
Verify Privileges Using `sudo -l`
```bash
sudo -l -U jasim
```
If everything is set up correctly, you should see
```bash
User jasim may run the following commands on this host:
    (ALL) ALL
```
Test with a Command
```bash
su - jasim
su
ls /root # you should see root directory
```

Understanding Password Aging Parameters
```bash
sudo chage -l jasim
```
Check global defaults
```bash
cat /etc/login.defs
```

### Let's Handson
#### Real Life Scenario #1
I have three departments — `Marketing`, `Sales`, and `Accounts` — and four users: `Jakir (Marketing)`, `Jahid (Sales)`, and `Sadek (Accounts)`. I want to create departmental directories and restrict access such that each user can access only their respective department’s directory. However, Sadek should also have `read` and `write` access to the Sales directory in addition to Accounts. How can I implement this setup on a Red Hat system?
##### Step 1 (User Add) - Under root user
```bash
adduser jakir
passwd jakir
adduser jahid
passwd jahid
adduser sadek
passwd sadek
```

##### Step 2 (User Group) - Under root user
```bash
groupadd marketing
groupadd sales
groupadd accounts
```

##### Step 3 (Directories) - Under root user - Its shows on root directory
```bash
mkdir -p /dept/marketing # p for parent directory
mkdir -p /dept/sales
mkdir -p /dept/accounts
```

##### Step 4 (Assign Users to Their Primary Groups) - Under root user
```bash
usermod -aG marketing jakir
usermod -aG sales jahid
usermod -aG accounts sadek
usermod -aG sales sadek
```

##### Step 5 (Set Group Ownership of Directories) - Under root user
```bash
chown :marketing /dept/marketing
chown :sales /dept/sales
chown :accounts /dept/accounts
```

##### Step 6 (Set Directory Permissions) - Under root user
```bash
chmod 770 /dept/marketing
chmod 770 /dept/sales
chmod 770 /dept/accounts
```

##### Step 7 (Access Summary)

| User  | Group(s)         | Accessible Directories           |
|-------|------------------|----------------------------------|
| Jakir | marketing        | `/dept/marketing`               |
| Jahid | sales            | `/dept/sales`                   |
| Sadek | accounts, sales  | `/dept/accounts`, `/dept/sales` |


##### Step 8 (Testing) - Under must not root user
```bash
su - jakir
cd /dept/sales      # Should fail
cd /dept/marketing  # Should succeed
```

#### Real Life Scenario #2
Suppose you have three departments — `finance`, `entertain`, and `fashion` — and three users: `Kabir (finance)`, `Jasim (entertain)`, and `Sadir (fashion)`. You want to create departmental directories and restrict access such that each user can access only their respective department’s directory. However, `Sadir` should also have only `read` and `write` access to the `fashion` directory in addition to `finance`. By using ACL, How can you design this setup on a Red Hat system?

**Solution**
To achieve this setup using Access Control Lists (ACLs) on a Red Hat Linux system, we will follow these steps. We will set up the directories for each department, create the necessary groups for each user, and then assign appropriate ACLs to control access.

##### Steps: 1 Create Users
Ensure that the users (`Kabir`, `Jasim`, `Sadir`) are already created in the system. If not, you can create them using useradd.
```bash
sudo useradd kabir
sudo useradd jasim
sudo useradd sadir
```
##### Steps: 2 Create Groups: 
Create `three groups`, each corresponding to a department.
```bash
sudo groupadd finance
sudo groupadd entertain
sudo groupadd fashion
```
##### Steps: 3 Assign Users to Their Groups: 
Add each user to the appropriate group.
```bash
sudo usermod -aG finance kabir
sudo usermod -aG entertain jasim
sudo usermod -aG fashion sadir
```
##### Steps: 4 Create Departmental Directories: 
Create directories for each department.
```bash
sudo mkdir /departments/finance
sudo mkdir /departments/entertain
sudo mkdir /departments/fashion
```
##### Steps: 5 Set Group Ownership of Directories: 
Set the group ownership of each directory to the appropriate department group.
```bash
sudo chown :finance /departments/finance
sudo chown :entertain /departments/entertain
sudo chown :fashion /departments/fashion
```
##### Steps: 6 Set Directory Permissions: 
Assign the default permissions for each directory so that only members of the respective group can access them. We will use `770 permissions` (`read`, `write`, and execute for the `owner` and `group`, `no permissions` for others).
```bash
sudo chmod 770 /departments/finance
sudo chmod 770 /departments/entertain
sudo chmod 770 /departments/fashion
```
##### Steps: 7 Set ACL for Sadir: 
Sadir needs access to both the `finance` and `fashion` directories, but `only` with `read` and `write` access for the `fashion` directory, and only read and execute access for the `finance` directory.

##### Steps: 8 Give Sadir `read` and `write` access to the `fashion` directory:
```bash
sudo setfacl -m u:sadir:rw /departments/fashion
```
##### Steps: 9 Give Sadir `read` and `execute` access to the `finance` directory:

```bash
sudo setfacl -m u:sadir:rx /departments/finance
```
##### Steps: 9 Verify ACL Configuration: 
You can check the ACLs for the directories to ensure everything is set correctly:
```bash
getfacl /departments/finance
getfacl /departments/entertain
getfacl /departments/fashion
```
**Explanation:**
- **Finance Directory:**
   - Only Kabir (owner) and members of the finance group have full access (read, write, and execute).
   - Sadir will have read and execute access to the finance directory because of the ACL applied.

- **Entertain Directory:**
   - Only Jasim (owner) and members of the entertain group have full access.

- **Fashion Directory:**
   - Sadir has read and write access to the fashion directory because of the ACL.

- Kabir and Jasim have no access to the fashion directory since they are not part of the fashion group.

- **Default ACLs:**
   - Default ACLs are set up for the directories so that when new files or directories are created inside the departmental directories, they inherit the correct permissions.

**Check ACLs Output:** 

**Finance Directory** (/departments/finance):
```bash
getfacl /departments/finance
# file: /departments/finance
# owner: root
# group: finance
user::rwx
group::rwx
other::---
user:sadir:rx
```
**Fashion Directory**(/departments/fashion):
```bash
getfacl /departments/fashion
# file: /departments/fashion
# owner: root
# group: fashion
user::rwx
group::rwx
other::---
user:sadir:rw
```

**Recap of Permissions:**
- Kabir can access only the finance directory.
- Jasim can access only the entertain directory.
- Sadir has:
   - Read and execute access to the finance directory.
   - Read and write access to the fashion directory.
By using ACLs in this manner, you can enforce fine-grained access control on a per-user and per-directory basis.

#### Real Life Scenario #3
Create three users `ahad`, `fahad`, and `samim`. All three users must change their password upon their first login. in Readhat.

**Solution**

1. Create Users
```bash
sudo useradd ahad
sudo useradd fahad
sudo useradd samim
```
2. Set Temporary Passwords
```bash
echo "TempPass123" | sudo passwd --stdin ahad
echo "TempPass123" | sudo passwd --stdin fahad
echo "TempPass123" | sudo passwd --stdin samim
```
3. Force Password Change on First Login
```bash
sudo chage -d 0 ahad
sudo chage -d 0 fahad
sudo chage -d 0 samim
```
4. Verify (Optional) - You can check that the password change is required:
```bash
chage -l ahad
```
5. Login & set new password
```bash
su - ahad
```
#### Real Life Scenario #4
Create a group named mango and add the users ahad, fahad, and samim to it. Grant all members of the mango group permission to install packages on the system in Redhat.

**Solution**

1. Create the group
```bash
sudo groupadd mango
```
2. Add users to the group
```bash
sudo usermod -aG mango ahad
sudo usermod -aG mango fahad
sudo usermod -aG mango samim
```
3. You can verify group membership using:
```bash
groups ahad
groups fahad
groups samim
```
4. Allow the mango group to install packages using sudo. - Edit the sudoers file safely using visudo:
```bash
sudo visudo
%mango ALL=(ALL) NOPASSWD: /usr/bin/yum, /usr/bin/dnf # Add this line to the end of the file:
```
This allows members of the mango group to run `yum` or `dnf` (depending on what Red Hat uses) to install packages without needing a password.
5. Limit to installing only (no remove/update) - Optional
```bash
%mango ALL=(ALL) NOPASSWD: /usr/bin/yum install *, /usr/bin/dnf install *
```
5. Test sudo access to install packages (as one of the users)
```bash
su - ahad
sudo dnf install nano
```

#### Real Life Scenario #5.
Create a directory named `/staples` and make `samim` the owner of this directory. All the three members of the `mango` group should full permissions to the `/staples` directory.

**Solution**

To fulfill your request on a Linux system, here’s how you can:
- Create the `/staples` directory
- Change ownership to user `samim`
- `Grant full permissions` to all three members of the `mango` group
```bash
sudo mkdir /staples # Create the directory
sudo chown samim /staples # Change the owner of the directory to user 'samim'
sudo chgrp mango /staples # Change the group of the directory to 'mango'
sudo chmod 770 /staples # Give full permissions to the group (read, write, execute)
```
