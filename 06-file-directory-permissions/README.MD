#### Paths
Paths are used to locate files and directories within the system. The concept of absolute and relative paths is the same as what I explained earlier, but let's dive deeper into how paths are structured in Linux

##### Absolute Path
Provides a complete, fixed location starting from the root directory, useful when you want to ensure you're always referring to the same location, regardless of the current directory. An absolute path in Red Hat Linux (and all Linux systems) begins from the root directory `/`, which is the top-level directory of the file system.

```bash
/home/jakir/Documents/info.txt
```
##### Relative Path
Provides a location based on where you currently are, useful for navigating within a known structure or when working on a project. A relative path in Linux refers to a file or directory's location relative to the current working directory. Example: If you are in the directory `/home/jakir/` and want to access file.txt in `/home/jakir/Documents/`, the relative path would be:
```bash
Documents/info.txt
```

#### File Management:
File management is so important on a computer that users always want a simple and easy way to use it. Performing simple tasks such as searching, copying, moving, creating and deleting files, and complex operations such as remote access of files and SSH connections is vital.

##### Renaming the file & folder:
```bash
sudo mv presentNameOfFile.format NewNameOfFile.format
sudo mv presentNameOfFolder NewNameOfFolder
```

##### Deleting/removing the file:
removing/deleting files/directories
```bash
sudo rm -f fileName.format
sudo rm -R dirName # if there is something in the directory
sudo rm -r dirname1 dirname2 dirname3
sudo rm -r filename1 filename2 filename3
```
Copying the file & folder:
```bash
sudo cp fileName.format destinationFolder
```
Same as with files you can also use a wildcard (*) and regular expansions to match multiple directories.

File, folder & its permission management:
Permission Notation
|  SL   | Command     | Notation              |
| :---: | :---------- | :-------------------- |
|   1   | `-`         | File                  |
|   2   | `d`         | Directory             |
|   3   | `r`         | Read (4)              |
|   4   | `w`         | Write (2)             |
|   5   | `x`         | Execute (1)           |
|   6   | `o`         | Other                 |
|   7   | `a`         | All                   |
|   8   | `b`         | Block File            |
|   9   | `c`         | Character Device File |
|  10   | `p`         | Pipe File             |
|  11   | `s`         | Socket File           |
|  12   | `Pipe Sign` | Symbolic Links        |
|  13   | `-`         | No Permission         |
|  14   | `.`         | Extended Attributes   |

Segment Layout
|  SL   | file/directory   | rwx (7)   |  r-x (5)  |  r-x (5)  | root  |    root    |
| :---: | :--------------- | :-------- | :-------: | :-------: | :---: | :--------: |
|   1   | `File/Directory` | Owner (o) | Group (g) | Users (u) | User  | User Group |

We can give permission to others in two ways: one is alphabetic & another is numeric.

|  SL   | Numeric                           | Alphabetic                                |
| :---: | :-------------------------------- | :---------------------------------------- |
|   1   | `sudo chmod 777 file/folder name` | `sudo chmod u/g/o+r/w/x file/folder name` |
|   2   | `sudo chmod 777 file/folder name` | `sudo chmod ugo+rwx file/folder name`     |
|   3   | `sudo chmod 000 file/folder name` | `sudo chmod u/g/o-r/w/x file/folder name` |
|   4   | `sudo chmod 777 file/folder name` | `sudo chmod ugo-rwx file/folder name`     |
|   5   | `sudo chmod 777 file/folder name` | `sudo chmod a=rwx file/folder name`       |

The following are the usual options used with chmod:
- -f, --silent, --quiet: Suppresses most error messages.
- -v, --verbose: Outputs a diagnostic for every file processed.
- -c, --changes: Like verbose but reports only when a change is made.
- -R, --recursive: Changes files and directories recursively. 
  To modify the permissions of each and every file and folder in a provided directory at once, use sudo chmod with -R
- --help: Displays help and exits.
- --version: Outputs version information and exits.

The table below gives numbers for all permissions types.
|  SL   | Decimal Value | Permission Type (rwx)    | Symbol (rwx) | Binary Value |
| :---: | :-----------: | :----------------------- | :----------: | :----------: |
|   1   |      `0`      | `No Permission`          |    `---`     |    `000`     |
|   2   |      `1`      | `Execute`                |    `--x`     |    `001`     |
|   3   |      `2`      | `Write`                  |    `-w-`     |    `010`     |
|   4   |      `3`      | `Read + Execute`         |    `-wx`     |    `011`     |
|   5   |      `4`      | `Read`                   |    `r--`     |    `100`     |
|   6   |      `5`      | `Read + Execute`         |    `r-w`     |    `101`     |
|   7   |      `6`      | `Read + Write`           |    `rw-`     |    `110`     |
|   8   |      `7`      | `Read + Write + Execute` |    `rwx`     |    `111`     |

