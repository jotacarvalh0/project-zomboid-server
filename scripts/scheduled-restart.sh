#!/bin/bash

PROJECT_DIR="$HOME/projetos/project-zomboid-server"
SESSION_NAME="pz-b42"

cd "$PROJECT_DIR" || exit 1

if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Sessão tmux '$SESSION_NAME' não encontrada."
  echo "Inicie o servidor antes com: ./scripts/start-tmux-server.sh"
  exit 1
fi

echo "Iniciando restart planejado com avisos."

./scripts/send-command.sh 'servermsg "[RESTART] O servidor será reiniciado em 1 hora. Evite iniciar viagens longas, eventos ou saques demorados."'
sleep 1800

./scripts/send-command.sh 'servermsg "[RESTART] O servidor será reiniciado em 30 minutos. Organize seu retorno e finalize atividades de risco."'
sleep 900

./scripts/send-command.sh 'servermsg "[RESTART] O servidor será reiniciado em 15 minutos. Guarde itens importantes e vá para um local seguro."'
sleep 600

./scripts/send-command.sh 'servermsg "[RESTART] O servidor será reiniciado em 5 minutos. Finalize tudo imediatamente."'
sleep 240

./scripts/send-command.sh 'servermsg "[RESTART] O servidor será reiniciado em 1 minuto. Desconecte-se em segurança."'
sleep 60

./scripts/restart-server.sh
