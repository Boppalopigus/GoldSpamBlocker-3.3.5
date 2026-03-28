-- GoldSpamBlocker: Localization
-- All 11 WoW 3.3.5a locale codes:
--   enUS, enGB, deDE, frFR, esES, esMX, ptBR, ptPT, ruRU, zhCN, zhTW, koKR

local L = {}
GSB_L = L

local locale = GetLocale()

-- -----------------------------------------------------------------------
-- Helper to build the standard help table from a few translated strings.
-- Slash command names are always English so they stay the same in every locale.
-- -----------------------------------------------------------------------
local function MakeHelp(header, on_off, trade, general, whisper, stats, log, log_clear, list, add, remove, test)
    return {
        header,
        "  /gsb on / off         — " .. on_off,
        "  /gsb trade            — " .. trade,
        "  /gsb general          — " .. general,
        "  /gsb whisper          — " .. whisper,
        "  /gsb stats            — " .. stats,
        "  /gsb log              — " .. log,
        "  /gsb log clear        — " .. log_clear,
        "  /gsb list             — " .. list,
        "  /gsb add <pattern>    — " .. add,
        "  /gsb remove <#>       — " .. remove,
        "  /gsb test <message>   — " .. test,
    }
end

-- -----------------------------------------------------------------------
-- German (deDE)
-- -----------------------------------------------------------------------
if locale == "deDE" then
    L.loaded        = "[GoldSpamBlocker] v2.0 aktiv. Tippe /gsb für Hilfe."
    L.enabled       = "[GSB] Filter |cff00ff00aktiviert|r."
    L.disabled      = "[GSB] Filter |cffff4444deaktiviert|r."
    L.trade_on      = "[GSB] Handelskanal-Filter: |cff00ff00AN|r"
    L.trade_off     = "[GSB] Handelskanal-Filter: |cffff4444AUS|r"
    L.general_on    = "[GSB] Allgemein/LFG-Filter: |cff00ff00AN|r"
    L.general_off   = "[GSB] Allgemein/LFG-Filter: |cffff4444AUS|r"
    L.whisper_on    = "[GSB] Flüster-Filter: |cff00ff00AN|r"
    L.whisper_off   = "[GSB] Flüster-Filter: |cffff4444AUS|r"
    L.stats         = "[GSB] Blockierte Nachrichten diese Sitzung: "
    L.list_header   = "[GSB] Aktive Muster (%d):"
    L.added         = "[GSB] Muster #%d hinzugefügt: |cffffd700%s|r"
    L.duplicate     = "[GSB] Muster existiert bereits: |cffffd700%s|r"
    L.removed       = "[GSB] Muster #%d entfernt: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Verwendung: /gsb remove <Nummer>  —  /gsb list zeigt Nummern"
    L.test_blocked  = "[GSB] BLOCKIERT — entspricht einem Spam-Muster."
    L.test_clean    = "[GSB] SAUBER — diese Nachricht würde nicht blockiert."
    L.help = MakeHelp(
        "[GoldSpamBlocker] Befehle:",
        "Filter ein- oder ausschalten",
        "Handelskanal-Filter umschalten",
        "Allgemein/LFG-Filter umschalten",
        "Flüster-Filter umschalten",
        "Anzahl der Blockierungen diese Sitzung",
        "Protokollfenster öffnen/schließen",
        "Protokoll leeren",
        "Alle Muster mit Nummern anzeigen",
        "Muster hinzufügen (bleibt gespeichert)",
        "Muster anhand der Nummer entfernen",
        "Prüfen ob eine Nachricht blockiert würde"
    )

