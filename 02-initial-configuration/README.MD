#### Initial Configuration
```bash
sudo apt upgrade
sudo apt install net-tools
sudo apt update
```
#### Setup static IP Address
```bash
ip a
ip addr
ifconfig
ifconfig -a
```
Go to `/etc/netplan/`
```bash
cp 00-installer-config.yaml 00-installer-config.yaml_bak # take backup
nano 00-installer-config.yaml
```
Initialize IP Address on `00-installer-config.yaml`
```YAML
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens160:
      dhcp4: false
      addresses: [192.168.3.128/24]
      gateway4: 192.168.3.1
      nameservers:
        addresses: [192.18.145.1, 8.8.8.8]
  version: 2
```
Or
```YAML
# This is the network config written by 'subiquity'
network:
  version: 2
  renderer: networkd
  ethernets:
    ens160:
      dhcp4: false
      addresses:
        - 192.168.13.129/32
      routes:
        - to: default
          via: 192.168.13.1
      nameservers:
        addresses: [192.18.145.1,8.8.8.8]
```
```bash
control + x # save & exit
```
```bash
netplan try
netplan apply
sudo systemctl restart systemd-networkd
netplan –debug  apply
ifconfig
```

#### Static IP Configuration in RedHat
```bash
nmcli connection show
cd /etc/NetworkManager/system-connections/
nano ens160.nmconnection
```
Check default gateway
```bash
netstat -nr | grep default
```
Put this configuration
```ini
[ipv4]
method=manual
addresses=192.168.1.100/24
gateway=192.168.1.254
dns=8.8.8.8;
```
```bash
systemctl restart NetworkManager
ip a show ens160
nmcli connection show
```

#### In details of Vi/Vim Editor
It is a powerful text editor used in Linux for efficient file editing, programming, and system administration. It’s an advanced version of `vi` with more features.

Vim has three main modes:  
| Mode             | Description                             | How to Enter             |
| ---------------- | --------------------------------------- | ------------------------ |
| **Normal Mode**  | Default mode for navigation & commands  | Press `Esc`              |
| **Insert Mode**  | Allows text editing                     | Press `i`, `a`, `o`      |
| **Command Mode** | Used for saving, quitting, and searches | Press `:` in Normal Mode |

Opening, Saving & Exiting Vim
| Action                  | Command        |
| ----------------------- | -------------- |
| Open a file in Vim      | `vim filename` |
| Open Vim without a file | `vim`          |
| Exit without saving     | `:q!`          |
| Save and exit           | `:wq` / `ZZ`   |
| Save without exiting    | `:w`           |
| Save and force quit     | `:wq!`         |

Navigation in Normal Mode
| Action                            | Command                        |
| --------------------------------- | ------------------------------ |
| Move cursor top/right/bottom/left | `↑` / `→` / `↓` / `←`          |
| Move to the beginning of a line   | `0`                            |
| Move to the end of a line         | `$`                            |
| Jump to a specific line           | `:<line_number>` (e.g., `:10`) |
| Move one word forward/backward    | `w` / `b`                      |
| Search for text                   | `/keyword` or `?keyword`       |

 Editing Text
| Action                              | Command    |
| ----------------------------------- | ---------- |
| Insert before/after cursor          | `i` / `a`  |
| Insert at the beginning/end of line | `I` / `A`  |
| Delete a character                  | `x`        |
| Delete a word                       | `dw`       |
| Delete an entire line               | `dd`       |
| Copy a line                         | `yy`       |
| Paste copied content                | `p`        |
| Undo last change                    | `u`        |
| Redo last undo                      | `Ctrl + r` |

Advanced Features
| Action                     | Command           |
| -------------------------- | ----------------- |
| Open a new split window    | `:split filename` |
| Switch between splits      | `Ctrl + w + w`    |
| Enable syntax highlighting | `:syntax on`      |
| Show line numbers          | `:set number`     |

#### In details of Nano Editor
Operation & Navigation
|  SL   | Hit Key                  | Explanation                         |
| :---: | :----------------------- | :---------------------------------- |
|   1   | CTRL + Z                 | Suspend                             |
|   2   | CTRL + X                 | Exit Nano permanently               |
|   3   | CTRL + P                 | Move the cursor up one line         |
|   4   | CTRL + N                 | Move the cursor down one line       |
|   5   | CTRL + B                 | Move the cursor left one character  |
|   6   | CTRL + F                 | Move the cursor right one character |
|   7   | ALT + F or CTRL + →      | Move forward by one word            |
|   8   | CTRL + V                 | Scroll page down                    |
|   9   | CTRL + Y                 | Scroll half a page up               |
|  10   | CTRL + W                 | Scroll a full page up               |
|  11   | CTRL + A                 | Go to beginning of the line         |
|  12   | CTRL + E                 | Go to end of the line               |
|  13   | ALT + <                  | Go to beginning of the file         |
|  14   | ALT + >                  | Go to end of the file               |
|  15   | CTRL + _                 | Go to a specific line               |
|  16   | ALT + ,                  | Jump to a specific line or column   |
|  17   | CTRL + ↑                 | To previous block                   |
|  18   | CTRL + ↓                 | To next block                       |
|  19   | ALT + \|To top of buffer |
|  20   | ALT + /                  | To bottom of buffer                 |

