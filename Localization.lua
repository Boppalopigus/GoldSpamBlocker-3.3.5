-- GoldSpamBlocker: Localization
-- Covers the four languages on Stormforge's own site: EN, PL, RU, ZH

local L = {}
GSB_L = L

-- -----------------------------------------------------------------------
-- UI strings (slash command output)
-- Detect client locale and fall back to English.
-- -----------------------------------------------------------------------
local locale = GetLocale()  -- e.g. "enUS", "ruRU", "zhCN", "zhTW"

if locale == "ruRU" then
    -- Russian
    L.loaded        = "[GoldSpamBlocker] v2.0 активен. Введите /gsb для справки."
    L.enabled       = "[GSB] Фильтр |cff00ff00включён|r."
    L.disabled      = "[GSB] Фильтр |cffff4444отключён|r."
    L.trade_on      = "[GSB] Фильтр Trade: |cff00ff00ВКЛ|r"
    L.trade_off     = "[GSB] Фильтр Trade: |cffff4444ВЫКЛ|r"
    L.general_on    = "[GSB] Фильтр General/LFG: |cff00ff00ВКЛ|r"
    L.general_off   = "[GSB] Фильтр General/LFG: |cffff4444ВЫКЛ|r"
    L.whisper_on    = "[GSB] Фильтр Whisper: |cff00ff00ВКЛ|r"
    L.whisper_off   = "[GSB] Фильтр Whisper: |cffff4444ВЫКЛ|r"
    L.stats         = "[GSB] Заблокировано сообщений за сессию: "
    L.list_header   = "[GSB] Активные паттерны (%d):"
    L.added         = "[GSB] Добавлен паттерн #%d: |cffffd700%s|r"
    L.duplicate     = "[GSB] Паттерн уже существует: |cffffd700%s|r"
    L.removed       = "[GSB] Удалён паттерн #%d: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Использование: /gsb remove <номер>  —  /gsb list покажет номера"
    L.test_blocked  = "[GSB] ЗАБЛОКИРОВАНО — совпадение с паттерном спама."
    L.test_clean    = "[GSB] ЧИСТО — это сообщение не было бы заблокировано."
    L.help = {
        "[GoldSpamBlocker] Команды:",
        "  /gsb on / off         — Включить или отключить",
        "  /gsb trade            — Переключить фильтр Trade",
        "  /gsb general          — Переключить фильтр General/LFG",
        "  /gsb whisper          — Переключить фильтр Whisper",
        "  /gsb stats            — Количество блокировок за сессию",
        "  /gsb log             — Открыть/закрыть журнал блокировок",
        "  /gsb log clear       — Очистить журнал",
        "  /gsb list             — Список паттернов с номерами",
        "  /gsb add <паттерн>    — Добавить паттерн (сохраняется)",
        "  /gsb remove <№>       — Удалить паттерн по номеру",
        "  /gsb test <сообщение> — Проверить сообщение",
    }

elseif locale == "zhCN" or locale == "zhTW" then
    -- Chinese (Simplified / Traditional)
    L.loaded        = "[GoldSpamBlocker] v2.0 已启动。输入 /gsb 查看帮助。"
    L.enabled       = "[GSB] 过滤器 |cff00ff00已启用|r。"
    L.disabled      = "[GSB] 过滤器 |cffff4444已禁用|r。"
    L.trade_on      = "[GSB] 交易频道过滤：|cff00ff00开|r"
    L.trade_off     = "[GSB] 交易频道过滤：|cffff4444关|r"
    L.general_on    = "[GSB] 综合/LFG频道过滤：|cff00ff00开|r"
    L.general_off   = "[GSB] 综合/LFG频道过滤：|cffff4444关|r"
    L.whisper_on    = "[GSB] 密语过滤：|cff00ff00开|r"
    L.whisper_off   = "[GSB] 密语过滤：|cffff4444关|r"
    L.stats         = "[GSB] 本次会话已拦截消息数："
    L.list_header   = "[GSB] 当前规则（共 %d 条）："
    L.added         = "[GSB] 已添加规则 #%d：|cffffd700%s|r"
    L.duplicate     = "[GSB] 规则已存在：|cffffd700%s|r"
    L.removed       = "[GSB] 已删除规则 #%d：|cffffd700%s|r"
    L.remove_usage  = "[GSB] 用法：/gsb remove <编号>  —  用 /gsb list 查看编号"
    L.test_blocked  = "[GSB] 已拦截 — 匹配到垃圾信息规则。"
    L.test_clean    = "[GSB] 正常 — 该消息不会被拦截。"
    L.help = {
        "[GoldSpamBlocker] 命令列表：",
        "  /gsb on / off         — 启用或禁用过滤器",
        "  /gsb trade            — 切换交易频道过滤",
        "  /gsb general          — 切换综合/LFG频道过滤",
        "  /gsb whisper          — 切换密语过滤",
        "  /gsb stats            — 查看本次拦截数量",
        "  /gsb log             — 打开/关闭拦截记录窗口",
        "  /gsb log clear       — 清空记录",
        "  /gsb list             — 列出所有规则及编号",
        "  /gsb add <规则>       — 添加规则（跨会话保存）",
        "  /gsb remove <编号>    — 按编号删除规则",
        "  /gsb test <消息>      — 测试某条消息是否会被拦截",
    }

