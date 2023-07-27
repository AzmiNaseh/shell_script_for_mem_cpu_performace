#!/bin/sh

filename=$HOME/$(date +"%Y-%m-%d-%H:%M")-mem_cpu.csv


echo "$filename"
echo   "epoch_time","cpu_avg(%)","ram_active(G)","disk_space_used(%)","swap_used(M)"  >> "$filename"

while true
do

cmd_cpu=$(top -bn2 | grep '%Cpu' | tail -1 | grep -P '(....|...) id,'|awk '{print 100-$8 "%"}'| cut -d "%" -f1)
cmd_ram=$(free -m | head -2 | tail -1 | awk '{print $3}')
cmd_timestamp=$(date +'%s')
cmd_diskspace=$(df -h /| awk '{print $5}' | tail -1 |cut -d '%' -f1)
cmd_swap=$(vmstat -s | grep 'used swap' | awk '{print $1}')


echo "$cmd_timestamp,$cmd_cpu,$cmd_ram,$cmd_diskspace,$cmd_swap" >> "$filename"


done

