# Santa Esperança v0.1 — Rosewood

## Função

Santa Esperança é a primeira cidade-refúgio da Nova Fronteira. Ela ocupa Rosewood e funciona como área PvE protegida, com spawn inicial, onboarding, missões, comércio básico e núcleo comunitário.

## Decisões

- Rosewood será PvE.
- PvP será bloqueado pelo jogo dentro da zona da cidade.
- A igreja será o ponto inicial de spawn.
- A Irmã Helena ficará na igreja como NPC narrativo de onboarding.
- A escola será o núcleo funcional da cidade.
- Igreja e escola não devem ter spawn de zumbis.
- Caso zumbis entrem nessas áreas, o sistema deve limpar/remover.

## Spawn inicial

Ponto exato de spawn:

- X: 8124
- Y: 11549
- Z: 0

Formato aproximado para spawnpoints:

- worldX: 27
- worldY: 38
- posX: 24
- posY: 149
- posZ: 0

## Irmã Helena

Local:

- X: 8122
- Y: 11541
- Z: 0

Função:

- Explicar a lore.
- Explicar regras.
- Avisar que Santa Esperança é PvE.
- Direcionar o jogador para a escola.
- Apresentar primeira missão.

## Zona PvE — Santa Esperança

A zona será dividida em dois retângulos.

### Santa Esperança — Oeste

- X1: 7931
- Y1: 11387
- X2: 8161
- Y2: 11779

### Santa Esperança — Leste

- X1: 8161
- Y1: 11537
- X2: 8437
- Y2: 11779

## Zona sem zumbis — Igreja

- X1: 8112
- Y1: 11533
- X2: 8146
- Y2: 11572

## Zona sem zumbis — Escola

- X1: 8310
- Y1: 11581
- X2: 8383
- Y2: 11656

## Mensagens NF_UI

### Ao entrar em Santa Esperança

"Você entrou em Santa Esperança. Área civil protegida. PvP bloqueado."

### Ao sair de Santa Esperança

"A proteção de Santa Esperança termina aqui."

## Próximos pontos de interação

- Mercado comunitário.
- Enfermaria.
- Mural de missões.
- Depósito de doações.
- Posto de gasolina controlado.
- Registro de clãs.
- Rádio da cidade.
## Validação — Zona PvE

Data:
2026-07-09

Zonas Non-PVP criadas no servidor:

### Santa Esperança — Oeste

- X1: 7931
- Y1: 11387
- X2: 8161
- Y2: 11779

### Santa Esperança — Leste

- X1: 8161
- Y1: 11537
- X2: 8437
- Y2: 11779

Resultado dos testes:

- Player recebeu aviso de zona Non-PVP.
- PvP foi bloqueado dentro de Santa Esperança.
- PvP funcionou normalmente fora da cidade.

Status:
Aprovado.

Observação:
A zona foi criada manualmente pelo painel admin do Project Zomboid. Futuramente, avaliar forma de tornar isso reproduzível por script/mod/config.

## Validação — Zona PvE

Data:
2026-07-15

Zonas Non-PVP criadas no servidor:

### Santa Esperança — Oeste

- X1: 7931
- Y1: 11387
- X2: 8161
- Y2: 11779

### Santa Esperança — Leste

- X1: 8161
- Y1: 11537
- X2: 8437
- Y2: 11779

Resultado dos testes:

- Player recebeu aviso de zona Non-PVP.
- PvP foi bloqueado dentro de Santa Esperança.
- PvP funcionou normalmente fora de Santa Esperança.

Status:
Aprovado.

Observação:
A zona foi criada manualmente pelo painel admin do Project Zomboid. Futuramente, avaliar forma de tornar isso reproduzível por script, mod ou configuração versionada.
