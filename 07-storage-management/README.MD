### Partition Table
A partition table maps out partitions onto a storage device. The two biggest examples are `Master Boot Record - MBR` and `GUID Partition Table - GPT`. Others include Apple Partition Map (APM), which is used in Apple computers, and BSD disklabel.

| Feature                      | **MBR (Master Boot Record)**                                       | **GPT (GUID Partition Table)**                                         |
| ---------------------------- | ------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| **Partition Limit**          | Supports up to 4 primary partitions or 3 primary + 1 extended      | Supports up to 128 partitions without extended partitions              |
| **Disk Size Limit**          | Max size of 2TB                                                    | Can support disks larger than 2TB                                      |
| **Partition Type**           | Primary and Extended partitions                                    | Primary partitions only (with no need for extended partitions)         |
| **Boot Mode**                | Used with BIOS-based systems                                       | Used with UEFI-based systems                                           |
| **Data Structure**           | Stores partition table in the first sector of the disk (512 bytes) | Stores partition data in multiple places across the disk               |
| **Redundancy**               | No redundancy for partition table (single copy)                    | Redundant partition tables stored at the beginning and end of the disk |
| **Error Recovery**           | Lacks error checking or recovery mechanisms                        | Includes CRC32 checksums to improve data integrity and recovery        |
| **Compatibility**            | Compatible with older systems and most OSes                        | Supported by modern OSes and UEFI firmware                             |
| **Boot Partition**           | Bootloader must reside in the first 512 bytes of the disk          | No such constraint, bootloader can reside anywhere on the disk         |
| **Support for EFI**          | Does not support UEFI firmware boot                                | Required for UEFI boot systems                                         |
| **Partitioning Flexibility** | Limited flexibility, hard to change partitions after creation      | More flexible with partition sizes and modifications                   |
| **Usage**                    | Older systems and smaller disks (typically < 2TB)                   | Modern systems, large disks (typically > 2TB)                           |

### Partition
A partition is essentially a segment of your storage device (HDD or SSD). It defines a distinct portion of the drive that can be used to store data or run applications like an operating system. There are different types of partitions depending on the partitioning table (MBR or GPT):

- **Primary Partition:** A primary partition is a main, independent partition on a hard drive or SSD that can hold a file system or operating system. It is one of the core building blocks for dividing a disk's space.
  - **Features:**
    - Can hold data or be used to install an operating system.
    - On an Master Boot Record - MBR disk, you can have up to 4 primary partitions.
    - A primary partition can be marked as active, which means it contains the bootable operating system or boot files (for the system to boot up).
    - GUID Partition Table - GPT does not have this limitation—each partition is essentially a `primary` partition in the GPT scheme.
    - Example: You might create a primary partition to install Windows or Linux on your hard drive.

- **Extended Partition:** An extended partition is a special partition type used in MBR partitioning to overcome the limitation of having only 4 primary partitions. The extended partition does not hold data directly; instead, it serves as a container for logical partitions.
  - **Features:**
    - A disk can have only one extended partition.
    - You cannot store data directly on the extended partition itself.
    - The extended partition enables the creation of multiple logical partitions within it.
    - Extended partitions are not bootable and are used mainly for organizing multiple partitions.
    - Example: You could have an extended partition that contains multiple logical partitions, each for storing different data or software installations.

- **Logical Partition:** A logical partition is a partition created inside an extended partition. Logical partitions function like primary partitions but are contained within the extended partition and allow you to create more partitions than the MBR scheme normally allows.
  - **Features:**
    - Logical partitions are created within an extended partition.
    - A logical partition can be used to store data, applications, or even an operating system.
    - There is no upper limit on the number of logical partitions you can create within an extended partition (apart from space constraints).
    - Not bootable in most cases (though it is possible to make a logical partition bootable with specialized configuration).
    - Example: You might create multiple logical partitions within an extended partition to organize your data into categories (e.g., "Documents", "Videos", etc.).

### Storage Management in Red Hat (RHEL)
Managing storage in Red Hat Enterprise Linux (RHEL) involves configuring, monitoring, and optimizing storage devices like hard drives, SSDs, and network storage. In Red Hat (RHEL) or any Linux-based system, storage can come in several forms. Here’s an overview of the main types of storage you can add to your system:
- Local Storage (HDD, SSD)
- Network File Systems (NFS)
- Storage Area Network (SAN)
- Server Message Block (SMB)/Common Internet File System (CIFS) - Samba
- Cloud Storage (AWS EBS, GCP Persistent Disk)

