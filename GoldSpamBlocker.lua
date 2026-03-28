-- GoldSpamBlocker v2.0
-- Pattern-based chat spam filter for WoW 3.3.5a (WotLK)
-- Silently blocks gold-seller spam in Trade, General/LFG, and Whisper.
-- Localized for: English, Polish (plPL), Russian (ruRU), Chinese (zhCN/zhTW)

GSB_Config = GSB_Config or {
    enabled      = true,
    blockTrade   = true,
    blockGeneral = true,
    blockWhisper = true,
}

local blockedCount = 0

-- -----------------------------------------------------------------------
-- Spam pattern list
-- Uses Lua patterns, matched case-insensitively.
-- GSB_Patterns is a SavedVariable so /gsb add persists across sessions.
--
-- URL philosophy: we do NOT block bare TLDs like ".com" or "www." because
-- they cause too many false positives (wowhead.com, stormforge.gg, etc.).
-- Instead we block known spam domain names directly, plus obfuscation tricks
-- that only spammers use. Gold-selling keyword patterns catch everything else.
-- -----------------------------------------------------------------------
GSB_Patterns = GSB_Patterns or {

    ---------- Obfuscated URL tricks (spammers only) ----------
    "w w w%.",        -- "w w w.site.com"
    "w%.w%.w%.",      -- "w.w.w.site.com"
    "d0t",            -- "site d0t com"
    "d%*t",           -- "site d*t com"
    "c0m",            -- "site.c0m"

    ---------- Known spam domain names ----------
    "igxe",
    "mmoga",
    "eldorado%.gg",
    "playerauctions",
    "wowgold",
    "gold%-wow",
    "wow%-gold",
    "g2g%.com",
    "iwinbuttons",
    "ssegold",
    "p2gamer",
    "odealo",
    "overgear",

    ---------- Gold-selling keywords (English) ----------
    "cheap.?gold",
    "buy.?gold",
    "sell.?gold",
    "gold.?for.?sale",
    "cheapest.?gold",
    "instant.?delivery",
    "mmogold",
    "g0ld",
    "powerleveling",
    "power.?leveling",
    "leveling.?service",
    "account.+for.?sale",
    "selling.+account",
    "boost.*usd",
    "usd.*boost",

    ---------- Price / currency signals ----------
    -- Only block $ amounts — common in spam, rare in legitimate chat
    "%$%d+",          -- $5, $29, $500
    "paypal",

    ---------- Russian (ruRU) ----------
    -- купить золото = buy gold, продать золото = sell gold
    -- дешевое золото = cheap gold, прокачка = powerleveling
    -- аккаунт на продажу = account for sale
    "купить золото",
    "продать золото",
    "дешевое золото",
    "дешёвое золото",
    "голд дешево",
    "голд дёшево",
    "прокачка персонажа",
    "аккаунт.*продаж",
    "продам аккаунт",
    "быстрая доставка",
    "вов голд",
    "wow голд",

    ---------- Polish (plPL) ----------
    -- kup złoto = buy gold, tanie złoto = cheap gold
    -- sprzedam konto = selling account
    "kup z%łoto",
    "tanie z%łoto",
    "sprzedam konto",
    "sprzedam z%łoto",
    "z%łoto wow",
    "wow z%łoto",
    "levelowanie",
    "szybka dostawa",

    ---------- Chinese (zhCN / zhTW) ----------
    -- 收金 = buy gold, 卖金 = sell gold, 代练 = powerleveling
    -- 出售账号 = selling account, 便宜金币 = cheap gold
    "收金",
    "卖金",
    "代练",
    "出售账号",
    "便宜金币",
    "金币出售",
    "快速发货",
    "wow金",
    "金币wow",
}

-- -----------------------------------------------------------------------
-- Core check — returns true if the message is spam
-- -----------------------------------------------------------------------
local function IsSpam(msg)
    if not msg or msg == "" then return false end
    local lower = msg:lower()
    for _, pattern in ipairs(GSB_Patterns) do
        if lower:find(pattern) then
            return true
        end
    end
    return false
end

-- -----------------------------------------------------------------------
-- Register chat filters
-- -----------------------------------------------------------------------
local function RegisterFilter(event, configFlag)
    ChatFrame_AddMessageEventFilter(event, function(chatFrame, ev, message, sender, ...)
        if not GSB_Config.enabled     then return false end
        if not GSB_Config[configFlag] then return false end
        if IsSpam(message) then
            blockedCount = blockedCount + 1
            LogBlocked(sender, event, message)
            return true
        end
        return false
    end)
end

RegisterFilter("CHAT_MSG_TRADE",          "blockTrade")
RegisterFilter("CHAT_MSG_CHANNEL",        "blockGeneral")
RegisterFilter("CHAT_MSG_WHISPER",        "blockWhisper")
RegisterFilter("CHAT_MSG_WHISPER_INFORM", "blockWhisper")

-- -----------------------------------------------------------------------
-- Event frame: login notice
-- -----------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        print("|cff00ff00" .. GSB_L.loaded .. "|r")
    end