elseif locale == "plPL" then
    -- Polish
    L.loaded        = "[GoldSpamBlocker] v2.0 aktywny. Wpisz /gsb po pomoc."
    L.enabled       = "[GSB] Filtr |cff00ff00włączony|r."
    L.disabled      = "[GSB] Filtr |cffff4444wyłączony|r."
    L.trade_on      = "[GSB] Filtr Trade: |cff00ff00WŁ|r"
    L.trade_off     = "[GSB] Filtr Trade: |cffff4444WYŁ|r"
    L.general_on    = "[GSB] Filtr General/LFG: |cff00ff00WŁ|r"
    L.general_off   = "[GSB] Filtr General/LFG: |cffff4444WYŁ|r"
    L.whisper_on    = "[GSB] Filtr Szeptów: |cff00ff00WŁ|r"
    L.whisper_off   = "[GSB] Filtr Szeptów: |cffff4444WYŁ|r"
    L.stats         = "[GSB] Zablokowane wiadomości w tej sesji: "
    L.list_header   = "[GSB] Aktywne wzorce (%d):"
    L.added         = "[GSB] Dodano wzorzec #%d: |cffffd700%s|r"
    L.duplicate     = "[GSB] Wzorzec już istnieje: |cffffd700%s|r"
    L.removed       = "[GSB] Usunięto wzorzec #%d: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Użycie: /gsb remove <numer>  —  /gsb list pokaże numery"
    L.test_blocked  = "[GSB] ZABLOKOWANO — pasuje do wzorca spamu."
    L.test_clean    = "[GSB] CZYSTE — ta wiadomość nie zostałaby zablokowana."
    L.help = {
        "[GoldSpamBlocker] Komendy:",
        "  /gsb on / off         — Włącz lub wyłącz filtr",
        "  /gsb trade            — Przełącz filtr kanału Trade",
        "  /gsb general          — Przełącz filtr kanału General/LFG",
        "  /gsb whisper          — Przełącz filtr Szeptów",
        "  /gsb stats            — Liczba blokad w tej sesji",
        "  /gsb log             — Otwórz/zamknij podgląd zablokowanych",
        "  /gsb log clear       — Wyczyść log",
        "  /gsb list             — Lista wzorców z numerami",
        "  /gsb add <wzorzec>    — Dodaj wzorzec (zapisywany między sesjami)",
        "  /gsb remove <nr>      — Usuń wzorzec według numeru",
        "  /gsb test <wiadomość> — Sprawdź czy wiadomość byłaby zablokowana",
    }

else
    -- English (default)
    L.loaded        = "[GoldSpamBlocker] v2.0 active. Type /gsb for help."
    L.enabled       = "[GSB] Filter |cff00ff00enabled|r."
    L.disabled      = "[GSB] Filter |cffff4444disabled|r."
    L.trade_on      = "[GSB] Trade filter: |cff00ff00ON|r"
    L.trade_off     = "[GSB] Trade filter: |cffff4444OFF|r"
    L.general_on    = "[GSB] General/LFG filter: |cff00ff00ON|r"
    L.general_off   = "[GSB] General/LFG filter: |cffff4444OFF|r"
    L.whisper_on    = "[GSB] Whisper filter: |cff00ff00ON|r"
    L.whisper_off   = "[GSB] Whisper filter: |cffff4444OFF|r"
    L.stats         = "[GSB] Messages blocked this session: "
    L.list_header   = "[GSB] Active patterns (%d):"
    L.added         = "[GSB] Added pattern #%d: |cffffd700%s|r"
    L.duplicate     = "[GSB] Pattern already exists: |cffffd700%s|r"
    L.removed       = "[GSB] Removed pattern #%d: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Usage: /gsb remove <number>  —  use /gsb list to see numbers"
    L.test_blocked  = "[GSB] BLOCKED — matched a spam pattern."
    L.test_clean    = "[GSB] CLEAN — this message would not be blocked."
    L.help = {
        "[GoldSpamBlocker] Commands:",
        "  /gsb on / off         — Enable or disable the filter",
        "  /gsb trade            — Toggle Trade channel filtering",
        "  /gsb general          — Toggle General/LFG filtering",
        "  /gsb whisper          — Toggle Whisper filtering",
        "  /gsb stats            — Block count for this session",
        "  /gsb log             — Open/close blocked message viewer",
        "  /gsb log clear       — Clear the log",
        "  /gsb list             — List all patterns with index numbers",
        "  /gsb add <pattern>    — Add a Lua pattern (saved across sessions)",
        "  /gsb remove <#>       — Remove a pattern by list number",
        "  /gsb test <message>   — Check if a message would be blocked",
    }
end
