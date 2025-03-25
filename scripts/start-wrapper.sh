#!/bin/sh

echo "[wrapper] Reemplazando server.properties desde la imagen..."
cp -f /image/server.properties /data/server.properties

echo "[wrapper] Copiando plugins si no existen..."
cp -n /plugins/* /data/plugins/ 2>/dev/null || true

echo "[wrapper] Ejecutando script original /start..."
exec /start "$@"