end)

-- -----------------------------------------------------------------------
-- Block log (session only, capped at LOG_MAX entries)
-- -----------------------------------------------------------------------
local LOG_MAX   = 200
local blockLog  = {}   -- { time, sender, channel, message }

local CHANNEL_LABELS = {
    CHAT_MSG_TRADE          = "Trade",
    CHAT_MSG_CHANNEL        = "General",
    CHAT_MSG_WHISPER        = "Whisper",
    CHAT_MSG_WHISPER_INFORM = "Whisper",
}

function LogBlocked(sender, event, message)
    if #blockLog >= LOG_MAX then
        table.remove(blockLog, 1)
    end
    table.insert(blockLog, {
        time    = date("%H:%M:%S"),
        sender  = sender or "?",
        channel = CHANNEL_LABELS[event] or event,
        message = (message or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""),
    })
    -- Refresh frame if it is currently visible
    if GSB_LogFrame and GSB_LogFrame:IsShown() then
        GSB_LogFrame_Populate()
    end
end

-- -----------------------------------------------------------------------
-- Log UI — ScrollFrame + Slider, all 3.3.5a safe.
--
-- Layout:
--   logFrame (outer window, 620x380)
--     contentFrame (ScrollFrame child, holds row FontStrings)
--     slider (vertical Slider on the right edge)
-- Each row is a FontString. GSB_LogFrame_Populate() rebuilds them all and
-- resets the slider range whenever the log changes.
-- -----------------------------------------------------------------------
local ROW_HEIGHT  = 16
local VISIBLE_ROWS = 18
local FRAME_W     = 620
local FRAME_H     = (ROW_HEIGHT * VISIBLE_ROWS) + 70  -- rows + header + footer

-- Outer window
local logFrame = CreateFrame("Frame", "GSB_LogFrame", UIParent)
GSB_LogFrame = logFrame
logFrame:SetWidth(FRAME_W)
logFrame:SetHeight(FRAME_H)
logFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
logFrame:SetMovable(true)
logFrame:EnableMouse(true)
logFrame:RegisterForDrag("LeftButton")
logFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
logFrame:SetScript("OnDragStop",  function(self) self:StopMovingOrSizing() end)
logFrame:SetFrameStrata("DIALOG")
logFrame:SetBackdrop({
    bgFile   = "Interface\DialogFrame\UI-DialogBox-Background",
    edgeFile = "Interface\DialogFrame\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 },
})
logFrame:Hide()

-- Title
local title = logFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", logFrame, "TOP", 0, -16)
title:SetText("|cff00ff00GoldSpamBlocker|r — Blocked Messages")

-- Close button
local closeBtn = CreateFrame("Button", nil, logFrame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", logFrame, "TOPRIGHT", -5, -5)
closeBtn:SetScript("OnClick", function() logFrame:Hide() end)

-- Count label
local countLabel = logFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
countLabel:SetPoint("BOTTOMLEFT", logFrame, "BOTTOMLEFT", 16, 14)

-- Clear button
local clearBtn = CreateFrame("Button", nil, logFrame, "UIPanelButtonTemplate")
clearBtn:SetWidth(80)
clearBtn:SetHeight(22)
clearBtn:SetPoint("BOTTOMRIGHT", logFrame, "BOTTOMRIGHT", -36, 10)
clearBtn:SetText("Clear")
clearBtn:SetScript("OnClick", function()
    blockLog = {}
    GSB_LogFrame_Populate()
end)

-- ScrollFrame — clips what the user sees
local scrollFrame = CreateFrame("ScrollFrame", nil, logFrame)
scrollFrame:SetPoint("TOPLEFT",     logFrame, "TOPLEFT",      14, -34)
scrollFrame:SetPoint("BOTTOMRIGHT", logFrame, "BOTTOMRIGHT", -30,  36)

-- Content frame — tall enough to hold all rows; scrolled inside scrollFrame
local contentFrame = CreateFrame("Frame", nil, scrollFrame)
contentFrame:SetWidth(scrollFrame:GetWidth() or (FRAME_W - 44))
contentFrame:SetHeight(ROW_HEIGHT)  -- updated in Populate
scrollFrame:SetScrollChild(contentFrame)

-- Pre-create FontString rows (reused across redraws)
local rows = {}
for i = 1, LOG_MAX do
    local fs = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fs:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, -(i - 1) * ROW_HEIGHT)
    fs:SetWidth(contentFrame:GetWidth() or (FRAME_W - 44))
    fs:SetJustifyH("LEFT")
    fs:SetText("")
    rows[i] = fs
end

-- Slider (vertical scrollbar on the right edge)
local slider = CreateFrame("Slider", nil, logFrame, "UIPanelScrollBarTemplate")
slider:SetPoint("TOPLEFT",     scrollFrame, "TOPRIGHT",    4,  -16)
slider:SetPoint("BOTTOMLEFT",  scrollFrame, "BOTTOMRIGHT", 4,   16)
slider:SetMinMaxValues(0, 0)
slider:SetValueStep(ROW_HEIGHT)
slider:SetValue(0)

