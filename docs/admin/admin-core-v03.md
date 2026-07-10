# Admin Core v0.3

## Objetivo

Criar o fluxo de restart planejado do servidor Project Zomboid B-42, com avisos antecipados para evitar que jogadores sejam pegos longe da base, em evento, loot run ou comboio.

## Status

- [x] Script de teste de restart planejado criado
- [x] Script real de restart planejado criado
- [x] Teste com intervalos curtos validado
- [x] Servidor reiniciou corretamente
- [x] Portas `16261` e `16262` voltaram após restart
- [x] Scripts commitados e enviados ao GitHub

## Scripts criados

### Restart planejado real

Arquivo:

`scripts/scheduled-restart.sh`

Uso:

`./scripts/scheduled-restart.sh`

Fluxo:

1. Envia aviso de 1 hora.
2. Aguarda 30 minutos.
3. Envia aviso de 30 minutos.
4. Aguarda 15 minutos.
5. Envia aviso de 15 minutos.
6. Aguarda 10 minutos.
7. Envia aviso de 5 minutos.
8. Aguarda 4 minutos.
9. Envia aviso de 1 minuto.
10. Aguarda 1 minuto.
11. Executa `restart-server.sh`.

Tempo total:

1 hora.

## Mensagens usadas

Aviso de 1 hora:

`[RESTART] O servidor será reiniciado em 1 hora. Evite iniciar viagens longas, eventos ou saques demorados.`

Aviso de 30 minutos:

`[RESTART] O servidor será reiniciado em 30 minutos. Organize seu retorno e finalize atividades de risco.`

Aviso de 15 minutos:

`[RESTART] O servidor será reiniciado em 15 minutos. Guarde itens importantes e vá para um local seguro.`

Aviso de 5 minutos:

`[RESTART] O servidor será reiniciado em 5 minutos. Finalize tudo imediatamente.`

Aviso de 1 minuto:

`[RESTART] O servidor será reiniciado em 1 minuto. Desconecte-se em segurança.`

## Script de teste

Arquivo:

`scripts/test-scheduled-restart.sh`

Uso:

`./scripts/test-scheduled-restart.sh`

Objetivo:

Validar o fluxo de restart planejado sem precisar esperar 1 hora.

Fluxo testado:

1. Aviso de 60 segundos.
2. Aviso de 30 segundos.
3. Aviso de 15 segundos.
4. Aviso de 5 segundos.
5. Aviso de 1 segundo.
6. Restart automático.

Resultado validado:

- Mensagens enviadas via `send-command.sh`.
- Restart executado via `restart-server.sh`.
- Servidor encerrou.
- Servidor subiu novamente.
- Portas `16261` e `16262` voltaram.

## Decisões técnicas

- Restart planejado real deve avisar com 1 hora de antecedência.
- O primeiro aviso não deve ser de 15 minutos, pois jogadores podem estar longe da base.
- O script real não deve ser executado durante desenvolvimento sem necessidade, pois demora 1 hora.
- O script de teste deve ser usado para validar alterações futuras.
- Em produção, esse fluxo pode ser acionado manualmente pela staff ou agendado via cron/painel.