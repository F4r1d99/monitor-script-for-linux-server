#!/bin/bash

echo "------------------------------------------"
echo "SYSTEM MONITORING REPORT - $(date)"
echo "------------------------------------------"

# 1. Total CPU Usage
# Calculated by taking 100% minus the 'idle' percentage from top
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "CPU Usage: $cpu_usage%"

# 2. Total Memory Usage
echo -e "\nMEMORY USAGE:"
free -m | awk 'NR==2{printf "Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

# 3. Total Disk Usage
echo -e "\nDISK USAGE (Root Partition):"
df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s usage)\n", $3, $2, $5}'

# 4. Top 5 Processes by CPU
echo -e "\nTOP 5 PROCESSES BY CPU USAGE:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 Processes by Memory
echo -e "\nTOP 5 PROCESSES BY MEMORY USAGE:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo "------------------------------------------"