local function UpdateScroll()
    scrollFrame:SetVerticalScroll(slider:GetValue())
end
slider:SetScript("OnValueChanged", UpdateScroll)

-- Mouse wheel on the scroll frame
scrollFrame:EnableMouseWheel(true)
scrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local min, max = slider:GetMinMaxValues()
    local newVal = math.max(min, math.min(max, slider:GetValue() - delta * ROW_HEIGHT * 3))
    slider:SetValue(newVal)
end)

function GSB_LogFrame_Populate()
    local n = #blockLog

    -- Fill rows newest-first; blank out unused rows
    for i = 1, LOG_MAX do
        local logIdx = n - (i - 1)   -- newest = index n, oldest = 1
        if logIdx >= 1 then
            local e = blockLog[logIdx]
            rows[i]:SetText(string.format(
                "|cff888888[%s]|r |cff00ccff[%s]|r |cffffd700%s|r: |cffffffff%s|r",
                e.time, e.channel, e.sender, e.message
            ))
        else
            rows[i]:SetText("")
        end
    end

    -- Resize content frame to actual content height
    local totalH = math.max(n, 1) * ROW_HEIGHT
    contentFrame:SetHeight(totalH)

    -- Update slider range so it scrolls exactly to the last row
    local scrollH = scrollFrame:GetHeight() or (VISIBLE_ROWS * ROW_HEIGHT)
    local maxScroll = math.max(0, totalH - scrollH)
    slider:SetMinMaxValues(0, maxScroll)
    -- Don't reset scroll position so the user stays where they are
    slider:SetValue(math.min(slider:GetValue(), maxScroll))
    UpdateScroll()

    countLabel:SetText(n .. " / " .. LOG_MAX .. " entries")
end

-- -----------------------------------------------------------------------
-- Slash commands
-- -----------------------------------------------------------------------
SLASH_GSB1 = "/gsb"
SLASH_GSB2 = "/goldspamblocker"

SlashCmdList["GSB"] = function(input)
    local L = GSB_L
    input = strtrim(input or ""):lower()
    local cmd, arg = input:match("^(%S+)%s*(.*)")
    cmd = cmd or ""
    arg = strtrim(arg or "")

    if cmd == "on" then
        GSB_Config.enabled = true
        print("|cff00ff00" .. L.enabled .. "|r")

    elseif cmd == "off" then
        GSB_Config.enabled = false
        print("|cffff4444" .. L.disabled .. "|r")

    elseif cmd == "trade" then
        GSB_Config.blockTrade = not GSB_Config.blockTrade
        print("|cff00ff00" .. (GSB_Config.blockTrade and L.trade_on or L.trade_off) .. "|r")

    elseif cmd == "general" then
        GSB_Config.blockGeneral = not GSB_Config.blockGeneral
        print("|cff00ff00" .. (GSB_Config.blockGeneral and L.general_on or L.general_off) .. "|r")

    elseif cmd == "whisper" then
        GSB_Config.blockWhisper = not GSB_Config.blockWhisper
        print("|cff00ff00" .. (GSB_Config.blockWhisper and L.whisper_on or L.whisper_off) .. "|r")

    elseif cmd == "stats" then
        print("|cff00ff00" .. L.stats .. "|cffffd700" .. blockedCount .. "|r")

    elseif cmd == "list" then
        print("|cff00ff00" .. string.format(L.list_header, #GSB_Patterns) .. "|r")
        for i, p in ipairs(GSB_Patterns) do
            print("  |cffffd700" .. i .. ".|r " .. p)
        end

    elseif cmd == "add" and arg ~= "" then
        for _, p in ipairs(GSB_Patterns) do
            if p == arg then
                print("|cffff4444" .. string.format(L.duplicate, arg) .. "|r")
                return
            end
        end
        table.insert(GSB_Patterns, arg)
        print("|cff00ff00" .. string.format(L.added, #GSB_Patterns, arg) .. "|r")

    elseif cmd == "remove" then
        local n = tonumber(arg)
        if n and GSB_Patterns[n] then
            local removed = table.remove(GSB_Patterns, n)
            print("|cff00ff00" .. string.format(L.removed, n, removed) .. "|r")
        else
            print("|cffff4444" .. L.remove_usage .. "|r")
        end

    elseif cmd == "log" then
        if arg == "clear" then
            blockLog = {}
            if GSB_LogFrame:IsShown() then GSB_LogFrame_Populate() end
            print("|cff00ff00[GSB]|r Block log cleared.")
        else
            if GSB_LogFrame:IsShown() then
                GSB_LogFrame:Hide()
            else
                GSB_LogFrame_Populate()
                GSB_LogFrame:Show()
            end
        end

    elseif cmd == "test" and arg ~= "" then
        if IsSpam(arg) then
            print("|cffff4444" .. L.test_blocked .. "|r")
        else
            print("|cff00ff00" .. L.test_clean .. "|r")
        end

    else
        for _, line in ipairs(L.help) do
            print("|cff00ff00" .. line .. "|r")
        end
    end
end
