#!/bin/bash

OUTPUT_FILE="/dev/shm/ping_output.txt"

while true; do
  p1=$(ping -c 1 -W 2 8.8.8.8 2>/dev/null | grep -o 'time=[0-9.]* ms')
  [ -z "$p1" ] && p1="time=-- ms"
  
  echo "$p1"$'\n'"time=-- ms" > "$OUTPUT_FILE"

  p2=$(ping -c 1 8.8.8.8 2>/dev/null | grep -o 'time=[0-9.]* ms')
  [ -z "$p2" ] && p2="time=-- ms"

  echo "$p1"$'\n'"$p2" > "$OUTPUT_FILE"

  sleep 1
done
