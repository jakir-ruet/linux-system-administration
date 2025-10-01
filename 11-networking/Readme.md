### Internet Protocol (IP)

An Internet Protocol address (IP address) is a numerical label such as 172.16.254.1 that is connected to a computer network that uses the Internet Protocol for communication. An IP address serves two main functions: network interface identification, and location addressing. The are two versions of IP address
1. IPv4 (8-bit)
2. IPv6 (128-bit)


#### IPv4?

It is an IP version widely used to identify devices on a network using an addressing system. It was the first version of IP deployed for production in the ARPANET in 1983. It uses a (4-octal & 8-bit in each - 4*8) `32-bit` address scheme to store 232 (4294967296) addresses which is more than `4 billion` addresses. It is considered the primary Internet Protocol and carries `94%` of Internet traffic.

![IPv4](/img/ipv4.png)

##### Features

Here are the features of IPv6:

- Hierarchical addressing and routing infrastructure
- Stateful and Stateless configuration
- Support for quality of service (QoS)
- An ideal protocol for neighbouring node interaction

##### Differences between IPv4 and IPv6 Addresses

| Feature                      | IPv4                               | IPv6                                         |
|-----------------------------|------------------------------------|----------------------------------------------|
| Address Length              | 32 bits                            | 128 bits                                     |
| Format                      | Decimal (e.g., 192.168.0.1)        | Hexadecimal (e.g., 2001:0db8:...)            |
| Address Capacity            | ~4.3 billion                       | ~340 undecillion (3.4×10³⁸)                 |
| Header Complexity           | Simple                             | More complex, but efficient                  |
| Security                    | Optional (IPSec)                   | Built-in (mandatory for IPv6)                |
| NAT (Network Address Translation) | Commonly used                  | Not required (thanks to large address pool)  |
| Broadcast                   | Supported                          | Replaced with multicast and anycast          |
| Adoption                    | Widely used                        | Slowly increasing worldwide                  |
| Number of header fields     | 12                                 | 8                                            |
| Length of header field      | 20                                 | 40                                           |

> **Note:** IPv4 and IPv6 cannot communicate with each other but can exist together on the same network. This is known as `Dual Stack`.

##### Types of IPs

There are five types/classes of IP addresses

- Class A > `(1-126)`. > **Note:** 127.0.0.1 Loopback IP & 0.0.0.0 is not used as IP Address. Range (1.0.0.0 to 126.255.255.255)
- Class B > `(128-191)`. > **Note:** Range (128.0.0.0 to 191.255.255.255)
- Class C > `(192-223)`. > **Note:** Range (192.0.0.0 to 223.255.255.255)
- Class D > `(224-239)`. > **Note:** Range (224.0.0.0 to 239.255.255.255)
- Class E > `(240-255)`. > **Note:** (240.0.0.0 to 225.255.255.255)


##### Is IPv4 or IPv6 better?

IPv4 is the fourth version of the Internet Protocol (IP), while IPv6 is the most recent version of the Internet Protocol. Therefore, IPv6 is more advanced, secure, and faster compared to IPv4.

##### Broadcast addressing

Broadcasting is an addressing technique available in IPv4 to address data to all possible destinations on a network in one transmission operation as an all-hosts broadcast. All receivers capture the network packet. The address 255.255.255.255 is used for network broadcast. In addition, a more limited directed broadcast uses the all-ones host address with the network prefix. For example, the destination address used for direct broadcast to devices on the network 192.0.2.0/24 is 192.0.2.255. IPv6 does not implement broadcast addressing and replaces it with multicast to the specially defined all-nodes multicast address.

##### IP Address Classes (IPv4)

IPv4 addresses are divided into 5 classes: A, B, C, D, and E, based on their first octet (the first 8 bits of the address).

| Class | Address Range | Subnet Mask      | Example IP  | Leading Bits | Max Networks | Application                        |
|-------|---------------|------------------|-------------|---------------|---------------|------------------------------------|
| A     | 1 – 126       | 255.0.0.0        | 1.1.1.1     | 0xxxxxxx      | 128           | Large networks with many hosts     |
| B     | 128 – 191     | 255.255.0.0      | 128.1.1.1   | 10xxxxxx      | 16,384        | Medium-sized networks              |
| C     | 192 – 223     | 255.255.255.0    | 192.1.1.1   | 110xxxxx      | 2,097,152     | Small networks / LANs              |
| D     | 224 – 239     | Not Applicable   | –           | 1110xxxx      | –             | Multicasting                       |
| E     | 240 – 254     | Not Applicable   | –           | 1111xxxx      | –             | Experimental / Research (R&D)      |

