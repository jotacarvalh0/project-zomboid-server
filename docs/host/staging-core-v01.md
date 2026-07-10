# Host/Staging Core v0.1

## Objetivo

Documentar o primeiro ambiente remoto de staging do servidor Project Zomboid B-42 usando o host LuraHost.

Esse ambiente será usado de forma temporária e descartável para testar o projeto fora do laboratório local.

## Status

- [x] Servidor antigo limpo
- [x] Servidor reinstalado pelo painel
- [x] Project Zomboid B-42 iniciado no host
- [x] Conexão do jogador validada
- [x] Servidor desligado após o teste
- [x] Caminhos reais do host identificados
- [x] Configs iniciais baixadas
- [x] Configs verificadas contra segredos
- [x] Configs versionadas no Git

## Função do ambiente

Este servidor não é produção.

Uso correto:

- staging remoto;
- testes de painel;
- testes de configuração;
- testes de conexão;
- testes iniciais de B-42;
- futura validação de Santa Esperança v0.1;
- futura validação de mods leves.

Não usar para:

- lançamento oficial;
- comunidade pública;
- progressão séria de jogadores;
- mundo definitivo;
- modpack pesado;
- eventos oficiais.

## Host

Painel:

```text
LuraHost
```

Nome visual temporário:

```text
Nova Fronteira Beta
```

Endereço exibido no painel:

```text
66.92.160.4:41025
```

Node exibido no painel:

```text
Iris - AMD Ryzen
```

## Configuração de inicialização

Egg atual:

```text
Project Zomboid
```

Beta Steam:

```text
unstable
```

Nome do save/config:

```text
StagingB42
```

Máximo de jogadores:

```text
8
```

Atualização automática Steam:

```text
1
```

## Caminhos reais do LuraHost

Diretório base do container:

```text
/home/container
```

Cache usado pelo Project Zomboid:

```text
/home/container/.cache
```

Configs do servidor:

```text
/home/container/.cache/Server
```

Save multiplayer:

```text
/home/container/.cache/Saves/Multiplayer/StagingB42
```

Banco do servidor:

```text
/home/container/.cache/db/StagingB42.db
```

Logs:

```text
/home/container/.cache/Logs
```

Workshop:

```text
/home/container/.cache/Workshop
```

## Arquivos de configuração remotos

Arquivos encontrados em:

```text
/home/container/.cache/Server
```

Lista:

```text
StagingB42.ini
StagingB42_SandboxVars.lua
StagingB42_spawnpoints.lua
StagingB42_spawnregions.lua
```

## Cópia versionada no repositório

As configs iniciais do staging remoto foram copiadas para:

```text
configs/staging-b42/
```

Arquivos versionados:

```text
configs/staging-b42/StagingB42.ini
configs/staging-b42/StagingB42_SandboxVars.lua
configs/staging-b42/StagingB42_spawnpoints.lua
configs/staging-b42/StagingB42_spawnregions.lua
```

## Checagem de segurança

Comando usado para verificar possíveis segredos:

```bash
grep -RniE "password|rcon|admin|token|secret|key" configs/staging-b42
```

Resultado importante:

```text
RCONPassword=
DiscordToken=
Password=
```

Nenhuma senha, token ou segredo preenchido foi versionado.

## Diferença entre laboratório local e LuraHost

Laboratório local:

```text
~/Zomboid/Server
~/Zomboid/Saves
~/Zomboid/db
```

LuraHost:

```text
/home/container/.cache/Server
/home/container/.cache/Saves
/home/container/.cache/db
```

## Decisões técnicas

- O LuraHost será tratado como ambiente descartável até o fim do período pago.
- Os scripts locais não serão executados diretamente no LuraHost.
- O painel do LuraHost controla o processo do servidor.
- Não assumir disponibilidade de `tmux`, `sudo` ou estrutura local.
- Scripts para host deverão ser criados separadamente, se necessário.
- Antes de alterar configs no host, baixar e versionar o estado atual.
- Antes de testar Santa Esperança no host, manter backup local e remoto.
- Não usar esse ambiente como produção.
