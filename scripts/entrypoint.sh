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

mkdir -p /data/plugins/SimpleClaimSystem
cp -r /image/plugin-configs/SimpleClaimSystem/* /data/plugins/SimpleClaimSystem/

echo "[wrapper] Ejecutando script original /start..."
exec /start "$@"