##### Network and Host ID Table

| Class | Octet-1     | Octet-2     | Octet-3     | Octet-4     |
|-------|-------------|-------------|-------------|-------------|
| A     | Network ID  | Host ID     | Host ID     | Host ID     |
| B     | Network ID  | Network ID  | Host ID     | Host ID     |
| C     | Network ID  | Network ID  | Network ID  | Host ID     |
| D     | Network ID  | Network ID  | Network ID  | Network ID  |
| E     | Network ID  | Network ID  | Network ID  | Network ID  |

##### What is a Private IP?

A Private IP is an IP address used within a private network to identify devices like computers, phones, or printers. These addresses are not routable on the internet and are meant for internal communication only.

- Used in: Home networks, LANs (Local Area Networks)
- Example ranges (IPv4):
   - 10.0.0.0 to 10.255.255.255
   - 172.16.0.0 to 172.31.255.255
   - 192.168.0.0 to 192.168.255.255

>**Key Point:** Private IPs are assigned by routers and cannot be accessed directly from the internet.

##### What is a Public IP Address:

A Public IP is an IP address assigned to a device that is directly accessible over the internet. It is unique across the entire web.

- Used in: Websites, servers, home routers (as seen by ISPs)
- Assigned by: Internet Service Providers (ISPs)
- Can be: Static or dynamic
>**Key Point:** Public IPs are needed for internet communication and are globally unique.

##### Difference between Private IP & Public IP

| Feature             | Private IP                                  | Public IP                            |
|---------------------|----------------------------------------------|--------------------------------------|
| **Scope**           | Local (internal network)                     | Global (internet)                    |
| **Routable on Internet** | No                                     | Yes                                  |
| **Assigned by**     | Router or local network                      | ISP (Internet Service Provider)      |
| **IP Range Examples** | 192.168.x.x, 10.x.x.x, 172.16.x.x          | Varies (e.g., 8.8.8.8)               |
| **Accessibility**   | Only within the same network                 | Accessible from anywhere on the internet |

#### What is a subnet?

A subnet, or subnetwork, is a network inside a network. Subnets make networks more efficient. Through subnetting, network traffic can travel a shorter distance without passing through unnecessary routers to reach its destination.

![Subnetting](/img/subnetting.png)

##### Why Use Subnetting?
Here are important reasons for using Subnetting:

- It helps you to maximise IP addressing efficiency.
- Extend the life of IPV4.
- Public IPV4 Addresses are scarce.
- IPV4 Subnetting reduces network traffic by eliminating collision and broadcast traffic and thus improves overall performance.
- This method allows you to apply network security policies at the interconnection between subnets.
- Optimized IP network performance.
- Facilitates the spanning of large geographical distances.
- The subnetting process helps to allocate IP addresses that prevent large numbers of IP network addresses from remaining unused.
- Subnets are usually set up geographically for specific offices or particular teams within a business that allow their network traffic to stay within the location.

##### What is a Subnet Mask?

A subnet mask is a 32-bit address used to distinguish between a network address and a host address in an IP address. A subnet mask identifies which part of an IP address is the network address and the host address. They are not shown inside the data packets traversing the Internet. They carry the destination IP address, which a router will match with a subnet.

##### Subnet Values and Corresponding Bit Values

| Subnet Value | Bit 1 | Bit 2 | Bit 3 | Bit 4 | Bit 5 | Bit 6 | Bit 7 | Bit 8 |
|--------------|-------|-------|-------|-------|-------|-------|-------|-------|
| 255          | 1     | 1     | 1     | 1     | 1     | 1     | 1     | 1     |
| 254          | 1     | 1     | 1     | 1     | 1     | 1     | 1     | 0     |
| 252          | 1     | 1     | 1     | 1     | 1     | 1     | 0     | 0     |
| 248          | 1     | 1     | 1     | 1     | 1     | 0     | 0     | 0     |
| 240          | 1     | 1     | 1     | 1     | 0     | 0     | 0     | 0     |
| 224          | 1     | 1     | 1     | 0     | 0     | 0     | 0     | 0     |
| 192          | 1     | 1     | 0     | 0     | 0     | 0     | 0     | 0     |
| 128          | 1     | 0     | 0     | 0     | 0     | 0     | 0     | 0     |
| 0            | 0     | 0     | 0     | 0     | 0     | 0     | 0     | 0     |

