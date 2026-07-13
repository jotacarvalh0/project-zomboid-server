# Gameplay Core v0.1 — Nova Fronteira

## Objetivo

Definir a base global de gameplay do servidor Nova Fronteira para beta fechado no Project Zomboid B-42.

Esta etapa configura o comportamento geral do servidor, sem ainda criar as safezones de Santa Esperança e Porto Seco.

---

## Identidade

Nome público:

Nova Fronteira

Descrição:

Servidor brasileiro de Project Zomboid B-42. Beta fechado da comunidade Nova Fronteira.

---

## Acesso

Configuração escolhida:

- Open=false
- AutoCreateUserInWhiteList=false

Decisão:

O beta fechado usará whitelist real.

Isso significa que novos jogadores não entram automaticamente. A staff precisa liberar/criar o acesso antes do jogador conseguir conectar.

Motivo:

- Evitar entrada aleatória
- Proteger o beta fechado
- Controlar comunidade inicial
- Reduzir grief e bagunça nos testes

---

## Players

Configuração escolhida:

- MaxPlayers=16

Motivo:

O LuraHost será usado como staging/beta fechado. Antes de mirar 30 jogadores, o servidor precisa ser validado com menos gente.

---

## PvP

Configuração escolhida:

- PVP=true

Decisão:

PvP fica ligado globalmente.

As cidades-refúgio serão protegidas depois por safezones manuais:

- Santa Esperança em Rosewood
- Porto Seco em parte de Muldraugh

Fora das safezones, PvP será permitido.

---

## Safehouse

Configuração escolhida:

- PlayerSafehouse=true
- AdminSafehouse=true

Decisão:

Safehouse será usada para bases de jogadores/clãs, não para as cidades-refúgio.

As cidades-refúgio serão safezones.

Motivo:

- Safezone protege cidade/refúgio
- Safehouse protege base de jogador/clã
- Staff deve controlar claims no início do beta

---

## Anti-grief

Configurações escolhidas:

- AllowDestructionBySledgehammer=false
- FireSpread=false

Motivo:

Evitar destruição de áreas importantes, refúgios, bases e estruturas do servidor.

---

## Workshop

Configuração escolhida:

- Mods=NF_UI
- WorkshopItems=3762165310

Mod oficial inicial:

Nova Fronteira UI Core

Recursos:
- Logo do servidor na tela
- Alerta de conexão
- Painel staff de alertas
- Alertas visuais de staff/evento/sistema

---

## Água e Energia

Configurações escolhidas:

- WaterShut=1
- ElecShut=1
- WaterShutModifier=0
- ElecShutModifier=0

Decisão:

Água e energia começam desligadas.

Motivo:

A lore do servidor se passa aproximadamente 10 anos após o início do apocalipse.

Energia ou água em refúgios devem ser tratadas por construção, geradores, eventos ou regras internas, não por abastecimento global do mapa.

---

## Loot

Configurações principais:

- FoodLootNew=0.4
- CannedFoodLootNew=0.4
- MedicalLootNew=0.5
- WeaponLootNew=0.4
- RangedWeaponLootNew=0.5
- AmmoLootNew=0.35

Decisão:

Loot será mais raro que o padrão.

Motivo:

- Reforçar o mundo 10 anos depois
- Valorizar comércio
- Valorizar expedições
- Evitar excesso de armas e munição
- Fazer eventos e rotas terem valor

---

## Respawn de Loot

Configurações escolhidas:

- SeenHoursPreventLootRespawn=24
- HoursForLootRespawn=168

Decisão:

Loot respawna lentamente, em ciclo semanal.

Áreas visitadas recentemente não devem respawnar imediatamente.

Motivo:

- Manter servidor multiplayer jogável
- Evitar mapa morto
- Evitar farm abusivo
- Dar tempo para rotas e eventos fazerem sentido

---

## Ainda não definido nesta etapa

Esta versão ainda não fecha:

- Safezones exatas de Rosewood e Muldraugh
- Spawn inicial por cidade
- Respawn de zumbis por região
- Configuração fina de carros
- Economia
- Mercado
- Eventos semanais
- Regras finais de morte
- Whitelist operacional no Discord

---

## Status

Planejado e aplicado nas configs locais de staging.

Próxima etapa:

Aplicar no LuraHost, validar login com whitelist e testar entrada de jogadores autorizados.
