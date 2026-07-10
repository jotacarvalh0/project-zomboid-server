#!/bin/bash

SESSION_NAME="pz-b42"
PROJECT_DIR="$HOME/projetos/project-zomboid-server"

cd "$PROJECT_DIR" || exit 1

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  ./scripts/send-command.sh 'servermsg "[RESTART] Reinício iniciado. O mundo será salvo antes do desligamento."'

  sleep 2

  ./scripts/send-command.sh "save"

  sleep 3

  ./scripts/send-command.sh "quit"

  echo "Aguardando servidor encerrar..."

  for i in {1..30}; do
    if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
      echo "Servidor encerrado."
      break
    fi

    sleep 1
  done

  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Erro: servidor ainda está rodando após 30 segundos."
    echo "Verifique com: tmux attach -t $SESSION_NAME"
    exit 1
  fi
else
  echo "Sessão '$SESSION_NAME' não estava rodando. Iniciando servidor..."
fi

./scripts/start-tmux-server.sh
