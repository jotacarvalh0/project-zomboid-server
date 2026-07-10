#!/bin/bash

PROJECT_DIR="$HOME/projetos/project-zomboid-server"

cd "$PROJECT_DIR" || exit 1

./scripts/send-command.sh "save"

sleep 3

./scripts/send-command.sh "quit"

echo "Comandos de encerramento enviados."
