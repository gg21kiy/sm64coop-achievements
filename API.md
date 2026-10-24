# 🛠️ SM64Coop Achievements - Developer API Documentation

Welcome to the official **SM64Coop Achievements API** documentation! This framework allows any mod developer to register custom achievements, load custom textures, and set up automatic or manual unlock triggers that integrate seamlessly into the main Achievements Menu and popup system.

---

## 📁 1. Recommended Folder Structure

If you are creating a standalone achievement pack, use the `[AM]` prefix in your folder name so players easily recognize it as an Achievement Mod addon. Place all your custom achievement icons (`.png`) inside a `textures/` folder:

```text
[AM] My Custom Achievements/
├── main.lua
└── textures/
    ├── ex_backflip.png
    ├── ex_snow.png
    └── ex_coins.png
```

---

## 💻 2. Quick Start (`main.lua`)

Wait for `HOOK_ON_MODS_LOADED` to ensure the main Achievements Mod is initialized, then use `_G.AchievementsAPI.register()` to add your achievements.

To load a custom icon from your mod's `textures/` folder, pass `get_texture_info("exact_filename")` (without the `.png` extension):

```lua
-- name: [AM] My Custom Achievements
-- description: Adds custom achievements to SM64Coop Achievements!

-- Helper function to load PNGs from your mod's /textures/ folder
local function tex(name)
    return get_texture_info(name)
end

hook_event(HOOK_ON_MODS_LOADED, function()
    -- 1. Always verify that the base Achievements Mod is active
    if not _G.AchievementsAPI then
        djui_chat_message_create("\\#ff5555\\[AM Pack]\\#ffffff Requires SM64Coop Achievements Mod!")
        return
    end

    local API = _G.AchievementsAPI

    -- 2. Register your achievements
    API.register({
        id      = "my_mod_backflip_5",
        title   = "Acrobatic Plumber",
        desc    = "Perform 5 backflips",
        icon    = tex("ex_backflip"), -- Loads textures/ex_backflip.png
        trigger = API.TRIGGER.ACTION,
        value   = ACT_BACKFLIP,
        goal    = 5
    })

    API.register({
        id      = "my_mod_visit_ccm",
        title   = "Winter Vacation",
        desc    = "Enter Cool, Cool Mountain",
        icon    = tex("ex_snow"),     -- Loads textures/ex_snow.png
        trigger = API.TRIGGER.LEVEL_ENTER,
        value   = LEVEL_CCM
    })
end)
```

> 💡 **Tip:** If you want to reuse a built-in icon from the base Achievements Mod (such as `"stars_1"`, `"bosses_big_bob"`, or `"ranks_splus"`), simply pass the string name directly: `icon = "stars_1"`.

---

## 📋 3. `API.register(data)` Parameters

When calling `_G.AchievementsAPI.register(data)`, the `data` table accepts the following fields:

| Field | Type | Required | Description |
| :--- | :--- | :---: | :--- |
| `id` | `string` | **Yes** | Unique identifier used for saving progress (e.g., `"mymod_secret_1"`). Cannot duplicate existing IDs. |
| `title` | `string` | **Yes** | The display name of the achievement shown in the menu and popup. |
| `desc` | `string` | **Yes** | The description explaining how to unlock the achievement. |
| `icon` | `TextureInfo` / `string` | No | Custom texture loaded via `get_texture_info("filename")` or a base mod icon name. Defaults to `"stars_1"` if omitted or not found. |
| `trigger` | `string` | No | Automatic detection mode from `API.TRIGGER.*`. Defaults to `API.TRIGGER.CUSTOM`. |
| `value` | `number` | Depends | The target constant or value required by the chosen `trigger` (e.g., `ACT_BACKFLIP`, `LEVEL_BOB`, `50`). |
| `goal` | `number` | No | How many times the trigger must happen to unlock (for counter achievements). Defaults to `1`. |

---

## 🎯 4. Built-in Automatic Triggers (`API.TRIGGER`)

You don't need to write custom hooks for common conditions. Use these built-in trigger constants in the `trigger` field:

| Trigger Constant | What to put in `value` | Supports `goal` counter? | When does it unlock? |
| :--- | :--- | :---: | :--- |
| `API.TRIGGER.ACTION` | Mario Action (`ACT_*`) | ✅ Yes | When the local player performs that exact Mario action (e.g., `ACT_WALL_KICK_AIR`, `ACT_LONG_JUMP`). |
| `API.TRIGGER.LEVEL_ENTER` | Level Constant (`LEVEL_*`) | ❌ No | Immediately when the player enters the specified course/level (e.g., `LEVEL_BOB`, `LEVEL_DDD`). |
| `API.TRIGGER.STAR_COUNT` | Number (`integer`) | ❌ No | When the player's total Power Star count reaches or exceeds `value` (e.g., `50`). |
| `API.TRIGGER.COIN_COUNT` | Number (`integer`) | ❌ No | When the player holds `value` or more coins inside a single course (e.g., `75`). |
| `API.TRIGGER.INTERACT` | Behavior ID (`id_bhv*`) | ✅ Yes | When the player interacts with an object matching that behavior ID (e.g., `id_bhvSignOnWall`, `id_bhvToadMessage`). |
| `API.TRIGGER.CUSTOM` | `nil` (Not required) | Via `add_progress` | Manual mode: only unlocks when you call `API.unlock(id)` or `API.add_progress(id, goal)` in your own Lua code. |

---

## ⚡ 5. Manual Functions (`API.TRIGGER.CUSTOM`)

If your mod has custom mechanics (custom bosses, custom gamemodes, timers, chat commands, etc.), register your achievement with `trigger = API.TRIGGER.CUSTOM` and use these functions anywhere in your scripts:

### 🔓 `_G.AchievementsAPI.unlock(id)`
Unlocks the achievement immediately, plays the unlock sound, displays the popup notification, and saves it to the player's save file.

```lua
hook_event(HOOK_MARIO_UPDATE, function(m)
    if m.playerIndex ~= 0 or not _G.AchievementsAPI then return end

    -- Example: Unlock when Mario lands a Ground Pound
    if m.action == ACT_GROUND_POUND_LAND then
        _G.AchievementsAPI.unlock("my_custom_achievement_id")
    end
end)
```

### 📈 `_G.AchievementsAPI.add_progress(id, goal)`
Adds `+1` to a persistent counter for that achievement on the current save file. Once the counter reaches `goal`, the achievement automatically unlocks!

```lua
-- Example: Unlock after collecting 10 custom items
if _G.AchievementsAPI then
    _G.AchievementsAPI.add_progress("collect_10_custom_items", 10)
end
```

### 🔍 `_G.AchievementsAPI.is_unlocked(id)`
Returns `true` if the achievement is already unlocked on the current save file, or `false` if locked. Useful for giving players rewards!

```lua
if _G.AchievementsAPI and _G.AchievementsAPI.is_unlocked("my_custom_achievement_id") then
    -- Give the player a special reward or skin!
end
```

---

## 📦 6. Example Mod Template

Want a ready-to-use template? Download the **`[AM] Example Pack`** from **[This Link](./examples/AM-Example-Pack.zip)**, drop it into your SM64CoopDX `mods/` folder alongside **SM64Coop Achievements**, and test it in-game!
