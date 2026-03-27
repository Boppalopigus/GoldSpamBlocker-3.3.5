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
-- -----------------------------------------------------------------------
GSB_Patterns = GSB_Patterns or {

    ---------- Universal: URLs ----------
    "www%.",
    "http",
    "%.com",
    "%.net",
    "%.org",
    "%.ru",
    "%.cn",
    "%.eu",
    "%.gg",
    "%.io",
    -- Obfuscated URLs
    "w w w",
    "w%.w%.w",
    "d0t",
    "c0m",
    "d%*t",

    ---------- Universal: gold-selling keywords (English) ----------
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

    ---------- Universal: price/currency signals ----------
    "%$%d+",        -- $5, $29 …
    "%d+k%s*gold",  -- 500k gold
    "usd",
    "paypal",

    ---------- Universal: known site name fragments ----------
    "igxe",
    "mmoga",
    "eldorado",
    "playerauctions",
    "wowgold",
    "gold%-wow",
    "wow%-gold",
    "g2g%.com",

    ---------- Russian (ruRU) ----------
    -- "купить золото" (buy gold), "продать золото" (sell gold),
    -- "дешевое золото" (cheap gold), "прокачка" (powerleveling),
    -- "аккаунт на продажу" (account for sale)
    "купить золото",
    "продать золото",
    "дешевое золото",
    "дешёвое золото",
    "голд дешево",
    "голд дёшево",
    "прокачка персонажа",
    "аккаунт.*продаж",
    "продам аккаунт",
    "быстрая доставка",   -- instant delivery
    "вов голд",
    "wow голд",

    ---------- Polish (plPL) ----------
    -- "kup złoto" (buy gold), "tanie złoto" (cheap gold),
    -- "sprzedam konto" (selling account), "power leveling"
    "kup złoto",
    "tanie złoto",
    "sprzedam konto",
    "sprzedam złoto",
    "złoto wow",
    "wow złoto",
    "levelowanie",
    "szybka dostawa",     -- fast delivery

    ---------- Chinese (zhCN / zhTW) ----------
    -- "收金" (buy gold), "卖金" (sell gold), "代练" (powerleveling),
    -- "出售账号" (selling account), "便宜金币" (cheap gold)
    "收金",
    "卖金",
    "代练",
    "出售账号",
    "便宜金币",
    "金币出售",
    "快速发货",           -- fast delivery
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
            return true  -- suppress the message entirely
        end
        return false
    end)
end

RegisterFilter("CHAT_MSG_TRADE",          "blockTrade")
RegisterFilter("CHAT_MSG_CHANNEL",        "blockGeneral")
RegisterFilter("CHAT_MSG_WHISPER",        "blockWhisper")
RegisterFilter("CHAT_MSG_WHISPER_INFORM", "blockWhisper")

-- -----------------------------------------------------------------------
-- Login notice
-- -----------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    -- GSB_L is populated by Localization.lua which loads first
    print("|cff00ff00" .. GSB_L.loaded .. "|r")
end)

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
