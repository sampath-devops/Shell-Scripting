#!/usr/bin/env bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=75
DISK_THRESHOLD=85

send_alert() {
  if [ -t 1 ]; then
    echo "$(tput setaf 1)ALERT: $1 usage exceeded threshold! current value: $2%$(tput sgr0)"
  else
    echo "ALERT: $1 usage exceeded threshold! current value: $2%"
  fi
}

# CPU usage
cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print int($2 + $4)}')
echo "Current CPU usage: $cpu_usage%"

if (( cpu_usage >= CPU_THRESHOLD )); then
  send_alert "CPU" "$cpu_usage"
fi

# Memory usage
memory_usage=$(free | awk '/Mem/ {print int(($3/$2) * 100)}')
echo "Current memory usage: $memory_usage%"

if (( memory_usage >= MEMORY_THRESHOLD )); then
  send_alert "Memory" "$memory_usage"
fi

# Disk usage
disk_usage=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')
echo "Current disk usage: $disk_usage%"

if (( disk_usage >= DISK_THRESHOLD )); then
  send_alert "Disk" "$disk_usage"
fi
#!/bin/bash
##########################################
#AUTHOR: Sampath
# This script will display the resources like CPU, Memory & Disk utilizations
# When you run this script it will contiously run shows the resources details as we used the while
# Defining the threshoalds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Function to send alert
send_alert() {
	echo "$(tput setaf 1)ALERT: $1 usage exceeded threshold! current value: $2%$(tput sgr0)"
}
while true; do
  # Monitor CPU
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  cpu_usage=${cpu_usage%.*}
  if ((cpu_usage >= CPU_THRESHOLD)); then
    send_alert "CPU" "$cpu_usage"
  fi

  # Monitor memory
  memory_usage=$(free | awk '/Mem/ {printf("%3.1f", ($3/$2) * 100)}')
  memory_usage=${memory_usage%.*}
  if ((memory_usage >= MEMORY_THRESHOLD)); then
    send_alert "Memory" "$memory_usage"
  fi

  # Monitor disk
  disk_usage=$(df -h / | awk '/\// {print $(NF-1)}')
  disk_usage=${disk_usage%?}
  if ((disk_usage >= DISK_THRESHOLD)); then
    send_alert "Disk" "$disk_usage"
  fi

  # Display current stats
  clear
  echo "Resource Usage:"
  echo "CPU: $cpu_usage%"
  echo "Memory: $memory_usage%"
  echo "Disk: $disk_usage%"
  sleep 2
done