#### Logical Volume Management (LVM)
It's a powerful Linux storage management system that provides `flexible disk partitioning`, `dynamic resizing`, `snapshots`, and `better storage utilization` compared to traditional partitioning.

**Benefits of using LVM**
- Flexible Storage – Resize logical volumes (LVs) on demand.
- Friendly File System - Any file system can be installed on the LVs
- Storage Change - Easy to replace faulty disks
- Snapshots – Backup a volume without downtime.
- Combine Multiple Disks – Create a single storage pool (VG) from multiple disks.
- Thin Provisioning – Allocate more storage than physically available.
- Easy Management – Add/remove disks without reformatting.

**Steps of Storage Management**
1. **Physical Devices (PD)** – these are used to store data. It be disk partitions as `whole disks`, `RAID arrays` or `SAN disks`. These are generally the `/dev/sda`, `/dev/sdb` etc.
2. **Physical Volume (PV)** – Physical devices can not be used for LVM directly. They have to be converted into `Physical Volumes(PVs)`.
3. **Volume Group (VG)** – are the storage pool made from one or more PV. VG is used to create Logical Volumes(LVs). It is not necessary to use the entire VG to create LVs
4. **Logical Volume (LV)** – are created from the free physical extents in a volume group. LVs are collection of logical extents which are mapped to physical extents. 

![LVM Illustration](/07-storage-management/lvm.png)

**Storage Pool**
A storage pool is a logical collection of physical storage resources (disks, SSDs, partitions) that are grouped together to provide:
- Unified storage capacity
- Flexible allocation
- Advanced features like thin provisioning and snapshots

Check physical volumes (PVs) in system
```bash
pvs
pvs -v # verbose output
pvs -o +devices # display physical volumes with custom columns
pvs /dev/sda # view specific volume group (VG)
vgs # summary of all volume groups
```
Check volumes groups (VGs) in system
```bash
vgs
vgs -v # verbose output
vgs -o vg_name,pv_count,lv_count,vsize,vfree # customize output columns
vgs my_vg # info specific volume group
vgs --units g # display the sizes in gigabytes
```
Check logical volumes (LVs) in system
```bash
lvs
lvs -v # verbose output
lvs -o lv_name,vg_name,lv_size,lv_attr # customize output columns
lgs my_vg # info specific volume group
vgs --units g # display the sizes in gigabytes
```

**Let's walk through a `hands-on` example.**

How can I create logical volumes for three hard drives (`/dev/sda` with `70GB`, `/dev/sdb` with `80GB`, and `/dev/sdc` with `70GB`), combine them into a 220GB volume group, and create two logical volumes (`120GB` and `100GB`) within the volume group, then format them with a filesystem?

**Steps**
- Create Physical Volumes (PVs)
```bash
pvcreate /dev/sda
pvcreate /dev/sdb
pvcreate /dev/sdc
pvs # check created Physical Volumes (PVs)
```
- Create a Volume Group (VG)
```bash
vgcreate my_vg /dev/sda /dev/sdb /dev/sdc # where volume name is `my_vg`
vgs
```
- Create Logical Volumes (LVs) create `two logical` volumes. A `120GB` logical volume & A `100GB` logical volume
```bash
lvcreate -L 120G -n lv_data my_vg # lvs name is lv_data
lvcreate -L 100G -n lv_home my_vg # lvs name is lv_home
lvs 
```
- Create Filesystems on the Logical Volumes
  - for `lv_data`
```bash
mkfs.ext4 /dev/my_vg/lv_data
```
  - for `lv_home`
```bash
mkfs.ext4 /dev/my_vg/lv_home
```
Create a Physical Volume (PV), Checking all available block devices
```bash
lsblk
lsblk -l
```
- Mount the Logical Volumes (Optional)
  If you want to mount these logical volumes to specific directories (`/mnt/data` for `lv_data` and `/mnt/home` for `lv_home`), you can follow these steps:

  - Create mount points
```bash
mkdir /mnt/data
mkdir /mnt/home
```
  - Mount the logical volumes
```bash
mount /dev/my_vg/lv_data /mnt/data
mount /dev/my_vg/lv_home /mnt/home
```
Check mount point 
```bash
df -h
```

- Make the Mount Permanent (Optional)
To ensure the logical volumes are mounted automatically after a reboot, you can add them to `/etc/fstab`:
```bash
nano /etc/fstab
```
Put these following lines
```bash
/dev/my_vg/lv_data   /mnt/data   ext4   defaults   0   0
/dev/my_vg/lv_home   /mnt/home   ext4   defaults   0   0
```
