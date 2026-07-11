require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISTextEntryBox"

NF_UI = NF_UI or {}
NF_UI.logoPanel = nil
NF_UI.toastPanel = nil
NF_UI.scheduledToasts = {}
NF_UI.logoTexture = nil
NF_UI.adminPanel = nil

local BASE_COLORS = {
    background = { r = 0.043, g = 0.055, b = 0.071 }, -- #0B0E12
    card = { r = 0.063, g = 0.082, b = 0.106 },       -- #10151B
    hover = { r = 0.082, g = 0.110, b = 0.141 },      -- #151C24
    border = { r = 0.122, g = 0.165, b = 0.212 },     -- #1F2A36
    text = { r = 0.906, g = 0.929, b = 0.961 },       -- #E7EDF5
    muted = { r = 0.718, g = 0.761, b = 0.812 },      -- #B7C2CF
    shadow = { r = 0.000, g = 0.000, b = 0.000 }
}

local ALERT_THEMES = {
    SISTEMA = {
        main = { r = 0.435, g = 0.659, b = 1.000 },      -- #6FA8FF
        secondary = { r = 0.239, g = 0.431, b = 0.659 }, -- #3D6EA8
        support = { r = 0.059, g = 0.126, b = 0.208 }    -- #0F2035
    },
    CONEXAO = {
        main = { r = 0.435, g = 0.659, b = 1.000 },
        secondary = { r = 0.239, g = 0.431, b = 0.659 },
        support = { r = 0.059, g = 0.126, b = 0.208 }
    },
    EVENTO = {
        main = { r = 0.180, g = 0.718, b = 1.000 },      -- #2EB7FF
        secondary = { r = 0.078, g = 0.475, b = 0.722 }, -- #1479B8
        support = { r = 0.043, g = 0.129, b = 0.188 }    -- #0B2130
    },
    STAFF = {
        main = { r = 0.878, g = 0.722, b = 0.290 },      -- #E0B84A
        secondary = { r = 0.635, g = 0.478, b = 0.090 }, -- #A27A17
        support = { r = 0.169, g = 0.141, b = 0.063 }    -- #2B2410
    }
}

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

local function getKindTheme(kind)
    return ALERT_THEMES[kind] or ALERT_THEMES.SISTEMA
end

NF_UI_LogoPanel = ISPanel:derive("NF_UI_LogoPanel")

