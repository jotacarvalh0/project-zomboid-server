# Admin Core v0.5

## Objetivo

Criar um processo seguro de restore offline do mundo local do servidor Project Zomboid B-42.

Esse restore será usado para voltar o servidor para um backup anterior caso uma alteração no mapa, cidade, spawn, safezone ou configuração quebre o mundo.

## Status

- [x] Script `restore-world.sh` criado
- [x] Sintaxe validada
- [x] Trava sem argumento testada
- [x] Trava de arquivo inexistente testada
- [x] Validação de conteúdo do backup testada
- [x] Cancelamento por confirmação incorreta testado
- [x] Restore real executado
- [x] Backup de segurança criado antes do restore
- [x] Servidor iniciado com sucesso após o restore
- [x] Script commitado e enviado ao GitHub

## Script criado

Arquivo:

```bash
scripts/restore-world.sh
```

Uso:

```bash
./scripts/restore-world.sh caminho/do/backup.tar.gz
```

Exemplo:

```bash
./scripts/restore-world.sh backups/world/pz-b42-local_2026-07-10_13-26-16.tar.gz
```

## Travas de segurança

O script recusa executar restore quando:

- nenhum arquivo de backup é informado;
- o arquivo informado não existe;
- a sessão `tmux` do servidor ainda está rodando;
- o backup não contém os arquivos obrigatórios;
- o usuário não digita exatamente `RESTORE` na confirmação.

## Sessão protegida

Sessão `tmux` verificada:

```text
pz-b42
```

Se a sessão estiver ativa, o restore é bloqueado.

Motivo:

Evitar sobrescrever arquivos enquanto o servidor está rodando ou escrevendo dados do mundo.

## Arquivos obrigatórios no backup

O restore valida a existência dos seguintes caminhos dentro do `.tar.gz`:

```text
Zomboid/Server/pz-b42-local.ini
Zomboid/Server/pz-b42-local_SandboxVars.lua
Zomboid/Server/pz-b42-local_spawnpoints.lua
Zomboid/Server/pz-b42-local_spawnregions.lua
Zomboid/Saves/Multiplayer/pz-b42-local/
Zomboid/db/pz-b42-local.db
```

## Fluxo do restore

1. Recebe o caminho do backup.
2. Confirma que o arquivo existe.
3. Confirma que o servidor está desligado.
4. Valida o conteúdo do backup.
5. Mostra os caminhos que serão substituídos.
6. Exige confirmação digitando `RESTORE`.
7. Cria backup de segurança do estado atual.
8. Remove o save e banco atuais.
9. Extrai o backup dentro de `~/`.
10. Finaliza mostrando o backup restaurado e o backup de segurança criado.

## Backup de segurança pré-restore

Antes de sobrescrever o mundo atual, o script cria um backup de segurança em:

```bash
backups/restore-safety/
```

Exemplo criado durante o teste:

```bash
backups/restore-safety/pz-b42-local_before_restore_2026-07-10_13-52-24.tar.gz
```

Esse arquivo também não é versionado no Git.

## Testes realizados

Teste sem argumento:

```bash
./scripts/restore-world.sh
```

Resultado esperado:

```text
Uso: ./scripts/restore-world.sh caminho/do/backup.tar.gz
Backups disponíveis:
```

Teste com arquivo inexistente:

```bash
./scripts/restore-world.sh backups/world/nao-existe.tar.gz
```

Resultado esperado:

```text
Erro: backup não encontrado:
backups/world/nao-existe.tar.gz
```

Teste de cancelamento:

```bash
echo "CANCELAR" | ./scripts/restore-world.sh backups/world/pz-b42-local_2026-07-10_13-26-16.tar.gz
```

Resultado esperado:

```text
Backup válido:
Restore cancelado.
```

Teste real de restore:

```bash
echo "RESTORE" | ./scripts/restore-world.sh backups/world/pz-b42-local_2026-07-10_13-26-16.tar.gz
```

Resultado validado:

```text
Restore concluído com sucesso.
```

## Validação após restore

Após o restore, o servidor foi iniciado com:

```bash
./scripts/start-tmux-server.sh
```

O log confirmou:

```text
*** SERVER STARTED ****
```

## Observação

Durante a subida do servidor apareceu o aviso:

```text
initSpawnBuildings: no room or building at 10629,9658,0
```

Esse aviso não bloqueou o servidor.

Ele será investigado posteriormente durante a revisão de spawnpoints e a preparação da Santa Esperança.

## Decisões técnicas

- Backup sem restore testado não é suficiente.
- Todo restore deve ser feito com o servidor desligado.
- Todo restore cria um backup de segurança antes de sobrescrever o estado atual.
- Backups de restore não são versionados no Git.
- Antes de editar Santa Esperança v0.1, deve existir pelo menos um backup validado e um restore já testado.
- Em produção, esse processo deverá ser adaptado para rotina automatizada, armazenamento externo e política de retenção.
