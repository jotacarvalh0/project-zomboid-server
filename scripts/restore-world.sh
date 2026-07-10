#!/bin/bash
set -e

PROJECT_DIR="$HOME/projetos/project-zomboid-server"
SESSION_NAME="pz-b42"
SERVER_NAME="pz-b42-local"

BACKUP_FILE="$1"

SAVE_DIR="$HOME/Zomboid/Saves/Multiplayer/$SERVER_NAME"
DB_FILE="$HOME/Zomboid/db/$SERVER_NAME.db"
SAFETY_DIR="$PROJECT_DIR/backups/restore-safety"

TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
SAFETY_FILE="$SAFETY_DIR/${SERVER_NAME}_before_restore_${TIMESTAMP}.tar.gz"

cd "$PROJECT_DIR" || exit 1

if [ -z "$BACKUP_FILE" ]; then
  echo "Uso: ./scripts/restore-world.sh caminho/do/backup.tar.gz"
  echo ""
  echo "Backups disponíveis:"
  ls -1 backups/world/*.tar.gz 2>/dev/null || echo "Nenhum backup encontrado em backups/world/"
  exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Erro: backup não encontrado:"
  echo "$BACKUP_FILE"
  exit 1
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Erro: o servidor '$SESSION_NAME' está rodando."
  echo "Para restore seguro, encerre primeiro com: ./scripts/stop-server.sh"
  exit 1
fi

echo "Validando conteúdo do backup..."

REQUIRED_PATHS=(
  "Zomboid/Server/${SERVER_NAME}.ini"
  "Zomboid/Server/${SERVER_NAME}_SandboxVars.lua"
  "Zomboid/Server/${SERVER_NAME}_spawnpoints.lua"
  "Zomboid/Server/${SERVER_NAME}_spawnregions.lua"
  "Zomboid/Saves/Multiplayer/${SERVER_NAME}/"
  "Zomboid/db/${SERVER_NAME}.db"
)

for path in "${REQUIRED_PATHS[@]}"; do
  if ! tar -tzf "$BACKUP_FILE" "$path" >/dev/null 2>&1; then
    echo "Erro: backup inválido. Caminho ausente:"
    echo "$path"
    exit 1
  fi
done

echo "Backup válido:"
echo "$BACKUP_FILE"
echo ""
echo "ATENÇÃO: este restore vai substituir:"
echo "- $SAVE_DIR"
echo "- $DB_FILE"
echo "- configs $HOME/Zomboid/Server/${SERVER_NAME}*"
echo ""
read -r -p "Digite RESTORE para continuar: " CONFIRMATION

if [ "$CONFIRMATION" != "RESTORE" ]; then
  echo "Restore cancelado."
  exit 1
fi

mkdir -p "$SAFETY_DIR"

echo "Criando backup de segurança do estado atual antes do restore..."

tar -czf "$SAFETY_FILE" \
  -C "$HOME" \
  "Zomboid/Server/${SERVER_NAME}.ini" \
  "Zomboid/Server/${SERVER_NAME}_SandboxVars.lua" \
  "Zomboid/Server/${SERVER_NAME}_spawnpoints.lua" \
  "Zomboid/Server/${SERVER_NAME}_spawnregions.lua" \
  "Zomboid/Saves/Multiplayer/${SERVER_NAME}" \
  "Zomboid/db/${SERVER_NAME}.db"

echo "Backup de segurança criado:"
echo "$SAFETY_FILE"

echo "Removendo estado atual..."

rm -rf "$SAVE_DIR"
rm -f "$DB_FILE"
rm -f "${DB_FILE}-journal"
rm -f "${DB_FILE}-wal"
rm -f "${DB_FILE}-shm"

echo "Restaurando backup..."

tar -xzf "$BACKUP_FILE" -C "$HOME"

echo "Restore concluído com sucesso."
echo ""
echo "Backup restaurado:"
echo "$BACKUP_FILE"
echo ""
echo "Backup de segurança anterior ao restore:"
echo "$SAFETY_FILE"
echo ""
echo "Para iniciar o servidor:"
echo "./scripts/start-tmux-server.sh"
