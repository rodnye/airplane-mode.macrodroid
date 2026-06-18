#!/bin/bash

SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATUS_FILE="/dev/shm/airplanemode_status.txt"
PING_FILE="/dev/shm/ping_output.txt"

# Run background ping
[ -f "$PING_FILE" ] || { \
  touch "$PING_FILE"; 
  { bash "$SOURCE/../scripts/ping.service.sh" & echo ""; } 
}

[ -f "$STATUS_FILE" ] || echo "ready" > "$STATUS_FILE"

STATUS=$(cat "$STATUS_FILE")

echo '<tool>Ping:'

pings=$(cat "$PING_FILE")

if [ "$STATUS" = "sended" ]; then
  echo 'Espere un poco...</tool>'
  echo '<icon>network-cellular-acquiring</icon>'
  echo '<iconclick>notify-send -t 3000 -u critical "Activando modo avion" "Ya la señal fue enviada... espere" </iconclick>'

else 
  echo "$pings</tool>"
  echo '<icon>network-cellular-signal-good</icon>' 
  echo "<iconclick>bash $SOURCE/../scripts/signal.service.sh</iconclick>"
  echo "<txt>$pings</txt>"
fi