-- -----------------------------------------------------------------------
-- French (frFR)
-- -----------------------------------------------------------------------
elseif locale == "frFR" then
    L.loaded        = "[GoldSpamBlocker] v2.0 actif. Tapez /gsb pour l'aide."
    L.enabled       = "[GSB] Filtre |cff00ff00activé|r."
    L.disabled      = "[GSB] Filtre |cffff4444désactivé|r."
    L.trade_on      = "[GSB] Filtre Commerce: |cff00ff00ON|r"
    L.trade_off     = "[GSB] Filtre Commerce: |cffff4444OFF|r"
    L.general_on    = "[GSB] Filtre Général/LFG: |cff00ff00ON|r"
    L.general_off   = "[GSB] Filtre Général/LFG: |cffff4444OFF|r"
    L.whisper_on    = "[GSB] Filtre Chuchotement: |cff00ff00ON|r"
    L.whisper_off   = "[GSB] Filtre Chuchotement: |cffff4444OFF|r"
    L.stats         = "[GSB] Messages bloqués cette session: "
    L.list_header   = "[GSB] Modèles actifs (%d):"
    L.added         = "[GSB] Modèle #%d ajouté: |cffffd700%s|r"
    L.duplicate     = "[GSB] Modèle déjà existant: |cffffd700%s|r"
    L.removed       = "[GSB] Modèle #%d supprimé: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Usage: /gsb remove <numéro>  —  /gsb list affiche les numéros"
    L.test_blocked  = "[GSB] BLOQUÉ — correspond à un modèle de spam."
    L.test_clean    = "[GSB] PROPRE — ce message ne serait pas bloqué."
    L.help = MakeHelp(
        "[GoldSpamBlocker] Commandes:",
        "Activer ou désactiver le filtre",
        "Basculer le filtre Commerce",
        "Basculer le filtre Général/LFG",
        "Basculer le filtre Chuchotement",
        "Nombre de blocages cette session",
        "Ouvrir/fermer le journal des blocages",
        "Effacer le journal",
        "Lister tous les modèles avec numéros",
        "Ajouter un modèle (sauvegardé)",
        "Supprimer un modèle par numéro",
        "Tester si un message serait bloqué"
    )

-- -----------------------------------------------------------------------
-- Spanish — Spain (esES)
-- -----------------------------------------------------------------------
elseif locale == "esES" then
    L.loaded        = "[GoldSpamBlocker] v2.0 activo. Escribe /gsb para ayuda."
    L.enabled       = "[GSB] Filtro |cff00ff00activado|r."
    L.disabled      = "[GSB] Filtro |cffff4444desactivado|r."
    L.trade_on      = "[GSB] Filtro Comercio: |cff00ff00ON|r"
    L.trade_off     = "[GSB] Filtro Comercio: |cffff4444OFF|r"
    L.general_on    = "[GSB] Filtro General/LFG: |cff00ff00ON|r"
    L.general_off   = "[GSB] Filtro General/LFG: |cffff4444OFF|r"
    L.whisper_on    = "[GSB] Filtro Susurro: |cff00ff00ON|r"
    L.whisper_off   = "[GSB] Filtro Susurro: |cffff4444OFF|r"
    L.stats         = "[GSB] Mensajes bloqueados esta sesión: "
    L.list_header   = "[GSB] Patrones activos (%d):"
    L.added         = "[GSB] Patrón #%d añadido: |cffffd700%s|r"
    L.duplicate     = "[GSB] El patrón ya existe: |cffffd700%s|r"
    L.removed       = "[GSB] Patrón #%d eliminado: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Uso: /gsb remove <número>  —  /gsb list muestra los números"
    L.test_blocked  = "[GSB] BLOQUEADO — coincide con un patrón de spam."
    L.test_clean    = "[GSB] LIMPIO — este mensaje no sería bloqueado."
    L.help = MakeHelp(
        "[GoldSpamBlocker] Comandos:",
        "Activar o desactivar el filtro",
        "Alternar filtro de Comercio",
        "Alternar filtro de General/LFG",
        "Alternar filtro de Susurro",
        "Número de bloqueos esta sesión",
        "Abrir/cerrar registro de bloqueados",
        "Limpiar el registro",
        "Listar todos los patrones con números",
        "Añadir un patrón (se guarda entre sesiones)",
        "Eliminar un patrón por número",
        "Comprobar si un mensaje sería bloqueado"
    )

