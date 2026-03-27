# GoldSpamBlocker v2.0

A lightweight WoW addon for the **3.3.5a (WotLK)** client that silently suppresses gold-seller spam before it ever appears in your chat. No popups, no sounds — the message simply never existed.

Built for **Stormforge Frostmourne**. Localized for the four languages on the server: English, Polish, Russian, and Chinese.

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

- **URLs** — the single most reliable tell (`www.`, `.com`, `http`, obfuscated variants like `d0t`, `w w w`)
- **Gold-selling keywords** in English, Polish, Russian, and Chinese
- **Price signals** — `$29`, `500k gold`, `usd`, `paypal`
- **Known site name fragments** — igxe, mmoga, eldorado, playerauctions, etc.

Patterns are stored as a `SavedVariable`, so anything you add with `/gsb add` persists across sessions and characters on the same account.

---

## Channels Filtered

| Channel | Default |
|---|---|
| Trade | ✅ On |
| General / LFG | ✅ On |
| Whisper (incoming + outgoing echo) | ✅ On |

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
| `/gsb list` | List all active patterns with their index numbers |
| `/gsb add <pattern>` | Add a new Lua pattern (saved across sessions) |
| `/gsb remove <#>` | Remove a pattern by its list number |
| `/gsb test <message>` | Check whether a message would be blocked |

### Pattern syntax

Patterns use standard [Lua pattern matching](https://www.lua.org/manual/5.1/manual.html#5.4.1). A few useful examples:

```
/gsb add goldsite        -- simple substring match
/gsb add gold.?site      -- matches "goldsite" or "gold site" or "gold-site"
/gsb add %d+g%s+wow      -- matches "500g wow", "1000g  wow", etc.
```

Use `/gsb test` after adding a pattern to confirm it works before adding more.

---

## Localization

The addon automatically detects your client locale and switches UI language accordingly:

| Locale | Language |
|---|---|
| `enUS`, `enGB`, others | English (default) |
| `ruRU` | Russian / Русский |
| `zhCN`, `zhTW` | Chinese / 中文 |
| `plPL` | Polish / Polski |

Spam patterns for all four languages are always active regardless of your client locale — a Russian spammer's message will be caught even if you're running an English client.

---

## Troubleshooting

**A spam message slipped through.**
Copy a unique fragment from it and add it: `/gsb add <fragment>`. Then `/gsb test <fragment>` to confirm.

**A legitimate message is being blocked.**
Use `/gsb list` to find the offending pattern number, then `/gsb remove <#>` to remove it.

**I want to reset to the default pattern list.**
Type `/gsb off`, then delete the `GoldSpamBlocker.lua` entry from your `WTF/Account/<name>/SavedVariables/` folder and reload.

---

## Files

```
GoldSpamBlocker/
├── GoldSpamBlocker.toc   — Addon manifest (Interface: 30300)
├── GoldSpamBlocker.lua   — Core filter logic and slash commands
└── Localization.lua      — UI strings for EN / PL / RU / ZH
```

---

*Compatible with WoW client version 3.3.5a (Interface 30300). Tested on Stormforge Frostmourne.*
