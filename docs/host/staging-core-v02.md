# Host/Staging Core v0.2

## Objetivo

Aplicar a identidade mínima do servidor remoto de staging no LuraHost.

Essa etapa valida que uma configuração versionada no Git pode ser aplicada manualmente no host e refletir corretamente dentro do Project Zomboid B-42.

## Status

- [x] `StagingB42.ini` editado localmente
- [x] Mensagem de boas-vindas customizada criada
- [x] Nome público temporário configurado
- [x] Descrição pública temporária configurada
- [x] Alteração revisada via `git diff`
- [x] Alteração commitada no Git
- [x] Arquivo aplicado manualmente no LuraHost
- [x] Servidor remoto iniciado
- [x] Conexão no jogo validada
- [x] Mensagem exibida corretamente no chat

## Arquivo alterado

Arquivo local versionado:

```text
configs/staging-b42/StagingB42.ini
```

Arquivo remoto correspondente:

```text
/home/container/.cache/Server/StagingB42.ini
```

## Campos alterados

Nome público:

```ini
PublicName=Nova Fronteira Beta
```

Descrição pública:

```ini
PublicDescription=Servidor fechado de testes do projeto Project Zomboid B-42.
```

Mensagem de boas-vindas:

```ini
ServerWelcomeMessage=<RGB:1,0.85,0.35>Nova Fronteira Beta<LINE><LINE><RGB:1,1,1>Servidor fechado de testes B-42.<LINE>- Ambiente instavel e descartavel.<LINE>- O mundo pode ser resetado sem aviso.<LINE>- Reporte bugs para a staff.<LINE><LINE><RGB:0.8,0.9,1>As cidades ainda respiram.
```

## Mensagem exibida no jogo

```text
Nova Fronteira Beta

Servidor fechado de testes B-42.
- Ambiente instavel e descartavel.
- O mundo pode ser resetado sem aviso.
- Reporte bugs para a staff.

As cidades ainda respiram.
```

## Procedimento usado

1. Editar o arquivo local em `configs/staging-b42/StagingB42.ini`.
2. Revisar o diff.
3. Commitar a alteração.
4. Com o servidor remoto desligado, abrir o arquivo remoto no LuraHost.
5. Substituir o conteúdo de `/home/container/.cache/Server/StagingB42.ini`.
6. Salvar no painel.
7. Iniciar o servidor.
8. Conectar no jogo.
9. Validar a mensagem no chat.

## Decisões técnicas

- O Git é a fonte de verdade das configs.
- O LuraHost recebe manualmente apenas os arquivos já revisados.
- Nesta etapa foi alterado apenas `StagingB42.ini`.
- `SandboxVars`, `spawnpoints` e `spawnregions` não foram alterados.
- Nenhuma senha foi versionada.
- Senha de entrada do servidor, se usada, deve ser configurada diretamente no host, não no Git.

## Próximo cuidado de segurança

O staging remoto está acessível por IP e porta.

Antes de convidar qualquer pessoa para testar, configurar uma senha de entrada diretamente no host:

```ini
Password=
```

Essa senha não deve ser commitada no repositório.
