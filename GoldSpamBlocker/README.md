# GoldSpamBlocker v2.0

A lightweight WoW addon for the **3.3.5a (WotLK)** client that silently suppresses gold-seller spam before it ever appears in your chat. No popups, no sounds — the message simply never existed.

Built for **Stormforge Frostmourne**. UI and spam patterns localized for all 11 WoW locale codes.

---

## Installation

1. Download and unzip — you should have a folder called `GoldSpamBlocker`.
2. Place it in:
   ```
   World of Warcraft/Interface/AddOns/GoldSpamBlocker/
   ```
3. Launch the game, log in, and enable the addon at the character select screen.
4. You'll see a confirmation message in chat when it loads.

---

## How It Works

The addon hooks into WoW's `ChatFrame_AddMessageEventFilter` API, which intercepts messages **before** they are rendered in any chat frame. Returning `true` from the filter drops the message entirely — no flash, no sound, no history entry.

Each incoming message is checked against a list of Lua patterns covering:

- **Obfuscated URLs** — tricks like `w w w.`, `d0t`, `c0m` that only spammers use. Generic TLDs like `.com` are intentionally NOT blocked to avoid false positives on links like `wowhead.com`.
- **Known spam domain names** — igxe, mmoga, eldorado.gg, g2g.com, ssegold, etc.
- **Gold-selling keywords** in all supported languages
- **Price signals** — `$29`, `paypal`

Patterns are stored as a `SavedVariable`, so anything you add with `/gsb add` persists across sessions and characters on the same account.

> **Note on SavedVariables:** If you are upgrading from an older version, your saved `GSB_Patterns` may contain overly broad patterns (like `.com` or `www.`) from earlier builds. Use `/gsb list` to review them and `/gsb remove <#>` to clean them out, or delete the `GSB_Patterns` block from your `WTF/Account/<name>/SavedVariables/GoldSpamBlocker.lua` file to reset to defaults.

---

## Channels Filtered

| Channel | Default |
|---|---|
| Trade | On |
| General / LFG | On |
| Whisper (incoming + outgoing echo) | On |

---

## Commands

All commands use `/gsb` or `/goldspamblocker`.

| Command | Description |
|---|---|
| `/gsb on` / `/gsb off` | Enable or disable the filter entirely |
| `/gsb trade` | Toggle Trade channel filtering |
| `/gsb general` | Toggle General/LFG filtering |
| `/gsb whisper` | Toggle Whisper filtering |
| `/gsb stats` | Show how many messages have been blocked this session |
| `/gsb log` | Open or close the blocked message viewer |
| `/gsb log clear` | Wipe the log |
| `/gsb list` | List all active patterns with their index numbers |
| `/gsb add <pattern>` | Add a new Lua pattern (saved across sessions) |
| `/gsb remove <#>` | Remove a pattern by its list number |
| `/gsb test <message>` | Check whether a message would be blocked |

### Pattern syntax

Patterns use standard Lua pattern matching. A few useful examples:

```
/gsb add goldsite            -- simple substring match
/gsb add gold.?site          -- matches "goldsite", "gold site", "gold-site"
/gsb add %d+g%s+wow          -- matches "500g wow", "1000g  wow", etc.
```

Use `/gsb test` after adding a pattern to confirm it works.

---

## Blocked Message Log

`/gsb log` opens a draggable, scrollable window showing every message blocked this session. Each entry shows the time, channel, sender, and the full message text. The log holds up to 200 entries; oldest entries drop off when it fills. The log is session-only and is never written to disk.

Use the mouse wheel or the scrollbar on the right to navigate. The **Clear** button wipes all entries.

---

## Localization

The addon automatically detects your client locale and switches the UI language accordingly. Spam patterns for all languages are always active regardless of your own client locale.

| Locale code(s) | Language |
|---|---|
| `enUS`, `enGB` | English (default fallback) |
| `deDE` | German / Deutsch |
| `frFR` | French / Francais |
| `esES` | Spanish (Spain) / Espanol |
| `esMX` | Spanish (Latin America) / Espanol |
| `ptBR` | Portuguese (Brazil) / Portugues |
| `ptPT` | Portuguese (Portugal) / Portugues |
| `ruRU` | Russian |
| `zhCN` | Chinese Simplified |
| `zhTW` | Chinese Traditional |
| `koKR` | Korean |
| `plPL` | Polish / Polski |

---

## Troubleshooting

**A spam message slipped through.**
Copy a unique fragment and add it: `/gsb add <fragment>`. Confirm with `/gsb test <fragment>`.

**A legitimate message is being blocked.**
Use `/gsb list` to find the offending pattern, then `/gsb remove <#>`. The most common cause on upgrades is stale broad patterns left over in SavedVariables — see the note in the How It Works section above.

**The log shows entry count but no text.**
This was a known issue with an earlier version that used ScrollingMessageFrame. If you are on the latest version and still seeing it, delete the addon's SavedVariables file and reload.

---

## Files

```
GoldSpamBlocker/
├── GoldSpamBlocker.toc   — Addon manifest (Interface: 30300)
├── GoldSpamBlocker.lua   — Core filter logic, log UI, and slash commands
├── Localization.lua      — UI strings for all 12 locale branches
└── README.md
```

*Compatible with WoW client version 3.3.5a (Interface 30300). Tested on Stormforge Frostmourne.*
