#!/bin/bash

PROJECT_DIR="$HOME/projetos/project-zomboid-server"
SERVER_CONFIG_DIR="$HOME/Zomboid/Server"
SERVER_NAME="pz-b42-local"
DEST_DIR="$PROJECT_DIR/configs/$SERVER_NAME"

mkdir -p "$DEST_DIR"

cp "$SERVER_CONFIG_DIR/$SERVER_NAME.ini" "$DEST_DIR/"
cp "$SERVER_CONFIG_DIR/${SERVER_NAME}_SandboxVars.lua" "$DEST_DIR/"
cp "$SERVER_CONFIG_DIR/${SERVER_NAME}_spawnpoints.lua" "$DEST_DIR/"
cp "$SERVER_CONFIG_DIR/${SERVER_NAME}_spawnregions.lua" "$DEST_DIR/"

echo "Configs copiadas para: $DEST_DIR"