>**Notes**: `1` represent networks, `0` represent hosts

##### Two types of subnet masks are:

- The default Subnet Mask is the number of bits which is reserved by the address class. Using this default mask will accommodate a single network subnet in the relative class.
- A Custom Subnet Mask can be defined by an administrator to accommodate many networks.

#### Let's explore an example

Suppose you are given the IP `175.231.232.116`/`27`.

**Find:**

1. Subnet mask
2. Block size
3. Number of subnets
4. Number of hosts per subnet
5. Subnet addresses,
6. Locate which subnet` 175.231.232.116` belongs
7. First valid host
8. Last valid host &
9. Broadcast address

**Solution:**

Let’s understand the problem
- IP address: `175.231.232.116`
- CIDR notation: Given `mask /27` means the `first 27` bits are network bits
- Default `mask /16` of class B
- IP address length: `32` bits total
- /27 means `27 bits are 1s` in subnet mask, remaining `5 bits are 0s`
- Binary & Decimal subnet mask:

| Octet 1    | Octet 2    | Octet 3    | Octet 4    | Decimal Equivalent |
|------------|------------|------------|------------|---------------------|
| 11111111   | 11111111   | 11111111   | 11100000   | 255.255.255.224     |

**Explanation:**

- **Network Block:** The `1`s in the binary mask (`/27`) represent the **network portion** of the IP address.
- **Host Block:** The `0`s in the last octet (`00000`) represent the **host portion** — allowing for **32 addresses**, of which **30 are usable** (excluding network and broadcast addresses).

>**Suppose**

Given:
- `x` = number of 1’s in last octet = **3**
- `y` = number of 0’s in last octet = **5**
- `z` = Given mask `/27` = **27**
- `k` = Default mask = **16** (Class B)
- `LOSM` (Last Octet of Subnet Mask) = 2⁷ + 2⁶ + 2⁵ = 128 + 64 + 32 = 224

1. Subnet Mask is 255.255.255.224
2. Block size = 256 - LOSM = 256 - 224=32
3. Number of Subnets = 2^(k - y) = 2^(16 - 5) = 2¹¹ = 2048
4. Number of Hosts per Subnet = 2^5 - 2 = 32 - 2 = 30.

>**Notes** (Subtract 2 for network and broadcast addresses)

5. Subnet addresses (Host)

| Subnet | Subnet ID         | First Host         | Last Host          | Broadcast Address   |
|--------|-------------------|--------------------|--------------------|---------------------|
| 1      | 175.231.232.0     | 175.231.232.1      | 175.231.232.30     | 175.231.232.31      |
| 2      | 175.231.232.32    | 175.231.232.33     | 175.231.232.62     | 175.231.232.63      |
| 3      | 175.231.232.64    | 175.231.232.65     | 175.231.232.94     | 175.231.232.95      |
| 4      | 175.231.232.96    | 175.231.232.97     | 175.231.232.126    | 175.231.232.127     |
| 5      | 175.231.232.128   | 175.231.232.129    | 175.231.232.158    | 175.231.232.159     |
| 6      | 175.231.232.160   | 175.231.232.161    | 175.231.232.190    | 175.231.232.191     |
| 7      | 175.231.232.192   | 175.231.232.193    | 175.231.232.222    | 175.231.232.223     |
| 8      | 175.231.232.224   | 175.231.232.225    | 175.231.232.254    | 175.231.232.255     |

6. Locate which subnet 175.231.232.116 belongs to:
Subnet ID = 175.231.232.96.

>*Note*** In between = 175.231.232.96 to 175.231.232.127, because 96 + 32 = 128.

7. First valid host = 175.231.232.97
8. Last valid host = 175.231.232.126
9. Broadcast address = 175.231.232.127

Summary:

| Item                  | Value                |
|-----------------------|----------------------|
| **IP Address**        | 175.231.232.116      |
| **Subnet Mask**       | 255.255.255.224      |
| **Block Size**        | 32                   |
| **Number of Subnets** | 2048                 |
| **Hosts per Subnet**  | 30                   |
| **Subnet ID**         | 175.231.232.96       |
| **First Valid Host**  | 175.231.232.97       |
| **Last Valid Host**   | 175.231.232.126      |
| **Broadcast Address** | 175.231.232.127      |

