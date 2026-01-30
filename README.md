🔍 Detailed Script Breakdown
This section explains the logic behind each command used in the script.

1. The Shebang and Header
Bash
#!/bin/bash
#!/bin/bash: The Shebang. It tells the operating system to use the Bash interpreter located in /bin/bash to execute the file.

2. CPU Usage Calculation
Bash
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
top -bn1: Runs the top command in batch mode for number of 1 iteration. This allows us to capture the output as static text.

grep "Cpu(s)": Isolates the specific line containing CPU percentage data.

awk '{print $8}': Extracts the 8th column, which represents the CPU idle time.

bc: The Basic Calculator. It performs the math (100 - idle) to determine the actual CPU load.

3. Memory Usage (Free vs. Used)
Bash
free -m | awk 'NR==2{printf "Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3*100/$2 }'
free -m: Displays memory usage in Megabytes.

NR==2: Targets the Number of Row 2 (the physical RAM row).

$3, $2: Variables representing the Used ($3) and Total ($2) memory columns.

printf: A formatting tool that creates a clean string and calculates the percentage on-the-fly.

4. Disk Usage
Bash
df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s usage)\n", $3, $2, $5}'
df -h /: Disk Free command targeting the root (/) partition in human-readable format.

$3, $2, $5: Extracts the Used space, Total size, and the system-calculated percentage string ($5).

5. Top 5 Processes (CPU & Memory)
Bash
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
ps -eo: The Process Status command with every process and a custom output format.

pid,ppid,cmd,%cpu: Defines the specific columns to display.

--sort=-%cpu: Sorts the output in descending order (highest usage first).

head -n 6: Captures the header line plus the top 5 process entries.

🛠 Prerequisites
Operating System: Linux (Ubuntu/Debian recommended).

Dependencies: bc (Basic Calculator) is required for math operations.

Bash
sudo apt update && sudo apt install bc -y
