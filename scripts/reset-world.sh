#!/bin/bash

SERVER_NAME="pz-b42-local"
SAVE_DIR="$HOME/Zomboid/Saves/Multiplayer"
DB_DIR="$HOME/Zomboid/db"

echo "ATENÇÃO: isso vai apagar o mundo local do servidor: $SERVER_NAME"
echo "Configs em ~/Zomboid/Server NÃO serão apagadas."
echo ""

read -p "Digite RESET para continuar: " confirm

if [ "$confirm" != "RESET" ]; then
  echo "Cancelado."
  exit 1
fi

rm -rf "$SAVE_DIR/$SERVER_NAME"
rm -f "$DB_DIR/$SERVER_NAME.db"
rm -f "$DB_DIR/$SERVER_NAME.db-journal"

echo "Mundo local resetado para o servidor: $SERVER_NAME"