#### As we know, the default CIDR value of class B is /16, so why is /27 used in 175.231.232.116/27?
Understanding that the `default /16 mask for Class B is often too large` for many real-world networks, and that subnetting with something like `/27` is used to create smaller, manageable subnets with fewer hosts, is spot on. Using `/27` instead of the default /16 helps:

##### Benefits of using `/27`:
- Allocates IP addresses **efficiently**
- Improves **network management**
- Reduces **broadcast traffic**
- Provides just **30 usable hosts** per subnet (2⁵ - 2)

>**So** yes, your reasoning about why 175.231.232.116/27 uses a /27 instead of the default /16 is correct!

##### Why use /27 for a Class B IP?

- The default `mask /16 means` the network includes `65,534 hosts` (2^16 - 2).
- In many cases, this is too large for practical use — networks often don’t need that many hosts.
- To manage IP addresses efficiently, networks are subnetted to create smaller blocks.
- /27 means:
  - 27 bits for network + subnet (instead of 16 bits)
  - 5 bits left for hosts
  - So, you get 30 usable hosts per subnet (2^5 - 2)

**Conclusion:**

Using a **/27** subnet instead of the default **/16** helps in efficient IP address management, especially when only small groups of hosts are needed in each network.

### What is a Network Interface?

 A network interface is a hardware or software device that allows a computer to connect to a network and send and receive data. Can be referred to as a Network Interface Card or Controller (NIC), Network Adaptor, or LAN adaptor.

#### Types of
- Wired Network Interfaces
- Wireless Network Interfaces

**IP Command** Wired Network Interfaces

| Command                                           | Purpose                                                             |
|---------------------------------------------------|---------------------------------------------------------------------|
| `ip help`                                         | Display a list of commands and options for the `ip` command         |
| `ip addr help`                                    | Display a list of commands and options for the `address` subcommand |
| `ip link help`                                    | Display a list of commands and options for the `link` subcommand    |
| `ip addr`                                         | Show information for all addresses                                  |
| `ip addr show dev em1`                            | Show information for a specific device (`em1`)                      |
| `ip addr add 192.168.1.1/24 dev em1`              | Add an address to a device                                          |
| `ip addr del 192.168.1.1/24 dev em1`              | Remove an address from a device                                     |
| `ip addr add 192.168.1.1/24 broadcast 192.168.1.255 dev em1` | Add an IP address and specific broadcast address to a device         |
| `ip link`                                    | Show information for all interfaces                       |
| `ip link show dev em1`                       | Show information for a single device                      |
| `ip -s link`                                 | Show interface statistics                                 |
| `ip link set`                                | Alter the status of an interface                          |
| `ip link set mtu <number>`                   | Set maximum transmission unit for a network interface     |
| `ip link set em1 promisc on`                 | Set a network interface to promiscuous mode               |
| `ip link set em1 up`                         | Bring a device online                                     |
| `ip link set em1 down`                       | Bring a device offline                                    |

**The ifconfig Command** Wired Network Interfaces

| Command                                          | Purpose                                                       |
|--------------------------------------------------|---------------------------------------------------------------|
| `ifconfig`                                       | Display information for active network interfaces             |
| `ifconfig -a`                                    | Display information for all network interfaces                |
| `ifconfig eth0`                                  | Display information for a specific network interface          |
| `ifconfig eth0 up`                               | Bring a device online                                         |
| `ifconfig eth0 down`                             | Bring a device offline                                        |
| `ifconfig eth0 192.168.1.10`                     | Assign an IP address to a network interface                   |
| `ifconfig eth0 netmask 255.255.255.0`            | Assign a netmask to a network interface                       |
| `ifconfig eth0 broadcast 192.168.1.255`          | Assign a broadcast address to a network interface             |
| `ifconfig eth0 0.0.0.0`                          | Remove an IP address from a network interface                 |
| `ifconfig eth0 mtu <number>`                     | Set maximum transmission unit for a network interface         |
| `ifconfig eth0 promisc`                          | Set a network interface to promiscuous mode                   |

> **Note:** The `ifconfig` command is provided by the **net-tools** package.

**The iw command** Wireless Network Interfaces

