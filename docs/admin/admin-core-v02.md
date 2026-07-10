# Admin Core v0.2

## Objetivo

Criar a primeira automação local administrativa do servidor Project Zomboid B-42 usando `tmux` e scripts shell.

Esta versão permite iniciar, parar, reiniciar e enviar comandos ao servidor sem depender de digitar tudo manualmente no console.

## Status

- [x] `tmux` instalado
- [x] Servidor iniciado em sessão `tmux`
- [x] Script para enviar comandos criado
- [x] `servermsg` enviado via script
- [x] Script de encerramento seguro criado
- [x] Script de restart criado
- [x] Portas `16261` e `16262` validadas após restart
- [x] Scripts commitados e enviados ao GitHub

## Sessão tmux

Nome da sessão usada:

`pz-b42`

Comando manual testado:

`tmux new -s pz-b42 './scripts/start-server.sh'`

Para sair da sessão sem desligar o servidor:

`Ctrl + B`, depois `D`

Para voltar aos logs:

`tmux attach -t pz-b42`

Para listar sessões:

`tmux ls`

## Scripts criados

### Iniciar servidor em tmux

Arquivo:

`scripts/start-tmux-server.sh`

Uso:

`./scripts/start-tmux-server.sh`

Função:

- cria a sessão `pz-b42`;
- inicia o servidor em background;
- evita iniciar duplicado se a sessão já existir.

## Enviar comando ao servidor

Arquivo:

`scripts/send-command.sh`

Uso:

`./scripts/send-command.sh 'servermsg "[STAFF] mensagem"'`

Comando validado:

`servermsg "[STAFF] Teste enviado via send-command.sh."`

Resultado:

A mensagem apareceu no chat global do servidor.

## Encerrar servidor com segurança

Arquivo:

`scripts/stop-server.sh`

Uso:

`./scripts/stop-server.sh`

Fluxo:

1. Envia `save`.
2. Aguarda alguns segundos.
3. Envia `quit`.
4. O servidor encerra e a sessão `tmux` desaparece.

Resultado validado:

- `save` enviado;
- `quit` enviado;
- servidor encerrado;
- `tmux ls` retornou sem sessão ativa.

## Reiniciar servidor

Arquivo:

`scripts/restart-server.sh`

Uso:

`./scripts/restart-server.sh`

Fluxo:

1. Envia aviso global de restart.
2. Envia `save`.
3. Envia `quit`.
4. Aguarda a sessão `tmux` encerrar.
5. Inicia o servidor novamente com `start-tmux-server.sh`.

Resultado validado:

- aviso enviado;
- mundo salvo;
- servidor encerrado;
- servidor iniciado novamente;
- portas `16261` e `16262` abertas após o restart.

## Portas validadas

Comando usado:

`ss -lunpt | grep -E "16261|16262"`

Resultado esperado:

- `0.0.0.0:16261`
- `0.0.0.0:16262`

## Decisões técnicas

- `tmux` será usado no ambiente local para manter o servidor rodando em background.
- Scripts locais devem ser simples, legíveis e versionados.
- Automação de restart com avisos longos ainda ficará para versão futura.
- O restart atual é técnico/imediato, usado apenas por staff em ambiente de teste.
- Em produção, o fluxo deve incluir avisos de 1h, 30min, 15min, 5min e 1min.