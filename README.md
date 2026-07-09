# Project Zomboid Server — B-42 Lab

Repositório técnico para desenvolvimento, documentação e operação de um servidor de Project Zomboid focado na Build 42.

## Objetivo

Construir um servidor de Project Zomboid escalável, estável e com identidade própria, usando a B-42 como base para:

- testes de infraestrutura;
- versionamento de configurações;
- criação futura de mods próprios;
- mapas customizados;
- eventos dinâmicos;
- integração com Discord;
- documentação operacional.

## Status atual

Etapa atual: **Etapa 1 — Laboratório Local B-42**

Status: **concluída**

Documentação:

```bash
docs/etapa-1-laboratorio-local.md
```

## Estrutura do projeto

```text
configs/
  pz-b42-local/
    pz-b42-local.ini
    pz-b42-local_SandboxVars.lua
    pz-b42-local_spawnpoints.lua
    pz-b42-local_spawnregions.lua

docs/
  etapa-1-laboratorio-local.md

scripts/
  start-server.sh
  backup-configs.sh
  reset-world.sh
```

## Scripts disponíveis

Iniciar servidor local:

```bash
./scripts/start-server.sh
```

Copiar configs atuais para o repositório:

```bash
./scripts/backup-configs.sh
```

Resetar mundo local de teste:

```bash
./scripts/reset-world.sh
```

## Decisão técnica atual

O ambiente local roda com o servidor limitado a:

```text
-Xmx2g
```

Motivo:

O notebook conseguiu rodar servidor e client B-42, mas ficou no limite de memória. Para laboratório local, o foco é validação técnica leve, não operação pública.

## Regras da fase atual

- Não instalar mods ainda.
- Não abrir servidor ao público.
- Não usar esse ambiente como produção.
- Não alterar configs sem backup.
- Toda mudança relevante deve ser documentada.
- Toda config estável deve ser commitada.

## Próxima etapa

Etapa 2 — MVP Jogável Fechado

Objetivos futuros:

- definir identidade do servidor;
- definir regras iniciais;
- testar gameplay vanilla configurado;
- avaliar mods essenciais um por um;
- montar Discord inicial;
- convidar poucos testers.