Case Conversion
|  SL   | Hit Key | Explanation                                      |
| :---: | :------ | :----------------------------------------------- |
|   1   | ALT + L | Convert the selected text to lowercase           |
|   2   | ALT + U | Convert the selected text to uppercase           |
|   3   | ALT + C | Capitalize the selected text or the current word |

File Handling
|  SL   | Hit Key  | Explanation                                             |
| :---: | :------- | :------------------------------------------------------ |
|   1   | CTRL + S | Save current file                                       |
|   2   | CTRL + O | Offer to write file (“Save as”)                         |
|   3   | CTRL + R | Insert a file into current one                          |
|   4   | CTRL + A | Append the contents of another file to the current file |
|   5   | CTRL + W | Write the current file to a different filename          |
|   6   | CTRL + T | Invoke the spell checker on the current file            |

Editing Shortcuts 
|  SL   | Hit Key      | Explanation                        |
| :---: | :----------- | :--------------------------------- |
|   1   | CTRL + K     | Cut current line into cutbuffer    |
|   2   | ALT + 6      | Copy current line into cutbuffer   |
|   3   | CTRL + U     | Paste contents of cutbuffer        |
|   4   | ALT + T      | Cut until end of buffer            |
|   5   | CTRL + SPACE | Set a mark at the current position |
|   6   | CTRL + ]     | Indent the current line            |
|   7   | ALT + ]      | Unindent the current line          |
|   8   | ALT + 3      | Comment/uncomment line/region      |
|   9   | ALT + U      | Undo last action                   |
|  10   | ALT + E      | Redo last undone action            |

Search Shortcuts 
|  SL   | Hit Key             | Explanation                                                           |
| :---: | :------------------ | :-------------------------------------------------------------------- |
|   1   | CTRL + W            | Start forward search                                                  |
|   2   | CTRL + Q            | Start backward search                                                 |
|   3   | ALT + W             | Repeat the last forward search                                        |
|   4   | ALT + Q             | Find next occurrence backward                                         |
|   5   | ALT + R             | Repeat the last backward search                                       |
|   6   | ALT + W + CTRL + W  | Toggle case sensitivity during search                                 |
|   7   | ALT + W + ALT + W   | Toggle whole word search during search                                |
|   8   | ALT + W + ALT + R   | Toggle regular expression search during search                        |
|   9   | CTRL + W + CTRL + W | Move to the next occurrence of the search pattern                     |
|  10   | CTRL + W + CTRL + V | Move to the previous occurrence of search pattern                     |
|  11   | ALT + W + ALT + V   | Move to the next occurrence of the search pattern (ignoring case)     |
|  12   | ALT + W + ALT + B   | Move to the previous occurrence of the search pattern (ignoring case) |
|  13   | CTRL + W + CTRL + L | Toggle the “Search backwards” option during search                    |
|  14   | CTRL + W + CTRL + O | Toggle the “Wrap around” option during search                         |
|  15   | CTRL + W + CTRL + C | Count the number of occurrences of the search pattern                 |
|  16   | CTRL + W + CTRL + G | Cancel the search and return to editing                               |

Replace Shortcuts 
|  SL   | Hit Key             | Explanation                                                 |
| :---: | :------------------ | :---------------------------------------------------------- |
|   1   | CTRL + W + CTRL + T | Replace the current occurrence of the search pattern        |
|   2   | CTRL + W + CTRL + + | Replace all occurrences of the search pattern               |
|   3   | CTRL + W + CTRL + A | Replace all occurrences of the search pattern interactively |
|   4   | CTRL + W + CTRL + I | Interactive replace with confirmation for each occurrence   |

Deleting Shortcuts 
|  SL   | Hit Key    | Explanation                    |
| :---: | :--------- | :----------------------------- |
|   1   | CTRL + H   | Delete character before cursor |
|   2   | CTRL + D   | Delete character under cursor  |
|   3   | ALT + BSP  | Delete word to the left        |
|   4   | CTRL + DEL | Delete word to the right       |
|   5   | ALT + DEL  | Delete current line            |

#### Java & OpenJDK Install
##### Path Variable Setup like [Open JDK Install](https://jdk.java.net/21/)
Recommended way
```bash
apt update
java -version
cd /opt
# as per your OS you should download specified version. my case aarch64.
wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-aarch64_bin.tar.gz
tar zxvf openjdk-21.0.2_linux-aarch64_bin.tar.gz
mv jdk-21.0.2 jdk-21
whereis java # searching if required
nano .bashrc # or .bash_profile or .zshrc (mac)
JAVA_HOME=/opt/jdk-21 # set java path variable
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export PATH
source .bashrc # or .bash_profile or .zshrc (mac)
java --version
echo $PATH
echo $JAVA_HOME
```

Another way
```bash
apt install openjdk-21-jre-headless
find /usr/lib/jvm/java-21-openjdk-arm64/java* | head -n 3 # searching if required
nano .bashrc # or .bash_profile or .zshrc (mac)
JAVA_HOME=/usr/lib/jvm/java-21-openjdk-arm64 # set java path variable
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export PATH
source .bashrc # or .bash_profile or .zshrc (mac)
java --version
echo $PATH
echo $JAVA_HOME
```




