#!/bin/bash

PROJECT_DIR="$HOME/projetos/project-zomboid-server"
SESSION_NAME="pz-b42"

cd "$PROJECT_DIR" || exit 1

if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Sessão tmux '$SESSION_NAME' não encontrada."
  echo "Inicie o servidor antes com: ./scripts/start-tmux-server.sh"
  exit 1
fi

echo "Iniciando teste de restart planejado..."

./scripts/send-command.sh 'servermsg "[RESTART] TESTE: servidor será reiniciado em 60 segundos."'
sleep 30

./scripts/send-command.sh 'servermsg "[RESTART] TESTE: servidor será reiniciado em 30 segundos."'
sleep 15

./scripts/send-command.sh 'servermsg "[RESTART] TESTE: servidor será reiniciado em 15 segundos."'
sleep 10

./scripts/send-command.sh 'servermsg "[RESTART] TESTE: servidor será reiniciado em 5 segundos."'
sleep 4

./scripts/send-command.sh 'servermsg "[RESTART] TESTE: servidor será reiniciado em 1 segundo."'
sleep 1

./scripts/restart-server.sh