| Command                     | Purpose                                    |
|-----------------------------|--------------------------------------------|
| `iw help`                   | Print all supported commands               |
| `iw help <command>`         | Print help information for specified command |
| `iw dev`                   | View available wireless interfaces        |
| `iw list`                  | List all wireless devices and their capabilities |
| `iw dev wlan0 link`        | Display link information                    |
| `iw dev wlan0 info`        | Show information for an interface          |
| `iw event`                 | Monitor events from the kernel              |
| `iw wlan0 scan`            | Scan for available SSIDs                    |
| `iw dev wlan0 connect <SSID>` | Connect to a wireless network              |
| `iw dev wlan0 disconnect`  | Disconnect from a wireless network          |

**The iwconfigand iwlist commands** Wireless Network Interfaces

| Command                               | Purpose                                      |
|---------------------------------------|----------------------------------------------|
| `iwconfig`                           | Display information about all available wireless interfaces |
| `iwconfig wlan0`                    | Display information about a wireless interface |
| `iwconfig --help`                   | Display a list of commands and options       |
| `iwconfig wlan0 essid "MyNetwork" key my_key` | Connect to a wireless network by providing a key |
| `iwconfig wlan0 rate 24M`           | Set the bitrate for an interface              |
| `iwlist wlan0 scan`                 | Scan for available wireless networks          |
| `iwlist wlan0 freq`                 | List available frequencies                      |
| `iwlist wlan0 rate`                 | List available bit rates                         |

**Using the ip Command (ip neighbour)** Wireless Network Interfaces

| Command                                                       | Purpose                                                     |
|----------------------------------------------------------------|-------------------------------------------------------------|
| `ip neigh`                                                    | Display neighbor objects (ARP table entries)                |
| `ip -s neigh`                                                 | Display neighbor objects in verbose mode with statistics    |
| `ip neigh show dev em1`                                       | Show the ARP cache for a specific device                    |
| `ip neigh add 192.168.1.10 lladdr 1:2:3:4:5:6 dev em1`         | Add an entry into the ARP table                             |
| `ip neigh del 192.168.1.10 dev em1`                            | Invalidate (delete) an entry in the ARP table               |
| `ip neigh replace 192.168.1.10 lladdr 1:2:3:4:5:6 dev em1`     | Replace an entry or add one if not already defined          |

**The ip route and route Commands**

| Command                                      | Purpose                                                      |
|----------------------------------------------|--------------------------------------------------------------|
| `ip route`                                   | Display the routing table                                    |
| `ip route show`                              | Same as `ip route` – shows the current routing table         |
| `ip route add default via 192.168.1.1`       | Add a default gateway                                        |
| `ip route del default`                       | Remove the default gateway                                   |
| `ip route add 192.168.2.0/24 via 192.168.1.1`| Add a static route to a network via a specific gateway       |
| `ip route change default via 192.168.1.254`  | Change the default gateway                                   |
| `ip route flush cache`                       | Clear the route cache                                        |
| `route`                                      | Display the routing table (legacy command)                   |
| `route -n`                                   | Display routing table without resolving hostnames            |
| `route add default gw 192.168.1.1`           | Add a default gateway using `route`                          |
| `route del default gw 192.168.1.1`           | Delete the default gateway                                   |
| `route add -net 192.168.2.0 netmask 255.255.255.0 gw 192.168.1.1` | Add a static route to a network                              |

### Networking Prerequisite Switching, Routing, Gateways CNI in kubernetes

- Switching
- Routing
- Default Gateway
- DNS
  - DNS Configurations on Linux
  - CoreDNS Introduction
  - Network Namespaces
  - Docker Networking

![switching](/img/switching.png)
![routing](/img/routing-1.png)
![routing](/img/routing-2.png)
![routing](/img/routing-3.png)
![routing](/img/routing-4.png)
![routing](/img/routing-5.png)
![name-resolution](/img/name-resolution-1.png)
![name-resolution](/img/name-resolution-2.png)

#### Network Namespace

A network namespace is a feature in the Linux kernel that provides isolated network environments for processes. It allows multiple network stacks to coexist on a single system, each with its own interfaces, routing tables, firewall rules, and so on.

Key Concepts
- Each network namespace has:
- Its own network interfaces (e.g., `eth0`, `lo`)
- Its own IP addresses
- Its own routing tables
- Its own firewall (iptables/nftables) rules
- Its own ARP tables, etc.
- By default, all processes share the default network namespace.

![network-namespace](/img/network-namespace.png)
