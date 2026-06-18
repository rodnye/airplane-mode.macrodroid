#!/bin/bash

STATUS_FILE="/dev/shm/airplanemode_status.txt"

GATEWAY=$(ip route | grep default | awk '{print $3}')
URL="http://${GATEWAY}:8080/plane"

echo "sended" > "$STATUS_FILE"
alert -t 3000 "Activando modo avion" "La señal se está enviando actualmente..."

curl -s -o /dev/null "$URL"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    alert -t 3000 "Activando modo avion" "Señal enviada correctamente."
else
    alert -t 3000 -u critical "Transaccion fallida" "No se pudo contactar con el servidor."
fi

sleep 12

echo "ready" > "$STATUS_FILE"
