#!/bin/bash

PROJECT_DIR="$HOME/projetos/project-zomboid-server"
SESSION_NAME="pz-b42"
SERVER_NAME="pz-b42-local"

CONFIG_DIR="$HOME/Zomboid/Server"
SAVE_DIR="$HOME/Zomboid/Saves/Multiplayer/$SERVER_NAME"
DB_FILE="$HOME/Zomboid/db/$SERVER_NAME.db"
BACKUP_DIR="$PROJECT_DIR/backups/world"

TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
BACKUP_FILE="$BACKUP_DIR/${SERVER_NAME}_${TIMESTAMP}.tar.gz"

cd "$PROJECT_DIR" || exit 1

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Erro: o servidor '$SESSION_NAME' está rodando."
  echo "Para backup seguro, encerre primeiro com: ./scripts/stop-server.sh"
  exit 1
fi

if [ ! -d "$SAVE_DIR" ]; then
  echo "Erro: save não encontrado em: $SAVE_DIR"
  exit 1
fi

if [ ! -f "$DB_FILE" ]; then
  echo "Erro: banco não encontrado em: $DB_FILE"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_FILE" \
  -C "$HOME" \
  "Zomboid/Server/${SERVER_NAME}.ini" \
  "Zomboid/Server/${SERVER_NAME}_SandboxVars.lua" \
  "Zomboid/Server/${SERVER_NAME}_spawnpoints.lua" \
  "Zomboid/Server/${SERVER_NAME}_spawnregions.lua" \
  "Zomboid/Saves/Multiplayer/${SERVER_NAME}" \
  "Zomboid/db/${SERVER_NAME}.db"

echo "Backup criado:"
echo "$BACKUP_FILE"

du -h "$BACKUP_FILE"
