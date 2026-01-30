# 🔍 Detailed Script Breakdown

This document explains the purpose and logic behind each command used in
the Linux system monitoring script.\
The script provides a quick overview of **CPU, memory, disk, and running
processes** to help with troubleshooting and performance checks.

------------------------------------------------------------------------

## 1️⃣ Shebang and Script Header

``` bash
#!/bin/bash
```

### What it does

-   Known as the **shebang**
-   Tells Linux to execute the script using **Bash**
-   Ensures consistent behavior across systems

------------------------------------------------------------------------

## 2️⃣ CPU Usage Calculation

``` bash
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
```

### Explanation

  Command              Purpose
  -------------------- ------------------------------------------
  `top -bn1`           Runs `top` in batch mode for 1 iteration
  `grep "Cpu(s)"`      Filters the CPU statistics line
  `awk '{print $8}'`   Extracts CPU idle percentage
  `bc`                 Performs math calculation

### Formula

CPU Usage = 100 − Idle %

------------------------------------------------------------------------

## 3️⃣ Memory Usage (Free vs Used)

``` bash
free -m | awk 'NR==2{printf "Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3*100/$2 }'
```

### Explanation

  Field      Meaning
  ---------- -------------------------------
  `$3`       Used memory
  `$2`       Total memory
  `printf`   Formats clean readable output

### Example Output

    Used: 2048MB / Total: 4096MB (50.00%)

------------------------------------------------------------------------

## 4️⃣ Disk Usage

``` bash
df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s usage)\n", $3, $2, $5}'
```

### Explanation

  Field   Meaning
  ------- ------------------
  `$3`    Used space
  `$2`    Total space
  `$5`    Percentage usage

### Example Output

    Used: 15G / Total: 40G (38% usage)

------------------------------------------------------------------------

## 5️⃣ Top 5 Processes (CPU & Memory)

``` bash
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
```

### Explanation

  Option           Purpose
  ---------------- ----------------------------------------
  `ps -eo`         Lists all processes with custom format
  `--sort=-%cpu`   Sorts by highest CPU usage
  `head -n 6`      Shows header + top 5 processes

### Benefit

Quickly identifies: - High CPU usage processes - Resource bottlenecks -
Misbehaving services

------------------------------------------------------------------------

# 🛠 Prerequisites

## Supported OS

-   Linux (Ubuntu/Debian recommended)
-   Works on most distributions

## Required Dependency

### Install bc

### Ubuntu/Debian

``` bash
sudo apt update && sudo apt install bc -y
```

### RHEL/CentOS/AlmaLinux/Rocky

``` bash
sudo yum install bc -y
```

------------------------------------------------------------------------

# 🚀 Usage

Make script executable:

``` bash
chmod +x monitor.sh
```

Run:

``` bash
./monitor.sh
```

------------------------------------------------------------------------

# ✅ Summary

This script provides:

-   CPU usage
-   Memory usage
-   Disk usage
-   Top resource-consuming processes

Useful for:

-   Server health checks
-   Troubleshooting
-   Performance monitoring
-   Cron automation

------------------------------------------------------------------------

**Author:** frd amirul
