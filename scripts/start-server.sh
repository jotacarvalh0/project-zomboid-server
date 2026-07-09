#!/bin/bash

SERVER_DIR="$HOME/pz-server-b42"
SERVER_NAME="pz-b42-local"

cd "$SERVER_DIR" || exit 1

./start-server.sh -servername "$SERVER_NAME"