-- -----------------------------------------------------------------------
-- Spanish — Latin America (esMX)
-- -----------------------------------------------------------------------
elseif locale == "esMX" then
    L.loaded        = "[GoldSpamBlocker] v2.0 activo. Escribe /gsb para ayuda."
    L.enabled       = "[GSB] Filtro |cff00ff00activado|r."
    L.disabled      = "[GSB] Filtro |cffff4444desactivado|r."
    L.trade_on      = "[GSB] Filtro Comercio: |cff00ff00ON|r"
    L.trade_off     = "[GSB] Filtro Comercio: |cffff4444OFF|r"
    L.general_on    = "[GSB] Filtro General/LFG: |cff00ff00ON|r"
    L.general_off   = "[GSB] Filtro General/LFG: |cffff4444OFF|r"
    L.whisper_on    = "[GSB] Filtro Susurro: |cff00ff00ON|r"
    L.whisper_off   = "[GSB] Filtro Susurro: |cffff4444OFF|r"
    L.stats         = "[GSB] Mensajes bloqueados esta sesión: "
    L.list_header   = "[GSB] Patrones activos (%d):"
    L.added         = "[GSB] Patrón #%d agregado: |cffffd700%s|r"
    L.duplicate     = "[GSB] El patrón ya existe: |cffffd700%s|r"
    L.removed       = "[GSB] Patrón #%d eliminado: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Uso: /gsb remove <número>  —  /gsb list muestra los números"
    L.test_blocked  = "[GSB] BLOQUEADO — coincide con un patrón de spam."
    L.test_clean    = "[GSB] LIMPIO — este mensaje no sería bloqueado."
    L.help = MakeHelp(
        "[GoldSpamBlocker] Comandos:",
        "Activar o desactivar el filtro",
        "Alternar filtro de Comercio",
        "Alternar filtro de General/LFG",
        "Alternar filtro de Susurro",
        "Número de bloqueos esta sesión",
        "Abrir/cerrar registro de bloqueados",
        "Limpiar el registro",
        "Listar todos los patrones con números",
        "Agregar un patrón (se guarda entre sesiones)",
        "Eliminar un patrón por número",
        "Verificar si un mensaje sería bloqueado"
    )

-- -----------------------------------------------------------------------
-- Portuguese — Brazil (ptBR)
-- -----------------------------------------------------------------------
elseif locale == "ptBR" then
    L.loaded        = "[GoldSpamBlocker] v2.0 ativo. Digite /gsb para ajuda."
    L.enabled       = "[GSB] Filtro |cff00ff00ativado|r."
    L.disabled      = "[GSB] Filtro |cffff4444desativado|r."
    L.trade_on      = "[GSB] Filtro Comércio: |cff00ff00ON|r"
    L.trade_off     = "[GSB] Filtro Comércio: |cffff4444OFF|r"
    L.general_on    = "[GSB] Filtro Geral/LFG: |cff00ff00ON|r"
    L.general_off   = "[GSB] Filtro Geral/LFG: |cffff4444OFF|r"
    L.whisper_on    = "[GSB] Filtro Sussurro: |cff00ff00ON|r"
    L.whisper_off   = "[GSB] Filtro Sussurro: |cffff4444OFF|r"
    L.stats         = "[GSB] Mensagens bloqueadas nesta sessão: "
    L.list_header   = "[GSB] Padrões ativos (%d):"
    L.added         = "[GSB] Padrão #%d adicionado: |cffffd700%s|r"
    L.duplicate     = "[GSB] Padrão já existe: |cffffd700%s|r"
    L.removed       = "[GSB] Padrão #%d removido: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Uso: /gsb remove <número>  —  /gsb list mostra os números"
    L.test_blocked  = "[GSB] BLOQUEADO — corresponde a um padrão de spam."
    L.test_clean    = "[GSB] LIMPO — esta mensagem não seria bloqueada."
    L.help = MakeHelp(
        "[GoldSpamBlocker] Comandos:",
        "Ativar ou desativar o filtro",
        "Alternar filtro de Comércio",
        "Alternar filtro de Geral/LFG",
        "Alternar filtro de Sussurro",
        "Número de bloqueios nesta sessão",
        "Abrir/fechar registro de bloqueados",
        "Limpar o registro",
        "Listar todos os padrões com números",
        "Adicionar um padrão (salvo entre sessões)",
        "Remover um padrão pelo número",
        "Verificar se uma mensagem seria bloqueada"
    )

