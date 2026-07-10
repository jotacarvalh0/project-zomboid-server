# Admin Core v0.1

## Objetivo

Criar a base administrativa inicial do servidor Project Zomboid B-42.

Esta fase ainda é manual. O objetivo é padronizar mensagens, comandos, restart, eventos e procedimentos da staff antes de automatizar qualquer coisa.

## Status

- [x] Mensagem de boas-vindas customizada
- [x] Padrão de mensagens administrativas
- [x] Teste de anúncio global
- [x] Checklist manual de restart
- [ ] Checklist de evento
- [x] Checklist de encerramento seguro
- [ ] Documentação de comandos úteis

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

## Decisões técnicas

- O Admin Core deve começar manual.
- Automação só entra depois que o fluxo manual estiver validado.
- Mensagens devem ser curtas para caberem bem no chat do Project Zomboid.
- Lore não deve ficar hardcoded em scripts definitivos nesta fase.
- Sistemas devem ser genéricos para permitir mudanças futuras na lore.
