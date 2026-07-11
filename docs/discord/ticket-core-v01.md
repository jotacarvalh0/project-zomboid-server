# Ticket Core v0.1 — Nova Fronteira

## Objetivo

Criar um sistema simples de tickets no Discord para centralizar suporte, denúncias, bugs, atendimento geral e compra de VIPs.

O sistema de ticket será exclusivo do Discord.  
O jogo ficará apenas com alertas visuais, eventos e comunicação rápida da staff.

---

## Estrutura Inicial

### Categoria: `🛟 SUPORTE`

Canais fixos:

- `🎫・abrir-ticket`
- `📜・logs-tickets`

Categoria dinâmica para tickets criados pelo bot:

- `📁・tickets-abertos`

---

## Botões do Painel de Ticket

O canal `🎫・abrir-ticket` terá um painel com os seguintes botões:

1. Suporte
2. Denúncia
3. Bug Report
4. Atendimento
5. Compra de VIP

---

## Tipos de Ticket

### Suporte

Uso:
- Erro para entrar no servidor
- Mod não baixando
- Erro de versão da Workshop
- Travamento
- Lag
- Dúvidas técnicas

Mensagem inicial:

Olá. Descreva seu problema com o máximo de detalhes possível.

Inclua:
- Seu nick no jogo
- Print do erro
- Horário aproximado
- O que você tentou fazer

---

### Denúncia

Uso:
- Griefing
- Abuso
- PvP irregular
- Exploração de bug
- Comportamento tóxico
- Quebra de regras

Mensagem inicial:

Sua denúncia será vista apenas pela staff.

Inclua:
- Nick do jogador denunciado
- O que aconteceu
- Horário aproximado
- Local aproximado no mapa
- Prints, vídeos ou testemunhas

Não exponha o caso em canais públicos.

---

### Bug Report

Uso:
- Bug de mapa
- Bug de item
- Bug de UI
- Safezone falhando
- Evento quebrado
- Loot estranho
- Problemas com mods

Mensagem inicial:

Obrigado por reportar um bug.

Inclua:
- O que aconteceu
- O que deveria acontecer
- Local aproximado
- Print ou vídeo
- Horário aproximado

---

### Atendimento

Uso:
- Dúvidas gerais
- Solicitação para falar com a staff
- Problemas que não entram nas outras categorias
- Orientação sobre regras
- Pedido de análise manual

Mensagem inicial:

Explique sua solicitação para a staff.

Inclua:
- Seu nick no jogo
- Motivo do atendimento
- Detalhes importantes

---

### Compra de VIP

Uso:
- Dúvidas sobre VIP
- Confirmação de pagamento
- Benefícios
- Problemas com ativação
- Renovação

Mensagem inicial:

Atendimento sobre VIP.

Inclua:
- Seu nick no jogo
- Plano desejado ou adquirido
- Forma de pagamento
- Comprovante, se já tiver pago

Observação:
Nenhum benefício VIP deve quebrar o equilíbrio do servidor.

---

## Permissões

### Jogador

Pode:
- Ver `🎫・abrir-ticket`
- Abrir ticket
- Ver apenas o próprio ticket

Não pode:
- Ver tickets de outros jogadores
- Ver logs
- Fechar tickets de outros jogadores

### Suporte

Pode:
- Ver tickets abertos
- Responder tickets
- Encaminhar casos para moderadores/admins

### Moderador

Pode:
- Ver tickets
- Responder
- Fechar tickets
- Atuar em denúncias e bugs

### Admin/Fundador

Pode:
- Acesso total
- Configurar painel
- Ver logs
- Reabrir ou revisar casos

---

## Fluxo

1. Jogador entra em `🎫・abrir-ticket`.
2. Escolhe o tipo de atendimento.
3. Bot cria um canal privado.
4. Jogador explica o caso.
5. Staff responde.
6. Staff fecha o ticket.
7. Registro vai para `📜・logs-tickets`.

---

## Regras de Atendimento

- Não discutir denúncia em canal público.
- Não prometer ressarcimento sem análise.
- Pedir print, vídeo ou log sempre que possível.
- Bug crítico deve virar tarefa interna.
- Compra de VIP deve ser tratada com cuidado e registro.
- Ticket parado pode ser fechado após aviso.
- Staff deve manter tom profissional.

---

## Status

Planejado para Discord MVP.

---

## Implementação Validada

Data: 2026-07-11

Status: Ticket Core v0.1 configurado e validado no Discord.

Validado:
- Canal `🎫・abrir-ticket` criado.
- Categoria `📁・tickets-abertos` configurada.
- Canal `📜・logs-tickets` configurado.
- Bot Ticket Tool instalado.
- Painel de abertura enviado.
- Botão `Abrir ticket` funcionando.
- Ticket privado criado corretamente.
- Permissões corrigidas na categoria de tickets.
- Mensagem inicial do ticket traduzida para PT-BR.
- Botão `Fechar ticket` traduzido.
- Confirmação de fechamento traduzida.
- Logs de abertura/fechamento funcionando.

Mensagem inicial usada:

> 🎫 Ticket aberto.
>
> A staff responderá assim que possível.
>
> Envie:
> - Tipo: Suporte / Denúncia / Bug / VIP
> - Nick no jogo:
> - Descrição:
> - Print/vídeo, se tiver:
>
> Use o botão abaixo para fechar.

Observações:
- O Ticket Tool Free limita parte da customização visual do painel.
- O rodapé padrão do Ticket Tool permanece por enquanto.
- O MVP usa um botão único de abertura de ticket.
- A separação por tipo será feita pelo campo "Tipo" dentro do ticket.
- Futuramente, se necessário, trocar para formulário/dropdown ou bot próprio.
