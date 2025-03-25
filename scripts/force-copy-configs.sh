#!/bin/sh

echo "[init] Sobrescribiendo server.properties desde la imagen a /data"

cp -f /image/server.properties /data/server.properties
