#!/bin/sh

echo "[wrapper] Reemplazando server.properties desde la imagen..."
cp -f /image/server.properties /data/server.properties

echo "[wrapper] Reemplazando ops.json desde la imagen..."
cp -f /image/ops.json /data/ops.json

echo "[wrapper] Limpiando carpeta de plugins..."
rm -rf /data/plugins/*
mkdir -p /data/plugins

echo "[wrapper] Copiando plugins desde la imagen..."
cp -r /plugins/* /data/plugins/

echo "[wrapper] Copiando datapacks al mundo con permisos correctos..."
mkdir -p /data/world/datapacks
cp -r /image/datapacks/* /data/world/datapacks/
chmod -R u+rwX,go+rX /data/world/datapacks

echo "[wrapper] Ejecutando script original /start..."

# Ejecutar el proceso principal (que incluye el chown y todo lo demás)
exec /start "$@" &

# Esperamos unos segundos para que el servidor cree las carpetas del plugin
# (esto se puede ajustar si hace falta)
sleep 10

echo "[wrapper] Preparando configuración de SimpleClaimSystem..."

CONFIG_TARGET="/data/plugins/SimpleClaimSystem/config.yml"
CONFIG_SOURCE="/image/plugin-configs/SimpleClaimSystem/config.yml"

# Solo reemplazamos config si existe el archivo en la imagen y el plugin ya creó la carpeta
if [ -d "/data/plugins/SimpleClaimSystem" ] && [ -f "$CONFIG_SOURCE" ]; then
  echo "[wrapper] Reemplazando config.yml de SimpleClaimSystem"
  cp "$CONFIG_SOURCE" "$CONFIG_TARGET"
  chmod 644 "$CONFIG_TARGET"
  chown ${UID:-1000}:${GID:-1000} "$CONFIG_TARGET"
else
  echo "[wrapper] Saltando reemplazo de config.yml - carpeta o fuente no encontrada"
fi

wait