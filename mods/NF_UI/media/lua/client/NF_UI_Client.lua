require "ISUI/ISPanel"

NF_UI = NF_UI or {}
NF_UI.logoPanel = nil
NF_UI.toastPanel = nil
NF_UI.scheduledToasts = {}

local function nowMs()
    if getTimestampMs then
        return getTimestampMs()
    end

    return os.time() * 1000
end

local function clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

local function getKindColor(kind)
    if kind == "STAFF" then
        return 1.0, 0.85, 0.35
    end

    if kind == "EVENTO" then
        return 0.45, 0.8, 1.0
    end

    if kind == "LORE" then
        return 0.75, 0.55, 1.0
    end

    if kind == "ALERTA" then
        return 1.0, 0.35, 0.25
    end

    return 0.8, 0.9, 1.0
end

NF_UI_LogoPanel = ISPanel:derive("NF_UI_LogoPanel")

function NF_UI_LogoPanel:new()
    local width = 420
    local height = 48
    local x = (getCore():getScreenWidth() - width) / 2
    local y = 8

    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.background = false
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    o.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    o.moveWithMouse = false

    return o
end

function NF_UI_LogoPanel:prerender()
    self:setX((getCore():getScreenWidth() - self:getWidth()) / 2)
    self:setY(8)

    ISPanel.prerender(self)

    self:drawTextCentre("NOVA FRONTEIRA", self:getWidth() / 2, 4, 1.0, 0.85, 0.35, 0.70, UIFont.Medium)
    self:drawTextCentre("B-42 STAGING", self:getWidth() / 2, 27, 0.8, 0.9, 1.0, 0.35, UIFont.Small)
end

NF_UI_ToastPanel = ISPanel:derive("NF_UI_ToastPanel")

function NF_UI_ToastPanel:new()
    local width = 360
    local height = 1
    local x = getCore():getScreenWidth() - width - 24
    local y = 24

    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.background = false
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    o.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    o.moveWithMouse = false
    o.toasts = {}

    return o
end

function NF_UI_ToastPanel:addToast(title, message, kind, durationMs)
    table.insert(self.toasts, {
        title = title or "SISTEMA",
        message = message or "",
        kind = kind or "SISTEMA",
        duration = durationMs or 8000,
        created = nowMs()
    })
end

function NF_UI_ToastPanel:removeExpired()
    local current = nowMs()

    for i = #self.toasts, 1, -1 do
        local toast = self.toasts[i]
        if current - toast.created > toast.duration then
            table.remove(self.toasts, i)
        end
    end
end

function NF_UI_ToastPanel:prerender()
    self:removeExpired()

    local visibleCount = math.min(#self.toasts, 4)

    if visibleCount <= 0 then
        self:setWidth(1)
        self:setHeight(1)
        self:setX(getCore():getScreenWidth() - 25)
        self:setY(24)
        return
    end

    local boxWidth = 360
    local boxHeight = 64
    local gap = 8

    self:setWidth(boxWidth)
    self:setHeight((boxHeight + gap) * visibleCount)
    self:setX(getCore():getScreenWidth() - boxWidth - 24)
    self:setY(24)

    ISPanel.prerender(self)

    local current = nowMs()
    local y = 0

    for i = 1, visibleCount do
        local toast = self.toasts[i]
        local age = current - toast.created
        local alpha = 0.92

        if age > toast.duration - 1000 then
            alpha = clamp((toast.duration - age) / 1000, 0, 0.92)
        end

        local r, g, b = getKindColor(toast.kind)

        self:drawRect(0, y, boxWidth, boxHeight, 0.72 * alpha, 0.03, 0.03, 0.03)
        self:drawRect(0, y, 5, boxHeight, 0.95 * alpha, r, g, b)
        self:drawRectBorder(0, y, boxWidth, boxHeight, 0.60 * alpha, r, g, b)

        self:drawText("[" .. toast.kind .. "] " .. toast.title, 14, y + 8, r, g, b, alpha, UIFont.Small)
        self:drawText(toast.message, 14, y + 32, 1.0, 1.0, 1.0, 0.90 * alpha, UIFont.Small)

        y = y + boxHeight + gap
    end
end

function NF_UI.ensure()
    if not NF_UI.logoPanel then
        NF_UI.logoPanel = NF_UI_LogoPanel:new()
        NF_UI.logoPanel:initialise()
        NF_UI.logoPanel:addToUIManager()
    end

    if not NF_UI.toastPanel then
        NF_UI.toastPanel = NF_UI_ToastPanel:new()
        NF_UI.toastPanel:initialise()
        NF_UI.toastPanel:addToUIManager()
    end
end

function NF_UI.showToast(title, message, kind, durationMs)
    NF_UI.ensure()

    if NF_UI.toastPanel then
        NF_UI.toastPanel:addToast(title, message, kind, durationMs)
    end
end

function NF_UI.scheduleToast(delayMs, title, message, kind, durationMs)
    table.insert(NF_UI.scheduledToasts, {
        due = nowMs() + delayMs,
        title = title,
        message = message,
        kind = kind,
        duration = durationMs
    })
end

function NF_UI.processScheduledToasts()
    if not NF_UI.scheduledToasts then
        return
    end

    local current = nowMs()

    for i = #NF_UI.scheduledToasts, 1, -1 do
        local toast = NF_UI.scheduledToasts[i]

        if current >= toast.due then
            NF_UI.showToast(toast.title, toast.message, toast.kind, toast.duration)
            table.remove(NF_UI.scheduledToasts, i)
        end
    end
end


local function onCreatePlayer()
    NF_UI.ensure()

    NF_UI.scheduleToast(6000, "Interface carregada", "Nova Fronteira UI Core ativo.", "SISTEMA", 14000)
    NF_UI.scheduleToast(10000, "Aviso da staff", "Este e um teste de alerta visual.", "STAFF", 16000)
    NF_UI.scheduleToast(15000, "Evento beta", "Sistema de popups funcionando no cliente.", "EVENTO", 16000)
end

local function onServerCommand(module, command, args)
    if module ~= "NF_UI" then
        return
    end

    if command == "Toast" then
        args = args or {}
        NF_UI.showToast(
            args.title or "Aviso",
            args.message or "",
            args.kind or "SISTEMA",
            args.duration or 8000
        )
    end
end

Events.OnCreatePlayer.Add(onCreatePlayer)
Events.OnTick.Add(NF_UI.processScheduledToasts)
Events.OnServerCommand.Add(onServerCommand)
