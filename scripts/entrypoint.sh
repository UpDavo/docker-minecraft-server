#!/bin/sh

echo "[wrapper] Reemplazando server.properties desde la imagen..."
cp -f /image/server.properties /data/server.properties

echo "[wrapper] Limpiando carpeta de plugins..."
rm -rf /data/plugins/*
mkdir -p /data/plugins

echo "[wrapper] Copiando plugins desde la imagen..."
cp -r /plugins/* /data/plugins/

echo "[wrapper] Ejecutando script original /start..."
exec /start "$@"
