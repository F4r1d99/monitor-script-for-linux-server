🔍 Detailed Script Breakdown

This section explains the purpose and logic behind each command used in the monitoring script. The script collects CPU, memory, disk, and process usage to provide a quick system health overview.

1️⃣ Shebang and Script Header
#!/bin/bash


What it does:

Known as the shebang

Tells the operating system to execute the script using the Bash interpreter

Ensures consistent behavior across Linux environments

2️⃣ CPU Usage Calculation
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)

Command breakdown
Command	Purpose
top -bn1	Runs top in batch mode for 1 iteration to get static output
grep "Cpu(s)"	Filters the CPU statistics line
awk '{print $8}'	Extracts the idle CPU percentage
bc	Performs math calculation (100 − idle)
Result

Calculates:

CPU Usage = 100 − Idle %


This gives the actual CPU load.

3️⃣ Memory Usage (Free vs Used)
free -m | awk 'NR==2{printf "Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

Command breakdown
Command	Purpose
free -m	Shows memory usage in MB
NR==2	Targets the physical RAM row
$3	Used memory
$2	Total memory
printf	Formats readable output and calculates percentage
Result example
Used: 2048MB / Total: 4096MB (50.00%)

4️⃣ Disk Usage
df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s usage)\n", $3, $2, $5}'

Command breakdown
Command	Purpose
df -h /	Shows disk usage for root partition in human-readable format
$3	Used space
$2	Total size
$5	Usage percentage
printf	Clean formatted output
Result example
Used: 15G / Total: 40G (38% usage)

5️⃣ Top 5 Processes (CPU & Memory)
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

Command breakdown
Command	Purpose
ps -eo	Lists all running processes with custom columns
pid,ppid,cmd,%cpu	Displays process ID, parent ID, command, and CPU usage
--sort=-%cpu	Sorts by highest CPU usage first
head -n 6	Shows header + top 5 processes
Result

Helps quickly identify:

High CPU consumers

Misbehaving processes

Performance bottlenecks
