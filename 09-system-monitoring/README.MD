### System Tuning?

System tuning refers to optimizing the performance of a computer system by adjusting certain parameters, configurations, and settings. In the context of **Red Hat Enterprise Linux (RHEL)**, system tuning aims to improve the efficiency, speed, and resource management of your server or workstation. This can involve fine-tuning several components, including:

| **Component**         | **Description**                                                                                                                                      |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **CPU**               | Adjusting how the CPU performs tasks or manages multiple processes (like setting CPU governor for performance or power savings).                     |
| **Memory (RAM)**      | Configuring how the system uses memory, including optimizing cache usage, limiting swap usage, or enabling huge pages for large-memory applications. |
| **Disk I/O**          | Modifying disk scheduling algorithms or file system parameters to improve read/write operations.                                                     |
| **Network**           | Tuning TCP/IP settings for faster data transfer and reducing network latency.                                                                        |
| **Kernel Parameters** | Fine-tuning the Linux kernel parameters (via `sysctl`) for better system performance under load.                                                     |

#### Tuning Important?

- **Performance Optimization:** Tuning ensures that your system runs as efficiently as possible, making sure resources (CPU, memory, disk, network) are used optimally.
- **Stability:** Proper tuning can help avoid system crashes or slowdowns by preventing resource exhaustion.
- **Scalability:** Tuning helps systems scale to meet the needs of high-load applications, such as web servers, databases, and enterprise applications.
- **Security:** Some tuning, such as disabling unused services or restricting resource access, can improve the overall security posture of your system.

#### Process Management

Running an instance of a program is called a process. In Linux Process ID (PID) is used to represent the process details. The process will be implemented in Linux in two ways;

1. **Background Process**
   Depends on the user for input also referred to as interactive processes. For example Office programs.
2. **Foreground Process**
   Runs independently of the user referred to as a non-interactive or automatic process. For example Antivirus programs

**State:**
A process in Linux can go through different states after it’s created and before it’s terminated. These states are:

- Running
- Sleeping
  - Interruptible sleep
  - Uninterruptible sleep
- Stopped
- Zombie (Partly Alive)

- State with description

| **State**                 | **Description**                                                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Running**               | The process is currently executing on the CPU or is ready to run (in the run queue).                                                |
| **Sleeping**              | The process is waiting for a resource (e.g., I/O operation) to become available.                                                    |
| **Interruptible Sleep**   | A type of sleeping state where the process can wake up when it receives a signal.                                                   |
| **Uninterruptible Sleep** | A sleeping state where the process cannot be interrupted by signals (usually waiting on I/O).                                       |
| **Stopped**               | The process has received a stop signal (e.g., `SIGSTOP`) and is paused.                                                             |
| **Zombie (Partly Alive)** | The process has finished executing but still has an entry in the process table because its parent has not yet read its exit status. |

The important terminology follows:

|  SL   |   Field   | Description                                 | Example 1 | Example 2 |
| :---: | :-------: | :------------------------------------------ | :-------: | :-------: |
|   1   |   `PID`   | The process ID of each task                 |   1525    |    961    |
|   2   |  `User`   | The username of task owner                  |   Home    |   Root    |
|   3   |   `PR`    | Priority- Can be 20(highest) or -20(lowest) |    20     |    20     |
|   4   |   `NI`    | The nice value of a task                    |     0     |     0     |
|   5   |  `VIRT`   | Virtual memory used (kb)                    |   1775    |   75972   |
|   6   |   `RES`   | Physical memory used (kb)                   |    100    |    51     |
|   7   |   `SHR`   | Shared memory used (kb)                     |    28     |   7952    |
|   8   |    `S`    | There are five Status*                      |     S     |     R     |
|   9   |  `%CPU`   | % of CPU time                               |    1.7    |    1.0    |
|  10   |  `%MEM`   | Physical memory used                        |    10     |    5.1    |
|  11   |  `TIME+`  | Total CPU time                              |  5:05:34  |  2:23:43  |
|  12   | `Command` | Command name                                |   snapd   |  systemd  |

- Status:
  There are five types:
  - ‘D’ = Uninterruptible Sleep
  - ‘R’ = Running
  - ‘S’ = Sleeping
  - ‘T’ = Traced/Topped
  - ‘Z’ = Zombie

**Different Commands for Process Management**

There are two commands available in Linux to track running processes. These two commands are ‘top’ and ‘ps’.

|  SL   |        Command        | Explanation                                                                                                                               |
| :---: | :-------------------: | :---------------------------------------------------------------------------------------------------------------------------------------- |
|   1   |         `top`         | To track the running processes on your machine you can use the top command. Press q for quit.                                             |
|   2   | `ps (Process Status)` | It displays the currently running processes. However, unlike the top command, the output generated is not in real-time. Press q for quit. |