-- -----------------------------------------------------------------------
-- Portuguese — Portugal (ptPT)
-- -----------------------------------------------------------------------
elseif locale == "ptPT" then
    L.loaded        = "[GoldSpamBlocker] v2.0 ativo. Escreve /gsb para ajuda."
    L.enabled       = "[GSB] Filtro |cff00ff00ativado|r."
    L.disabled      = "[GSB] Filtro |cffff4444desativado|r."
    L.trade_on      = "[GSB] Filtro Comércio: |cff00ff00ON|r"
    L.trade_off     = "[GSB] Filtro Comércio: |cffff4444OFF|r"
    L.general_on    = "[GSB] Filtro Geral/LFG: |cff00ff00ON|r"
    L.general_off   = "[GSB] Filtro Geral/LFG: |cffff4444OFF|r"
    L.whisper_on    = "[GSB] Filtro Sussurro: |cff00ff00ON|r"
    L.whisper_off   = "[GSB] Filtro Sussurro: |cffff4444OFF|r"
    L.stats         = "[GSB] Mensagens bloqueadas nesta sessão: "
    L.list_header   = "[GSB] Padrões ativos (%d):"
    L.added         = "[GSB] Padrão #%d adicionado: |cffffd700%s|r"
    L.duplicate     = "[GSB] Padrão já existe: |cffffd700%s|r"
    L.removed       = "[GSB] Padrão #%d removido: |cffffd700%s|r"
    L.remove_usage  = "[GSB] Uso: /gsb remove <número>  —  /gsb list mostra os números"
    L.test_blocked  = "[GSB] BLOQUEADO — corresponde a um padrão de spam."
    L.test_clean    = "[GSB] LIMPO — esta mensagem não seria bloqueada."
    L.help = MakeHelp(
        "[GoldSpamBlocker] Comandos:",
        "Ativar ou desativar o filtro",
        "Alternar filtro de Comércio",
        "Alternar filtro de Geral/LFG",
        "Alternar filtro de Sussurro",
        "Número de bloqueios nesta sessão",
        "Abrir/fechar registo de bloqueados",
        "Limpar o registo",
        "Listar todos os padrões com números",
        "Adicionar um padrão (guardado entre sessões)",
        "Remover um padrão pelo número",
        "Verificar se uma mensagem seria bloqueada"
    )

-- -----------------------------------------------------------------------
-- Russian (ruRU)
-- -----------------------------------------------------------------------
elseif locale == "ruRU" then
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
    L.help = MakeHelp(
        "[GoldSpamBlocker] Команды:",
        "Включить или отключить фильтр",
        "Переключить фильтр Trade",
        "Переключить фильтр General/LFG",
        "Переключить фильтр Whisper",
        "Количество блокировок за сессию",
        "Открыть/закрыть журнал блокировок",
        "Очистить журнал",
        "Список паттернов с номерами",
        "Добавить паттерн (сохраняется)",
        "Удалить паттерн по номеру",
        "Проверить сообщение"
    )

-- -----------------------------------------------------------------------
-- Chinese Simplified (zhCN)
-- -----------------------------------------------------------------------
elseif locale == "zhCN" then
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
    L.help = MakeHelp(
        "[GoldSpamBlocker] 命令列表：",
        "启用或禁用过滤器",
        "切换交易频道过滤",
        "切换综合/LFG频道过滤",
        "切换密语过滤",
        "查看本次拦截数量",
        "打开/关闭拦截记录窗口",
        "清空记录",
        "列出所有规则及编号",
        "添加规则（跨会话保存）",
        "按编号删除规则",
        "测试某条消息是否会被拦截"
    )

-- -----------------------------------------------------------------------
-- Chinese Traditional (zhTW)
-- -----------------------------------------------------------------------
elseif locale == "zhTW" then
    L.loaded        = "[GoldSpamBlocker] v2.0 已啟動。輸入 /gsb 查看說明。"
    L.enabled       = "[GSB] 過濾器 |cff00ff00已啟用|r。"
    L.disabled      = "[GSB] 過濾器 |cffff4444已停用|r。"
    L.trade_on      = "[GSB] 交易頻道過濾：|cff00ff00開|r"
    L.trade_off     = "[GSB] 交易頻道過濾：|cffff4444關|r"
    L.general_on    = "[GSB] 綜合/LFG頻道過濾：|cff00ff00開|r"
    L.general_off   = "[GSB] 綜合/LFG頻道過濾：|cffff4444關|r"
    L.whisper_on    = "[GSB] 密語過濾：|cff00ff00開|r"
    L.whisper_off   = "[GSB] 密語過濾：|cffff4444關|r"
    L.stats         = "[GSB] 本次工作階段已攔截訊息數："
    L.list_header   = "[GSB] 目前規則（共 %d 條）："
    L.added         = "[GSB] 已新增規則 #%d：|cffffd700%s|r"
    L.duplicate     = "[GSB] 規則已存在：|cffffd700%s|r"
    L.removed       = "[GSB] 已刪除規則 #%d：|cffffd700%s|r"
    L.remove_usage  = "[GSB] 用法：/gsb remove <編號>  —  用 /gsb list 查看編號"
    L.test_blocked  = "[GSB] 已攔截 — 符合垃圾訊息規則。"
    L.test_clean    = "[GSB] 正常 — 該訊息不會被攔截。"
    L.help = MakeHelp(
        "[GoldSpamBlocker] 指令列表：",
        "啟用或停用過濾器",
        "切換交易頻道過濾",
        "切換綜合/LFG頻道過濾",
        "切換密語過濾",
        "查看本次攔截數量",
        "開啟/關閉攔截記錄視窗",
        "清空記錄",
        "列出所有規則及編號",
        "新增規則（跨工作階段儲存）",
        "依編號刪除規則",
        "測試某則訊息是否會被攔截"
    )

