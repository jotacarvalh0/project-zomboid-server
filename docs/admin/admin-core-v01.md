# Admin Core v0.1

## Objetivo

Criar a base administrativa inicial do servidor Project Zomboid B-42.

Esta fase ainda é manual. O objetivo é padronizar mensagens, comandos, restart, eventos e procedimentos da staff antes de automatizar qualquer coisa.

## Status

- [x] Mensagem de boas-vindas customizada
- [x] Padrão de mensagens administrativas
- [x] Teste de anúncio global
- [x] Checklist manual de restart
- [x] Checklist de evento
- [x] Checklist de encerramento seguro
- [x] Documentação de comandos úteis

## Padrão de mensagens

### Restart

```text
[RESTART] O servidor será reiniciado em 1 hora. Evite iniciar viagens longas, eventos ou saques demorados.
[RESTART] O servidor será reiniciado em 30 minutos. Organize seu retorno e finalize atividades de risco.
[RESTART] O servidor será reiniciado em 15 minutos. Guarde itens importantes e vá para um local seguro.
[RESTART] O servidor será reiniciado em 5 minutos. Finalize tudo imediatamente.
[RESTART] O servidor será reiniciado em 1 minuto. Desconecte-se em segurança.
[RESTART] Reinício iniciado. O mundo será salvo antes do desligamento.
```

### Evento

```text
[EVENTO] Um evento começará em 20 minutos. Fique atento ao Discord para regras e localização.
[EVENTO] Evento iniciado. Siga as regras informadas pela staff.
[EVENTO] Evento encerrado. Obrigado pela participação.
```

### Staff

```text
[STAFF] Atenção: este é um ambiente de testes. Bugs devem ser reportados.
[STAFF] Alterações podem ocorrer sem aviso durante a fase de desenvolvimento.
```

### Lore

```text
[RÁDIO] As cidades ainda respiram. O resto do mapa pertence aos mortos — e aos vivos piores que eles.
[RÁDIO] Uma transmissão fraca ecoa no rádio: fiquem longe das estradas depois do anoitecer.
```

## Checklist manual de restart

1. Avisar jogadores com antecedência.
2. Enviar aviso de 1 hora.
3. Enviar aviso de 30 minutos.
4. Enviar aviso de 15 minutos.
5. Enviar aviso de 5 minutos.
6. Enviar aviso de 1 minuto.
7. Executar `save`.
8. Confirmar `World saved`.
9. Executar `quit`.
10. Confirmar `Shutdown handling finished`.
11. Fazer backup se necessário.
12. Subir servidor novamente.

## Checklist manual de evento

1. Definir nome do evento.
2. Definir objetivo do evento.
3. Definir local.
4. Definir horário de início.
5. Definir duração estimada.
6. Definir se terá PvP.
7. Definir regras especiais.
8. Definir recompensa.
9. Avisar no Discord.
10. Avisar no jogo com `servermsg`.
11. Confirmar presença da staff responsável.
12. Iniciar evento.
13. Encerrar evento com anúncio global.
14. Registrar problemas, bugs e feedback.

## Template de evento

```md
Nome do evento:
Data:
Horário:
Local:
Duração:
PvP:
Regras:
Recompensa:
Staff responsável:
Risco técnico:
Observações:

## Comandos já testados

### Salvar mundo

```text
save
```

Resultado esperado:

```text
World saved
```

### Encerrar servidor

```text
quit
```

Resultado esperado:

```text
Shutdown handling finished
```

### Anúncio global

```text
servermsg "[STAFF] Teste de anúncio global do Admin Core v0.1."
```

Resultado esperado:

```text
A mensagem aparece no chat global para jogadores conectados.
```

## Comandos a testar

Nenhum comando pendente nesta versão.

## Comandos úteis da staff

### Comandos validados

#### Enviar anúncio global

```text
servermsg "[STAFF] mensagem"
```

Uso:

- avisos administrativos;
- alertas de restart;
- início e fim de evento;
- mensagens de teste.

#### Salvar mundo

```text
save
```

Uso:

- antes de restart;
- antes de encerramento;
- antes de manutenção;
- antes de backup manual.

#### Encerrar servidor

```text
quit
```

Uso:

- depois de `save`;
- em encerramento planejado;
- em restart manual.

### Comandos a validar futuramente

Estes comandos ainda precisam ser testados na B-42 local antes de entrarem no procedimento oficial:

```text
help
players
kickuser
banuser
unbanuser
grantadmin
removeadmin
additem
addvehicle
teleport
godmode
invisible
noclip
```

Observação:

Nenhum comando de punição, spawn de item, veículo ou teleporte deve ser usado em produção sem antes ser testado e documentado.

## Decisões técnicas

- O Admin Core deve começar manual.
- Automação só entra depois que o fluxo manual estiver validado.
- Mensagens devem ser curtas para caberem bem no chat do Project Zomboid.
- Lore não deve ficar hardcoded em scripts definitivos nesta fase.
- Sistemas devem ser genéricos para permitir mudanças futuras na lore.