function NF_UI_LogoPanel:new()
    local width = 150
    local height = 116
    local x = (getCore():getScreenWidth() - width) / 2
    local y = 6

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
    self:setY(6)

    ISPanel.prerender(self)

    if not NF_UI.logoTexture then
        NF_UI.logoTexture = getTexture("media/textures/NF_Logo.png")
    end

    local logoSize = 96
    local logoX = (self:getWidth() - logoSize) / 2

    if NF_UI.logoTexture then
        self:drawTextureScaled(NF_UI.logoTexture, logoX, 0, logoSize, logoSize, 0.82)
    else
        self:drawTextCentre("NOVA FRONTEIRA", self:getWidth() / 2, 10, 0.878, 0.722, 0.290, 0.85, UIFont.Medium)
    end

    self:drawTextCentre("B-42 STAGING", self:getWidth() / 2, 94, 0.718, 0.761, 0.812, 0.38, UIFont.Small)
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
    table.insert(self.toasts, 1, {
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
        self:setY(28)
        return
    end

    local boxWidth = 390
    local boxHeight = 82
    local gap = 10

    self:setWidth(boxWidth + 8)
    self:setHeight((boxHeight + gap) * visibleCount)
    self:setX(getCore():getScreenWidth() - boxWidth - 24)
    self:setY(28)

    ISPanel.prerender(self)

    local current = nowMs()
    local y = 0

    for i = 1, visibleCount do
        local toast = self.toasts[i]
        local age = current - toast.created
        local alpha = 0.96

        if age > toast.duration - 1000 then
            alpha = clamp((toast.duration - age) / 1000, 0, 0.96)
        end

        local theme = getKindTheme(toast.kind)

        -- sombra externa
        self:drawRect(5, y + 5, boxWidth, boxHeight, 0.34 * alpha, BASE_COLORS.shadow.r, BASE_COLORS.shadow.g, BASE_COLORS.shadow.b)

        -- card base
        self:drawRect(0, y, boxWidth, boxHeight, 0.94 * alpha, BASE_COLORS.card.r, BASE_COLORS.card.g, BASE_COLORS.card.b)

        -- camada de identidade do tipo do alerta
        self:drawRect(0, y, boxWidth, boxHeight, 0.14 * alpha, theme.support.r, theme.support.g, theme.support.b)

        -- barra lateral
        self:drawRect(0, y, 5, boxHeight, 0.98 * alpha, theme.main.r, theme.main.g, theme.main.b)

        -- linha superior sutil
        self:drawRect(5, y, boxWidth - 5, 1, 0.45 * alpha, theme.secondary.r, theme.secondary.g, theme.secondary.b)

        -- bordas
        self:drawRectBorder(0, y, boxWidth, boxHeight, 0.58 * alpha, BASE_COLORS.border.r, BASE_COLORS.border.g, BASE_COLORS.border.b)
        self:drawRectBorder(1, y + 1, boxWidth - 2, boxHeight - 2, 0.20 * alpha, theme.secondary.r, theme.secondary.g, theme.secondary.b)

        -- tag da categoria
        local tagWidth = 82
        local tagHeight = 20
        self:drawRect(14, y + 11, tagWidth, tagHeight, 0.24 * alpha, theme.main.r, theme.main.g, theme.main.b)
        self:drawRectBorder(14, y + 11, tagWidth, tagHeight, 0.46 * alpha, theme.main.r, theme.main.g, theme.main.b)
        self:drawText(toast.kind, 24, y + 14, theme.main.r, theme.main.g, theme.main.b, alpha, UIFont.Small)

        -- título e mensagem
        self:drawText(toast.title, 108, y + 12, BASE_COLORS.text.r, BASE_COLORS.text.g, BASE_COLORS.text.b, alpha, UIFont.Small)
        self:drawText(toast.message, 14, y + 46, BASE_COLORS.muted.r, BASE_COLORS.muted.g, BASE_COLORS.muted.b, 0.92 * alpha, UIFont.Small)

        y = y + boxHeight + gap
    end
end


NF_UI_AdminPanel = ISPanel:derive("NF_UI_AdminPanel")

function NF_UI_AdminPanel:new()
    local width = 430
    local height = 240
    local x = (getCore():getScreenWidth() - width) / 2
    local y = (getCore():getScreenHeight() - height) / 2

    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.background = false
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    o.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    o.moveWithMouse = true
    o.kind = "STAFF"

    return o
end

function NF_UI_AdminPanel:createChildren()
    ISPanel.createChildren(self)

    self.staffButton = ISButton:new(18, 52, 90, 26, "STAFF", self, NF_UI_AdminPanel.onKindStaff)
    self.staffButton:initialise()
    self:addChild(self.staffButton)

    self.eventButton = ISButton:new(116, 52, 90, 26, "EVENTO", self, NF_UI_AdminPanel.onKindEvent)
    self.eventButton:initialise()
    self:addChild(self.eventButton)

    self.systemButton = ISButton:new(214, 52, 90, 26, "SISTEMA", self, NF_UI_AdminPanel.onKindSystem)
    self.systemButton:initialise()
    self:addChild(self.systemButton)

    self.closeButton = ISButton:new(374, 14, 38, 24, "X", self, NF_UI_AdminPanel.onClose)
    self.closeButton:initialise()
    self:addChild(self.closeButton)

    self.titleEntry = ISTextEntryBox:new("Aviso da staff", 18, 106, 394, 26)
    self.titleEntry:initialise()
    self.titleEntry:instantiate()
    self:addChild(self.titleEntry)

    self.messageEntry = ISTextEntryBox:new("Servidor reinicia em breve.", 18, 158, 394, 26)
    self.messageEntry:initialise()
    self.messageEntry:instantiate()
    self:addChild(self.messageEntry)

    self.sendButton = ISButton:new(18, 200, 190, 28, "Enviar alerta", self, NF_UI_AdminPanel.onSend)
    self.sendButton:initialise()
    self:addChild(self.sendButton)
end

function NF_UI_AdminPanel:setKind(kind)
    self.kind = kind or "STAFF"

    if self.kind == "STAFF" then
        self.titleEntry:setText("Aviso da staff")
        self.messageEntry:setText("Servidor reinicia em breve.")
    elseif self.kind == "EVENTO" then
        self.titleEntry:setText("Evento iniciado")
        self.messageEntry:setText("Um evento foi iniciado no servidor.")
    else
        self.titleEntry:setText("Aviso do sistema")
        self.messageEntry:setText("Mensagem do sistema.")
    end
end

function NF_UI_AdminPanel:onKindStaff()
    self:setKind("STAFF")
end

function NF_UI_AdminPanel:onKindEvent()
    self:setKind("EVENTO")
end

function NF_UI_AdminPanel:onKindSystem()
    self:setKind("SISTEMA")
end

function NF_UI_AdminPanel:onClose()
    if NF_UI.adminPanel then
        NF_UI.adminPanel:removeFromUIManager()
        NF_UI.adminPanel = nil
    end
end

function NF_UI_AdminPanel:onSend()
    local title = self.titleEntry and self.titleEntry:getText() or ""
    local message = self.messageEntry and self.messageEntry:getText() or ""

    if title == "" then
        title = "Aviso"
    end

    if message == "" then
        message = "Mensagem da staff."
    end

    NF_UI.sendAdminAlert(self.kind, title, message, 14000)
end

function NF_UI_AdminPanel:prerender()
    self:setX((getCore():getScreenWidth() - self:getWidth()) / 2)
    self:setY((getCore():getScreenHeight() - self:getHeight()) / 2)

    ISPanel.prerender(self)

    self:drawRect(4, 4, self:getWidth(), self:getHeight(), 0.42, 0, 0, 0)
    self:drawRect(0, 0, self:getWidth(), self:getHeight(), 0.96, BASE_COLORS.card.r, BASE_COLORS.card.g, BASE_COLORS.card.b)
    self:drawRectBorder(0, 0, self:getWidth(), self:getHeight(), 0.72, BASE_COLORS.border.r, BASE_COLORS.border.g, BASE_COLORS.border.b)

    local theme = getKindTheme(self.kind)

    self:drawRect(0, 0, 5, self:getHeight(), 0.96, theme.main.r, theme.main.g, theme.main.b)
    self:drawText("Nova Fronteira Staff", 18, 16, BASE_COLORS.text.r, BASE_COLORS.text.g, BASE_COLORS.text.b, 1, UIFont.Medium)
    self:drawText("Tipo selecionado: " .. self.kind, 18, 34, theme.main.r, theme.main.g, theme.main.b, 0.95, UIFont.Small)

    self:drawText("Titulo", 18, 88, BASE_COLORS.muted.r, BASE_COLORS.muted.g, BASE_COLORS.muted.b, 0.9, UIFont.Small)
    self:drawText("Mensagem", 18, 140, BASE_COLORS.muted.r, BASE_COLORS.muted.g, BASE_COLORS.muted.b, 0.9, UIFont.Small)
end

function NF_UI.toggleAdminPanel()
    NF_UI.ensure()

    if NF_UI.adminPanel then
        NF_UI.adminPanel:removeFromUIManager()
        NF_UI.adminPanel = nil
        return
    end

    NF_UI.adminPanel = NF_UI_AdminPanel:new()
    NF_UI.adminPanel:initialise()
    NF_UI.adminPanel:addToUIManager()

    if NF_UI.adminPanel.bringToTop then
        NF_UI.adminPanel:bringToTop()
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

function NF_UI.sendAdminAlert(kind, title, message, durationMs)
    if not sendClientCommand then
        NF_UI.showToast("Erro", "sendClientCommand indisponivel no cliente.", "SISTEMA", 8000)
        return
    end

    sendClientCommand("NF_UI", "BroadcastToast", {
        kind = kind or "STAFF",
        title = title or "Aviso da staff",
        message = message or "",
        duration = durationMs or 12000
    })
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

    NF_UI.scheduleToast(6000, "Conexao estabelecida", "Bem-vindo a Nova Fronteira.", "CONEXAO", 12000)
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

local function onKeyPressed(key)
    if not Keyboard then
        return
    end

    if key == Keyboard.KEY_F9 then
        NF_UI.toggleAdminPanel()
    end
end

Events.OnCreatePlayer.Add(onCreatePlayer)
Events.OnTick.Add(NF_UI.processScheduledToasts)
Events.OnKeyPressed.Add(onKeyPressed)
Events.OnServerCommand.Add(onServerCommand)
