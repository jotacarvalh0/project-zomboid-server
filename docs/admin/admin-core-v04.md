# Admin Core v0.4

## Objetivo

Criar um processo seguro de backup offline do mundo local do servidor Project Zomboid B-42.

Esse backup será usado antes de alterações importantes no mapa, principalmente antes da edição de Santa Esperança.

## Status

- [x] Caminhos reais do save confirmados
- [x] Caminho do banco confirmado
- [x] Script `backup-world.sh` criado
- [x] Backup real executado
- [x] Conteúdo do backup validado
- [x] `.gitignore` atualizado para ignorar backups compactados
- [x] Script commitado e enviado ao GitHub

## Caminhos confirmados

Save do servidor:

```bash
~/Zomboid/Saves/Multiplayer/pz-b42-local
```

Banco do servidor:

```bash
~/Zomboid/db/pz-b42-local.db
```

Configs do servidor:

```bash
~/Zomboid/Server/pz-b42-local*
```

## Script criado

Arquivo:

```bash
scripts/backup-world.sh
```

Uso:

```bash
./scripts/backup-world.sh
```

## Segurança do backup

O script recusa rodar se a sessão `tmux` do servidor estiver ativa.

Sessão verificada:

```text
pz-b42
```

Motivo:

Evitar backup corrompido enquanto o servidor está escrevendo dados do mundo.

## Conteúdo do backup

O backup inclui:

```text
Zomboid/Server/pz-b42-local.ini
Zomboid/Server/pz-b42-local_SandboxVars.lua
Zomboid/Server/pz-b42-local_spawnpoints.lua
Zomboid/Server/pz-b42-local_spawnregions.lua
Zomboid/Saves/Multiplayer/pz-b42-local/
Zomboid/db/pz-b42-local.db
```

## Local dos backups

```bash
backups/world/
```

Exemplo de arquivo criado:

```bash
backups/world/pz-b42-local_2026-07-10_13-26-16.tar.gz
```

## Validação realizada

Comando para listar conteúdo do backup:

```bash
tar -tzf backups/world/pz-b42-local_2026-07-10_13-26-16.tar.gz | head -n 30
```

Comando para confirmar banco no backup:

```bash
tar -tzf backups/world/pz-b42-local_2026-07-10_13-26-16.tar.gz | grep "Zomboid/db"
```

Resultado esperado:

```text
Zomboid/db/pz-b42-local.db
```

## Decisões técnicas

- Backups compactados não serão versionados no Git.
- O Git versiona apenas o script de backup.
- Backups devem ser feitos antes de editar mapa, cidade, spawn, safezone ou estrutura administrativa.
- Antes de Santa Esperança v0.1, sempre executar `backup-world.sh`.
- Em produção, esse fluxo deverá ser adaptado para backup automático e armazenamento externo.
