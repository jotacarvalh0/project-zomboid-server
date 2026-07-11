NF_UI_Server = NF_UI_Server or {}

local VALID_KINDS = {
    SISTEMA = true,
    CONEXAO = true,
    EVENTO = true,
    STAFF = true
}

local function safeText(value, fallback, maxLength)
    value = tostring(value or fallback or "")

    value = value:gsub("[\r\n\t]", " ")

    if maxLength and string.len(value) > maxLength then
        value = string.sub(value, 1, maxLength)
    end

    return value
end

local function normalizeKind(kind)
    kind = tostring(kind or "SISTEMA"):upper()

    if VALID_KINDS[kind] then
        return kind
    end

    return "SISTEMA"
end

local function normalizeDuration(durationMs)
    durationMs = tonumber(durationMs) or 10000

    if durationMs < 3000 then
        return 3000
    end

    if durationMs > 30000 then
        return 30000
    end

    return durationMs
end

local function isStaff(player)
    if not player then
        return false
    end

    local access = ""

    if player.getAccessLevel then
        access = tostring(player:getAccessLevel() or "")
    end

    access = access:lower()

    return access ~= "" and access ~= "none" and access ~= "player"
end

function NF_UI_Server.sendToast(player, title, message, kind, durationMs)
    if not player then
        return
    end

    sendServerCommand(player, "NF_UI", "Toast", {
        title = safeText(title, "Aviso", 60),
        message = safeText(message, "", 160),
        kind = normalizeKind(kind),
        duration = normalizeDuration(durationMs)
    })
end

function NF_UI_Server.broadcastToast(title, message, kind, durationMs)
    local players = getOnlinePlayers()

    if not players then
        return
    end

    for i = 0, players:size() - 1 do
        local player = players:get(i)

        NF_UI_Server.sendToast(player, title, message, kind, durationMs)
    end
end

local function onClientCommand(module, command, player, args)
    if module ~= "NF_UI" then
        return
    end

    if command ~= "BroadcastToast" then
        return
    end

    if not isStaff(player) then
        print("[NF_UI] BroadcastToast negado: jogador sem permissao.")
        return
    end

    args = args or {}

    local title = safeText(args.title, "Aviso da staff", 60)
    local message = safeText(args.message, "", 160)
    local kind = normalizeKind(args.kind or "STAFF")
    local duration = normalizeDuration(args.duration or 12000)

    print("[NF_UI] BroadcastToast enviado por staff: " .. title)

    NF_UI_Server.broadcastToast(title, message, kind, duration)
end

Events.OnClientCommand.Add(onClientCommand)

Events.OnServerStarted.Add(function()
    print("[NF_UI] Server helpers loaded.")
end)