- To get more information using the ps command use:

```bash
ps -u
```

- The terminology is as follows:
|  SL   | Command | Explanation                                   |
| :---: | :-----: | :-------------------------------------------- |
|   1   |  `PID`  | Process ID                                    |
|   2   |  `TTY`  | Terminal TYpe                                 |
|   3   | `TIME`  | Total time the process has been running       |
|   4   |  `CMD`  | Name of the command that launches the process |

- While the ps command only displays the processes that are currently running, you can also use it to list all the processes.

```bash
ps      # running process
ps -A   # running process in details
top     # running process realtime
htop     # running process realtime
ps -u   # running process

ps -ef  # process in details (location)
ps aux  # process in details (location)
ps aux | less # process in details (location) less
ps aux | grep terminal # process display which related to terminal
pstree # see the tree of process
ps -C su # see the ps by category
pgrep bash # Find the PID
```

- Checking the kill service name and its ID.

```bash
kill -l # kill list
kill -L # kill list
```

- Kill the process

```bash
kill -9 PID
```

### Scheduling - Recurring - Repeating Tasks

Scheduling tasks in Red Hat Linux (any Linux-based system) is commonly done using cron jobs or at jobs for one-time tasks. Here's a complete guideline on how to schedule (`daily`, `hourly`, `weekly`) future tasks in Red Hat Linux using these tools. We can do it by `three` ways

1. Using `cron` Daemon
2. Using `at` Daemon
3. Using `systemd timers` Daemon

1. **Cron Daemon** Ensure the cron daemon (crond) is running. You can check its status or start it if it’s not running:

```bash
sudo systemctl status crond     # Check if cron is running
sudo systemctl start crond      # Start cron if not running
```

- Cron Syntax

```bash
* * * * * /path/to/command
- - - - -
| | | | |
| | | | +---- Day of the week   (0 - 7) (Sunday = 0 or 7)
| | | +------ Month             (1 - 12)
| | +-------- Day of the month  (1 - 31)
| +---------- Hour              (0 - 23)
+------------ Minute            (0 - 59)
```

- View & Edit the Cron Table (Crontab)

```bash
crontab -l
crontab -e
```

- Add some cron jobs
  - To run a backup script every day at `3 AM`

```bash
0 3 * * * /path/to/backup_script.sh
```

- To run a command at `5 PM` every Friday

```bash
0 17 * * 5 /path/to/weekly_script.sh
```

- To run a backup script at `2:30 AM` on the first day of every month:

```bash
30 2 1 * * /path/to/monthly_backup.sh
```

- View Cron Jobs

```bash
crontab -l
```

- Remove Cron Jobs

```bash
crontab -r
```

- Viewing Cron Logs

```bash
sudo cat /var/log/cron
```

2. **At Daemon**

- Checking if at is Installed

```bash
sudo dnf install at        # Install at if necessary
sudo systemctl start atd   # Start the at daemon
sudo systemctl enable atd
```

- Using at to Schedule Tasks
  - To run a script at 10:00 AM tomorrow.

```bash
echo "/path/to/script.sh" | at 10:00 AM tomorrow
```

- Alternatively, you can enter the at interactive mode.

```bash
at 10:00 AM tomorrow
at> /path/to/script.sh
at> <EOT>  # Press Ctrl+D to submit the job
```

- View Scheduled at Jobs

```bash
atq
```

- Remove Scheduled Jobs

```bash
atrm <job_id>
atrm 3  # Removes the job with ID 3
```

- Example at Jobs

```bash
echo "/path/to/script.sh" | at 2:00 PM # To run a script at 2 PM today.
echo "/path/to/script.sh" | at 5:30 AM 06/15/2025 # To run a script at 5:30 AM on a specific date.
```

3. **systemd timers Daemon**
If you need more flexibility or complex scheduling, you can use `systemd timers`, which are an alternative to cron and at with more features.

- Create the Service Unit `sudo nano /etc/systemd/system/backup.service`

```ini
[Unit]
Description=Backup Service
[Service]
Type=simple
ExecStart=/path/to/backup_script.sh
```

- Create the Timer Unit `sudo nano /etc/systemd/system/backup.timer`

```ini
[Unit]
Description=Runs Backup Service Daily at 2 AM
[Timer]
OnCalendar=daily
Persistent=true
[Install]
WantedBy=timers.target
```

- Start and Enable the Timer

```bash
sudo systemctl start backup.timer
sudo systemctl enable backup.timer
```

- Check Timer Status

```bash
sudo systemctl status backup.timer
```