-- -----------------------------------------------------------------------
-- Korean (koKR)
-- -----------------------------------------------------------------------
elseif locale == "koKR" then
    L.loaded        = "[GoldSpamBlocker] v2.0 활성화됨. /gsb 를 입력하여 도움말을 확인하세요."
    L.enabled       = "[GSB] 필터 |cff00ff00활성화|r."
    L.disabled      = "[GSB] 필터 |cffff4444비활성화|r."
    L.trade_on      = "[GSB] 거래 채널 필터: |cff00ff00켜짐|r"
    L.trade_off     = "[GSB] 거래 채널 필터: |cffff4444꺼짐|r"
    L.general_on    = "[GSB] 일반/LFG 필터: |cff00ff00켜짐|r"
    L.general_off   = "[GSB] 일반/LFG 필터: |cffff4444꺼짐|r"
    L.whisper_on    = "[GSB] 귓속말 필터: |cff00ff00켜짐|r"
    L.whisper_off   = "[GSB] 귓속말 필터: |cffff4444꺼짐|r"
    L.stats         = "[GSB] 이번 세션에서 차단된 메시지: "
    L.list_header   = "[GSB] 활성 패턴 (%d)개:"
    L.added         = "[GSB] 패턴 #%d 추가됨: |cffffd700%s|r"
    L.duplicate     = "[GSB] 패턴이 이미 존재합니다: |cffffd700%s|r"
    L.removed       = "[GSB] 패턴 #%d 제거됨: |cffffd700%s|r"
    L.remove_usage  = "[GSB] 사용법: /gsb remove <번호>  —  /gsb list 로 번호 확인"
    L.test_blocked  = "[GSB] 차단됨 — 스팸 패턴과 일치합니다."
    L.test_clean    = "[GSB] 정상 — 이 메시지는 차단되지 않습니다."
    L.help = MakeHelp(
        "[GoldSpamBlocker] 명령어:",
        "필터 활성화 또는 비활성화",
        "거래 채널 필터 전환",
        "일반/LFG 필터 전환",
        "귓속말 필터 전환",
        "이번 세션 차단 횟수 보기",
        "차단 로그 창 열기/닫기",
        "로그 초기화",
        "번호와 함께 모든 패턴 나열",
        "패턴 추가 (세션 간 저장됨)",
        "번호로 패턴 제거",
        "메시지가 차단될지 테스트"
    )

-- -----------------------------------------------------------------------
-- Polish (plPL)
-- -----------------------------------------------------------------------
elseif locale == "plPL" then
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
    L.help = MakeHelp(
        "[GoldSpamBlocker] Komendy:",
        "Włącz lub wyłącz filtr",
        "Przełącz filtr kanału Trade",
        "Przełącz filtr kanału General/LFG",
        "Przełącz filtr Szeptów",
        "Liczba blokad w tej sesji",
        "Otwórz/zamknij podgląd zablokowanych",
        "Wyczyść log",
        "Lista wzorców z numerami",
        "Dodaj wzorzec (zapisywany między sesjami)",
        "Usuń wzorzec według numeru",
        "Sprawdź czy wiadomość byłaby zablokowana"
    )

-- -----------------------------------------------------------------------
-- English — default fallback (enUS, enGB, and anything unrecognised)
-- -----------------------------------------------------------------------
else
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
    L.help = MakeHelp(
        "[GoldSpamBlocker] Commands:",
        "Enable or disable the filter",
        "Toggle Trade channel filtering",
        "Toggle General/LFG filtering",
        "Toggle Whisper filtering",
        "Block count for this session",
        "Open/close blocked message viewer",
        "Clear the log",
        "List all patterns with index numbers",
        "Add a Lua pattern (saved across sessions)",
        "Remove a pattern by list number",
        "Check if a message would be blocked"
    )
end
