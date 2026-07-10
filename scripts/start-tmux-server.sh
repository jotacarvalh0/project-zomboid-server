#!/bin/bash

SESSION_NAME="pz-b42"
PROJECT_DIR="$HOME/projetos/project-zomboid-server"

cd "$PROJECT_DIR" || exit 1

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Sessão tmux '$SESSION_NAME' já está rodando."
  echo "Use: tmux attach -t $SESSION_NAME"
  exit 0
fi

tmux new -d -s "$SESSION_NAME" "./scripts/start-server.sh"

echo "Servidor iniciado em tmux na sessão: $SESSION_NAME"
echo "Para acompanhar logs: tmux attach -t $SESSION_NAME"
