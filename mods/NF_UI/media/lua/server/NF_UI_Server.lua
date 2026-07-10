NF_UI_Server = NF_UI_Server or {}

function NF_UI_Server.broadcastToast(title, message, kind, durationMs)
    local players = getOnlinePlayers()

    if not players then
        return
    end

    for i = 0, players:size() - 1 do
        local player = players:get(i)

        sendServerCommand(player, "NF_UI", "Toast", {
            title = title or "Aviso",
            message = message or "",
            kind = kind or "SISTEMA",
            duration = durationMs or 8000
        })
    end
end

Events.OnServerStarted.Add(function()
    print("[NF_UI] Server helpers loaded.")
end)