Symbolic Mode
|  SL   | Operator | Description                                                      |
| :---: | :------: | :--------------------------------------------------------------- |
|   1   |   `+`    | `Adds permission to a file or directory`                         |
|   2   |   `-`    | `Removes the permission`                                         |
|   3   |   `=`    | `Sets the permission and overrides the permissions set earlier.` |

Change Permission Recursively
It is common to use the basic chmod command to change the permission of a single file. However, you may need to modify the permissions recursively for all files within a directory. 
```bash
sudo chmod -R 755 Example
```

##### Ownership `chown` & Group `chgrp` Change
```bash
chgrp jakir info.txt # change group
chown jakir inro.txt # change ownership
```

#### Access Control Lists
Access Control Lists (ACLs) are used to provide more granular and flexible control over file and directory permissions, extending beyond the standard user, group, and other permissions, allowing you to grant or deny specific permissions to individual users or groups.

Check if ACL support is enabled for your XFS filesystem
```bash
xfs_info /dev/mapper/rhel-root # If ACL is supported, you should see `attr = 1`
```

Check the mount options for ACL support or not. If `acl` is listed in the output, it means ACL is enabled. If not, you may need to add it to `/etc/fstab` and remount.
```bash
mount | grep acl
```

Check & Install 
```bash
which getfacl
which setfacl
sudo dnf install acl
sudo yum install acl
```

Add `acl` to `/etc/fstab`
```bash
# <file system>                             <mount point>   <type>  <options>       <dump>  <pass>
/dev/mapper/rhel-root                       /               xfs     defaults,acl    0       0
UUID=f295a1aa-e334-43f8-a103-b1a7e1d66a9d   /boot           xfs     defaults,acl    0       0
```
- The `acl` option tells the system to enable ACL support on that particular filesystem.

After modifying `/etc/fstab`, you need to remount the each filesystem to apply the changes.
```bash
sudo mount -o remount /
sudo mount -o remount /boot
```

To confirm that ACL support is enabled, run
```bash
mount | grep acl # if okay will see `/dev/mapper/rhel-root on / type xfs (rw,relatime,acl)`
```

Setting/Removing ACL for a User
```bash
setfacl -m u:username:rwx testfile
setfacl -x u:username testfile
```

Setting/Removing ACL for a Group
```bash
setfacl -m g:mygroup:rx testfile
setfacl -x g:mygroup testfile
```

Setting/Removing `default ACLs` on a `directory` so that any new files created inside that directory inherit the ACLs.
```bash
setfacl -m d:u:username:rwx mydir
```

To remove all ACLs from a file and revert it to the standard user/group/others permissions
```bash
setfacl -b testfile
```

To view the current ACLs on a file or directory, use the `getfacl` command
```bash
getfacl testfile
```

If you have ACLs for `multiple users` and `groups`, the mask limits the permissions for all `users` and `groups` except the owner.
```bash
setfacl -m d:u:username:rwx mydir
```

#### inode
An inode `index node` is a data structure used by Linux filesystems (like ext4, xfs) to store metadata about a file. Each file or directory has an associated inode, which contains important information except the filename and actual data. Its works as `pointer` of a file.

##### What Information Does an Inode Store?
- File type (regular file, directory, symbolic link, etc.)
- Permissions (read, write, execute)
- Owner (UID) and Group (GID)
- File size
- Timestamps (creation, modification, access)
- Number of hard links
- Location of data blocks on disk (but not the file name!)

##### Soft (Symbolic) Link
A soft link (symlink) is like a `shortcut`. It stores the path to the original file instead of pointing to its inode. Key Features of Soft Links:
- Different inode number than the original file
- Can link directories and files
- Can cross different filesystems
- If the original file is deleted, the soft link breaks (becomes invalid)
```bash
mkdir a
cd a
mkdir b
cd b
mkdir c
cd c
echo "Hello, Soft Link. How are you" > info-soft-link.txt
```
Go back to `home` directory & Make a soft link
```bash
ln -s a/b/c/info-soft-link.txt my-test-soft-link
ls -ltr # check status
cat my-test-soft-link
```

