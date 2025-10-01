## Welcome to Domain Name System (DNS)
DNS servers are responsible for resolving domain names into IP addresses. When setting up a DNS server, you typically use software like BIND (Berkeley Internet Name Domain), Unbound, or others. On Red Hat-based systems (like RHEL or CentOS), BIND is commonly used for installation and configuration. 

**Types of DNS server**
- DNS Resolver (Provided by ISP DNS Server, Use Local DNS Server or Google DNS Server like 8.8.8.8 )
- [Root Name Server](https://root-servers.org/)
- Top Level Domain Name Server
- Authoritive Name Server

![DNS Architecture](/img/dns-architecture.png)

We will discuss 
- DNS Server Installation
- Primary DNS Server 
- Secondary DNS Server 
- Caching Only DNS Server 
- Forwarding to Another DNS Server 
- Recursive & Non Recursive Query 
- DNS Caching 
- Zone: Forward & Reverse
- DNS Record Types: A, PTR, NS, MX, SOA, TXT etc.
- DNS Testing Utilities: nslookup, Host, Dig etc. 
- DNS ACL 
- DNS Logging
- DNS Remote Control with Rndc (Remote Name Daemon Control)

### DNS Server Installation
```bash 
hostname
hostname -f
sudo dnf update
sudo dnf install bind bind-utils
sudo systemctl start named
sudo systemctl enable named
cat /etc/named.conf
sudo systemctl restart named
```
### Primary DNS Server 
The Primary DNS Server (also known as the Master DNS Server) holds the main records for a domain. It is where DNS zone files are stored and maintained. Key functions:
- Stores zone files for domains.
- Responds to DNS queries from clients.
- Provides authoritative information for a specific zone. Example of a zone file (`/etc/named.conf`):
```bash
zone "example.com" IN {
    type master;
    file "example.com.zone";
};
```
### Secondary DNS Server
The Secondary DNS Server (also known as Slave DNS Server) is a backup server that holds a read-only copy of the zone files. It helps distribute the DNS load and provides redundancy. Key functions:
- Retrieves zone files from the primary DNS server through zone transfers.
- Responds to queries in the same way as the primary server but without the ability to modify the zone records. Configuration in `/etc/named.conf`:
```bash
zone "example.com" IN {
    type slave;
    file "example.com.zone";
    masters { 192.168.1.10; };  # IP of primary DNS server
};
```
### Caching Only DNS Server 
A Caching Only DNS Server does not store authoritative records for domains. Instead, it caches the results from other DNS servers to reduce query times and traffic. This server only responds to DNS queries and stores the results temporarily.
- **Configuration:**
  - Typically configured without a zone file.
  - Responds only to recursive queries.
### Forwarding to Another DNS Server
Forwarding is a method where a DNS server forwards DNS queries to another DNS server (usually a more authoritative or external one) when it cannot resolve the query locally.
- **Forwarder Configuration:**
```bash
options {
    forwarders {
        8.8.8.8;  # Google's DNS
        8.8.4.4;
    };
};
```
### Recursive & Non Recursive Query 
- **Recursive Query:** The DNS server takes full responsibility for resolving the domain, querying other servers if necessary, until the final answer is found.
- **Non-Recursive Query:** The DNS server does not perform the full resolution and will only answer with cached data or refer the client to another DNS server.
### DNS Caching 
DNS servers store results of DNS queries for a period of time (called the Time to Live or TTL). This helps reduce the load on DNS servers and speeds up domain resolution.
- **TTL setting in a zone file:**
```bash
@   IN  SOA ns1.example.com. admin.example.com. (
        2023050101 ; Serial
        3600       ; Refresh
        1800       ; Retry
        1209600    ; Expire
        86400 )    ; TTL
```
### Zone: Forward & Reverse
- **Forward Zone:** This is the most common zone where a domain name is mapped to an IP address [`www.example.com to IP addresses`] (A or AAAA records). Example for `forward zone` (`example.com.zone`):
```bash
@ IN A 192.168.1.1
```
- **Reverse Zone:** Used to resolve an IP address back to a domain name [`IP addresses to www.example.com`] (PTR records). It's the reverse of the forward zone. Example for `reverse zone` (`1.168.192.in-addr.arpa.zone`):
```bash
@ IN PTR example.com.
```
### DNS Record Types: A, PTR, NS, MX, SOA, TXT etc.
There are many DNS record types, but here are some of the key ones:
| Record Type | Purpose                                                     |
| ----------- | ----------------------------------------------------------- |
| A           | Maps a domain to an IPv4 address.                           |
| AAAA        | Maps a domain to an IPv6 address.                           |
| CNAME       | Maps a domain to another domain (used for aliasing).        |
| MX          | Specifies mail servers for email delivery.                  |
| TXT         | Holds arbitrary text (e.g., SPF, domain verification).      |
| NS          | Lists authoritative name servers for the domain.            |
| SOA         | Start of Authority – provides info about the domain/zone.   |
| SRV         | Specifies location of services (e.g., SIP, XMPP).           |
| Alias       | AWS-specific alias to AWS resources (e.g., S3, CloudFront). |
### DNS Testing Utilities: nslookup, Host, Dig etc. 
These tools help you query DNS servers and troubleshoot DNS issues.
- **nslookup:** Simple command-line tool to query DNS records.
```bash
nslookup example.com
```
- **dig:** A more advanced tool for querying DNS.
```bash
dig example.com
```
- **host:** Another tool to perform DNS lookups.
```bash
host example.com
```
### DNS ACL 
DNS servers can use ACLs to control which clients are allowed to query the server, transfer zones, or update records. ACLs are useful for securing DNS servers and restricting access. Example in `/etc/named.conf`:
```bash
acl trusted {
    192.168.1.0/24;
};
options {
    allow-query { trusted; };
};
```
### DNS Logging
DNS logs can help troubleshoot DNS issues, monitor performance, and detect unusual activity. BIND can log queries and other events. 
- BIND Logging Configuration:
```bash
logging {
    channel default_file {
        file "/var/log/named.log" versions 3 size 5m;
        severity info;
    };
    category queries { default_file; };
};
```
### DNS Remote Control with Rndc (Remote Name Daemon Control)
`rndc` is a tool for managing BIND DNS servers remotely. It can be used to restart the server, reload zone files, or perform other administrative tasks.
- Basic usage:
```bash
rndc reload      # Reloads the configuration
rndc status      # Shows the current status of the DNS server
rndc stop        # Stops the DNS server
```
- For security, you usually set up rndc with a key for authentication. Example `/etc/rndc.key`:
```bash
key "rndc-key" {
    algorithm hmac-md5;
    secret "your-secret-key";
};
```
- In `/etc/named.conf`, configure the rndc key:
```bash
controls {
    inet 127.0.0.1 port 953 allow { 127.0.0.1; } keys { rndc-key; };
};
```
### Realtime Scenario 
#### Problem #1
How would you configure a DNS server to allow queries only from the local network, and what configuration changes are necessary on a Windows 10 client to test name resolution?

**Solution**
By implementing below steps, I can do it.
- DNS Server Installation
```bash
sudo dnf install bind bind-utils
```
- Edit `/etc/named.conf`
```bash
vi /etc/named.conf
systemctl restart named
netstat -antp # check running services
192.168.68.0# master machine `192.168.68.151` IP
systemctl restart named
netstat -antp # master machine `192.168.68.151` IP enable.
```
- DNS Port Settings
```bash
ipconfig # in windows machine.
ipconfig /all
```
- Allow query from local network
```bash
ping 8.8.8.8
ping google.com # It doest not work
# put `192.168.68.0` in after localhost`allow-query` { localhost; 192.168.68.0;};
ping 192.168.68.151 # master machine `192.168.68.151` IP
```
- Configure Windows 11 Client & Test Name Resolution
```bash
ping 8.8.8.8
ping google.com # It doest not work
ping 192.168.68.151 # master machine `192.168.68.151` IP
```

#### Problem #2
I have three domains: mangobd.com (IP: 192.168.68.151), bananabd.com (IP: 192.168.68.152), and berrybd.com (IP: 192.168.68.153). I would like to configure a DNS server to manage these domains on a Red Hat-based Linux system. Could you guide me on how to implement this setup in a production environment?

**Solution**
To configure a production-level DNS server for multiple domains on a Red Hat-based system (RHEL/CentOS), we'll set up BIND (Berkeley Internet Name Domain) as the DNS server software. You'll configure it to manage the DNS records for the three domains you mentioned: `mangobd.com`, `bananabd.com,` and `berrybd.com.` Steps Overview:
- Install BIND (DNS server software)
- Configure BIND to handle multiple domains
- Set up zone files for each domain
- Set up name servers (NS records) for each domain
- Configure security and permissions
- Test DNS resolution

##### Install BIND (DNS server software)
```bash
sudo dnf update -y
sudo dnf install -y bind bind-utils
```
##### Configure BIND to handle multiple domains.  Open `/etc/named.conf`
```json
options {
    listen-on port 53 { 127.0.0.1; 192.168.68.151; 192.168.68.152; 192.168.68.153; };   # Add your DNS server IPs
    listen-on-v6 { none; };
    directory "/var/named";
    dump-file "/var/named/data/cache_dump.db";
    statistics-file "/var/named/data/named_stats.txt";
    memstatistics-file "/var/named/data/named_mem_stats.txt";
    allow-query { any; };
    allow-query-cache { none; };    # Disable recursion if it is a public DNS server
    recursion no;                   # Disable recursion for external queries
    forwarders {                    # Optional: Add external DNS servers if necessary
        8.8.8.8;                    # Google DNS
        8.8.4.4;
    };
};

zone "mangobd.com" IN {
    type master;
    file "/var/named/mangobd.com.zone";
};

zone "bananabd.com" IN {
    type master;
    file "/var/named/bananabd.com.zone";
};

zone "berrybd.com" IN {
    type master;
    file "/var/named/berrybd.com.zone";
};
```
##### Logging setup
```bash
logging {
    channel default_file {
        file "/var/log/named.log" versions 3 size 5m;
        severity info;
        print-time yes;
        print-severity yes;
        print-category yes;
    };

    category default { default_file; };
};
```
##### Set up zone files for each domain
- Create the zone file `/var/named/mangobd.com.zone`
```bash
$TTL 86400
@    IN    SOA   ns1.mangobd.com. admin.mangobd.com. (
              2023052001 ; Serial
              3600       ; Refresh
              1800       ; Retry
              1209600    ; Expire
              86400 )    ; Minimum TTL

     IN    NS    ns1.mangobd.com.
     IN    NS    ns2.mangobd.com.

ns1  IN    A     192.168.68.151
ns2  IN    A     192.168.68.152  ; Secondary DNS server

@    IN    A     192.168.68.151  ; IP for mangobd.com
www  IN    A     192.168.68.151  ; IP for www.mangobd.com
```
- Create the zone file `/var/named/bananabd.com.zone`
```bash
$TTL 86400
@    IN    SOA   ns1.bananabd.com. admin.bananabd.com. (
              2023052001 ; Serial
              3600       ; Refresh
              1800       ; Retry
              1209600    ; Expire
              86400 )    ; Minimum TTL

     IN    NS    ns1.bananabd.com.
     IN    NS    ns2.bananabd.com.

ns1  IN    A     192.168.68.152
ns2  IN    A     192.168.68.153  ; Secondary DNS server

@    IN    A     192.168.68.152  ; IP for bananabd.com
www  IN    A     192.168.68.152  ; IP for www.bananabd.com
```
- Create the zone file `/var/named/berrybd.com.zone`
```bash
$TTL 86400
@    IN    SOA   ns1.berrybd.com. admin.berrybd.com. (
              2023052001 ; Serial
              3600       ; Refresh
              1800       ; Retry
              1209600    ; Expire
              86400 )    ; Minimum TTL

     IN    NS    ns1.berrybd.com.
     IN    NS    ns2.berrybd.com.

ns1  IN    A     192.168.68.153
ns2  IN    A     192.168.68.151  ; Secondary DNS server

@    IN    A     192.168.68.153  ; IP for berrybd.com
www  IN    A     192.168.68.153  ; IP for www.berrybd.com
```
##### Set File Permissions
```bash
sudo chown root:named /var/named/*.zone
sudo chmod 644 /var/named/*.zone
```
##### Start and Enable BIND
```bash
sudo systemctl start named
sudo systemctl enable named
```
##### Configure Firewall
```bash
sudo firewall-cmd --add-service=dns --permanent
sudo firewall-cmd --reload
```
Or
```bash
sudo firewall-cmd --zone=public --add-port=53/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent
sudo firewall-cmd --reload
```
##### Test Your DNS Server
```bash
dig @localhost mangobd.com
dig @localhost bananabd.com
dig @localhost berrybd.com
```
