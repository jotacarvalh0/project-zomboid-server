#!/bin/bash

SESSION_NAME="pz-b42"

if [ -z "$1" ]; then
  echo "Uso: ./scripts/send-command.sh \"comando\""
  echo "Exemplo: ./scripts/send-command.sh \"servermsg \\\"[STAFF] teste\\\"\""
  exit 1
fi

if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Sessão tmux '$SESSION_NAME' não encontrada."
  exit 1
fi

tmux send-keys -t "$SESSION_NAME" "$1" Enter

echo "Comando enviado para $SESSION_NAME: $1"
