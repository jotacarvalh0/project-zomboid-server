NF_UI_Server = NF_UI_Server or {}

local VALID_KINDS = {
    SISTEMA = true,
    CONEXAO = true,
    EVENTO = true,
    STAFF = true
}

-- MVP de segurança:
-- enquanto o mod estiver público na Workshop, só usuários explicitamente permitidos podem enviar alertas.
local STRICT_STAFF_ALLOWLIST = true

local STAFF_USERS = {
    ["admin"] = true
}

local STAFF_STEAM_IDS = {
    -- Exemplo futuro:
    -- ["76561198000000000"] = true
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

local function getPlayerUsername(player)
    if player and player.getUsername then
        return tostring(player:getUsername() or "")
    end

    return ""
end

local function getPlayerSteamId(player)
    if player and player.getSteamID then
        return tostring(player:getSteamID() or "")
    end

    if player and player.getSteamID64 then
        return tostring(player:getSteamID64() or "")
    end

    return ""
end

local function getPlayerAccessLevel(player)
    if player and player.getAccessLevel then
        return tostring(player:getAccessLevel() or ""):lower()
    end

    return ""
end

local function isStaff(player)
    if not player then
        return false
    end

    local username = getPlayerUsername(player)
    local usernameLower = username:lower()
    local steamId = getPlayerSteamId(player)

    if STAFF_USERS[username] or STAFF_USERS[usernameLower] then
        return true
    end

    if steamId ~= "" and STAFF_STEAM_IDS[steamId] then
        return true
    end

    if STRICT_STAFF_ALLOWLIST then
        return false
    end

    local access = getPlayerAccessLevel(player)

    return access == "admin" or access == "moderator" or access == "overseer" or access == "gm"
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
        local username = getPlayerUsername(player)
        local access = getPlayerAccessLevel(player)
        local steamId = getPlayerSteamId(player)

        print("[NF_UI] BroadcastToast negado: jogador sem permissao. user=" .. username .. " access=" .. access .. " steamId=" .. steamId)

        NF_UI_Server.sendToast(
            player,
            "Acesso negado",
            "Voce nao tem permissao para enviar alertas.",
            "SISTEMA",
            7000
        )

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