Insert new line via shortcut, main file will be updated
```bash
nano my-test-soft-link # write Its update from shortcut of soft link.
echo "write Its update from shortcut of soft link." my-test-soft-link # write Its update from shortcut of soft link.
cat my-test-soft-link 
cat a/b/c/info-soft-link.txt
```
Lets check `inode`
```bash
ls -li
17345966 lrwxrwxrwx. 1 root root 14 Mar 28 20:13 my-test-soft-link -> a/b/c/info-soft-link.txt
ls -li a/b/c/info-soft-link.txt
17345957 -rw-r--r--. 1 root root 56 Mar 28 20:22 a/b/c/info-soft-link.txt
```
Its gives different `inode`

**Hard Link**
A hard link is another name for the same file (same inode). It points directly to the inode of the original file. Key Features of Hard Links:
- Same inode number as the original file
- No duplication of file content
- Deleting the original file doesn’t delete the hard link
- Cannot link directories
- Must be on the same filesystem
```bash
touch a/b/c/info-hard-link.txt
echo "Hello, hard link test" > a/b/c/info-hard-link.txt
```
Create hard link
```bash
ln a/b/c/info-hard-link.txt my-test-hard-link
```

Insert new line via rename file, main file will be updated
```bash
nano my-test-hard-link # write Its update from rename file of soft link.
echo "write Its update from rename file of soft link." my-test-hard-link # write Its update from rename file of soft link.
cat my-test-hard-link 
cat a/b/c/info-hard-link.txt
```

Let check `inode`
```bash
ls -li a/b/c/info-hard-link.txt
17345967 -rw-r--r--. 2 root root 22 Mar 28 20:39 a/b/c/info-hard-link.txt
ls -li a/b/c/my-test-hard-link
17345967 -rw-r--r--. 2 root root 22 Mar 28 20:39 my-test-hard-link
```
Its gives different `inode`

| Feature                       | Hard Link                 | Soft Link (Symlink)    |
| ----------------------------- | ------------------------- | ---------------------- |
| **Inode Number**              | Same as original          | Different              |
| **Storage Type**              | Points to the same inode  | Stores the file path   |
| **File Content**              | Same as the original file | Just a pointer (path)  |
| **Deleting Original File**    | Hard link remains intact  | Soft link breaks       |
| **Works Across Filesystems?** | ❌ No                      | ✅ Yes                  |
| **Can Link Directories?**     | ❌ No                      | ✅ Yes (with `-s` flag) |

##### Input & Output Redirection in Linux
Linux input/output (I/O) redirection allows you to control how commands receive input and where they send output. It’s essential for scripting, automation, and system administration.

**Linux has three standard data streams:**
| Stream     | Description     | File Descriptor | Default Device    |
| ---------- | --------------- | --------------- | ----------------- |
| **STDIN**  | Standard Input  | `0`             | Keyboard          |
| **STDOUT** | Standard Output | `1`             | Terminal (screen) |
| **STDERR** | Standard Error  | `2`             | Terminal (screen) |

Input & Output Redirection commands
```bash
ls > mylist.txt # makes list
cat mylist.txt
ls >> mylist.txt # makes another list
echo "insert new line" >> mylist.txt # insert new line
wc -l < myfile.txt # line counts
``` 
Using pipe for combining two or more commands
```bash
ls -l | grep ".txt"
cat myfile.txt | wc -w
```

**Summary Table**
| Redirection Type                    | Symbol         | Example                      |
| ----------------------------------- | -------------- | ---------------------------- |
| **Overwrite Output**                | `>`            | `ls > file.txt`              |
| **Append Output**                   | `>>`           | `echo "text" >> file.txt`    |
| **Overwrite Error**                 | `2>`           | `ls /fake_dir 2> error.log`  |
| **Append Error**                    | `2>>`          | `ls /fake_dir 2>> error.log` |
| **Overwrite Both (Output & Error)** | `&>`           | `command &> output.log`      |
| **Append Both (Output & Error)**    | `>> file 2>&1` | `command >> output.log 2>&1` |
| **Input Redirection**               | `<`            | `wc -l < file.txt`           |
| **Pipe Output**                     | `Pipe`         | `grep ".txt"`                |
| **Discard Output**                  | `/dev/null`    | `command > /dev/null 2>&1`   |

**Help command**
| Method   | Works With              | Output Type        | Example     |
| -------- | ----------------------- | ------------------ | ----------- |
| `help`   | Built-in shell commands | Short descriptions | `help cd`   |
| `man`    | External commands       | Detailed manual    | `man ls`    |
| `--help` | External commands       | Quick summary      | `ls --help` |
