# Etapa 1 — Laboratório Local B-42

## Objetivo

Criar um ambiente local de desenvolvimento para o servidor de Project Zomboid B-42, com servidor dedicado, configs versionadas, scripts básicos e processo seguro de reset.

## Status

- [x] Repositório Git criado
- [x] Push inicial realizado
- [x] SteamCMD instalado
- [x] Servidor dedicado B-42 baixado
- [x] Servidor iniciado localmente
- [x] Memória ajustada para `-Xmx2g`
- [x] Portas `16261` e `16262` validadas
- [x] Cliente conectou via `127.0.0.1`
- [x] Personagem criado
- [x] Spawn no mundo realizado
- [x] Servidor salvo com `save`
- [x] Servidor encerrado com `quit`
- [x] Configs copiadas para o repositório
- [x] Configs verificadas contra senhas/tokens
- [x] Configs commitadas e enviadas para o GitHub
- [x] Scripts locais criados

## Estrutura usada

Servidor dedicado B-42:

```bash
~/pz-server-b42
```

Configs do servidor:

```bash
~/Zomboid/Server
```

Repositório do projeto:

```bash
~/projetos/project-zomboid-server
```

Configs versionadas:

```bash
configs/pz-b42-local/
```

Scripts locais:

```bash
scripts/start-server.sh
scripts/backup-configs.sh
scripts/reset-world.sh
```

## Comando para iniciar o servidor

```bash
./scripts/start-server.sh
```

Esse script inicia o servidor usando:

```bash
~/pz-server-b42/start-server.sh -servername pz-b42-local
```

## Comando para copiar configs para o repositório

```bash
./scripts/backup-configs.sh
```

## Comando para resetar o mundo local

```bash
./scripts/reset-world.sh
```

Atenção: esse script apaga o save local do servidor `pz-b42-local`, mas não apaga as configs.

## Observações técnicas

O notebook conseguiu rodar servidor e client B-42, mas ficou no limite de memória.

Configuração usada no servidor local:

```text
-Xmx2g
```

Com `-Xmx4g` ou `-Xmx8g`, o ambiente local ficou pesado demais para rodar junto com o client.

## Problema encontrado: tela preta ao conectar

Durante o primeiro teste, o client entrou em tela preta após criação do personagem.

Causa provável:

- Mods ativos no client mesmo com servidor vanilla.

Solução:

- Desativar todos os mods no menu principal do Project Zomboid.
- Reiniciar o jogo.
- Conectar novamente no servidor vanilla.

Após isso, o personagem conseguiu spawnar no mundo.

## Decisão técnica

A Etapa 1 deve permanecer vanilla.

Não instalar mods, mapas customizados ou automações externas até validar completamente a base local.
