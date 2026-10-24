<div align="center"><h1>🏆 SM64 Coop Achievements</h1><h3>Moon64-style achievements for SM64CoopDX</h3>
  <p>
  <a href="https://github.com/gg21kiy/SM64Coop-Achievements/releases/latest"><img src="https://img.shields.io/badge/Version-2.1.0-blue?style=for-the-badge" alt="Version"></a>
    <a href="https://github.com/gg21kiy/sm64coop-achievements?tab=readme-ov-file#change-language"><img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Lua" />
<a href="https://github.com/coop-deluxe/sm64coopdx"><img src="https://img.shields.io/badge/SM64CoopDX-Compatible-brightgreen?style=for-the-badge&logo=nintendo&logoColor=white" alt="SM64CoopDX Compatible"></a>
<a href="https://github.com/djoslin0/sm64ex-coop"><img src="https://img.shields.io/badge/SM64ExCoop-Not%20Compatible-critical?style=for-the-badge&logo=nintendo&logoColor=white" alt="SM64ExCoop Not Compatible"></a>
  <a href="#-achievements"><img src="https://img.shields.io/badge/Achievements-46-gold?style=for-the-badge" alt="46 Achievements">
  <a href="#-change-language"><img src="https://img.shields.io/badge/Languages-7-orange?style=for-the-badge" alt="7 Languages Supported">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="MIT License"></a>
</p><br><img src="Screenshots/popup.jpg" alt="SM64 Coop Achievements" width="700"><p>
  <em>An achievement system for SM64CoopDX inspired by Moon64.</em>
</p>

[📷 Screenshots](https://github.com/gg21kiy/sm64coop-achievements#-screenshots) •
[📥 Download](https://github.com/gg21kiy/sm64coop-achievements/releases/latest) 

</div>

---

## ✨ Features

- **46 achievements** across 6 categories: Stars, Caps, Ranks, Bosses, Deaths and Extras.
- **Multi-language support (7 languages):** English, Español, Català, Galego, Euskara, Português, and Français.
- **Popup notification** when you unlock one (position, size and duration are configurable).
- **Unlock sound** selectable from the settings (none, coin, red coin, 1-UP, star sound, secret, star appears).
- **Achievements menu** with the title, description and icon of every achievement, with an "Unlocked only" filter.
- Works with **keyboard, controller and touch**.
- **Per-save-file progress**: each save file has its own achievements.
- **Cheat detection**: using a cheat from the *Cheats* mod unlocks *Caught Cheating* and (optionally) blocks further achievements on that session.
- Option to **hide the details** of locked achievements (`???`).

---

## 📸 Screenshots

| Unlock popup | Mod Menu (1/2) |
| :--- | :--- |
| ![Unlock popup](Screenshots/popup.jpg) | ![Mod Menu 1](Screenshots/mod-menu-1.jpg) |
| **Mod Menu (2/2)** | **Achievements Menu** |
| ![Mod Menu 2](Screenshots/mod-menu-2.jpg) | ![Achievements Menu](Screenshots/achievements-menu-1.jpg) |

---

## 📥 Download

Download the latest version from [Releases](https://github.com/gg21kiy/sm64coop-achievements/releases/latest) or via GameBanana.

[![](https://gamebanana.com/mods/embeddables/723530?type=large)](https://gamebanana.com/mods/723530)

[![Download on GameBanana](https://img.shields.io/badge/GameBanana-Download-yellow?style=for-the-badge)](https://gamebanana.com/mods/723530)

---

## 📦 Installation

1. Download the latest `sm64coop-achievements` folder (or `.zip`) from the [Releases](../../releases) page.
2. Put the **folder** (not the zip's parent folder) inside your SM64Coop mods directory:
   - **Windows:** `%appdata%/sm64coopdx/mods/`
   - **Linux / macOS:** `~/.local/share/sm64coopdx/mods/`
   - **Android:** `storage/emulated/com.maniscat2.sm64coopdx/mods/` (depends on your build)
3. Start the game, go to **Mods** and enable **Achievements Mod**.
4. Join or host a game. You will see a message when the mod loads.

> 🖼️ **Icons:** this repository does **not** include the achievement icons. The mod works without them, but you'll need to add your own PNGs to see icons in the popup and the menu.

---

## 🎮 How to use

### Open the achievements menu

| Method | How |
|---|---|
| Chat command | `/achievements` (or `/achievements menu`) |
| Pause menu | Press the configured button while paused (**X** by default, can be **Y**, **L** or disabled) |

Close it with the same command/button.

### Change language

| Method | How |
|---|---|
| Chat command | `/achievements lang <code>` (e.g., `/achievements lang es`, `/achievements lang en`) |
| Mod Menu | Adjust the **Language** slider (1: EN, 2: ES, 3: CA, 4: GL, 5: EU, 6: PT, 7: FR) |

Supported language codes: `en` (English), `es` (Español), `ca` (Català), `gl` (Galego), `eu` (Euskara), `pt` (Português), `fr` (Français).

### Reset your progress

```
/achievements reset
```

Resets the achievements of the **current save file** only.

### Mod Menu settings

| Setting | Description |
|---|---|
| Language (1-7) | Select active language (1: EN, 2: ES, 3: CA, 4: GL, 5: EU, 6: PT, 7: FR) |
| Show notifications | Enable/disable the unlock popup |
| Unlock sound (0-6) | `0` none, `1` coin (default), `2` red coin, `3` 1-UP, `4` star sound, `5` secret, `6` star appears |
| Horizontal pos | `0` left · `1` center · `2` right |
| Vertical pos | `0` top · `1` center · `2` bottom |
| Popup size (%) | From 50% to 200% |
| Duration (seconds) | From 2 to 15 seconds |
| Test popup | Shows a preview popup to check position and size |
| Lock on cheats | Blocks achievements after a cheat is used |
| Pause bind | Button that opens the menu from the pause screen |
| Hide locked details | Shows `???` for locked achievements |

---

## 🏅 Achievements

<details>
<summary><b>⭐ Stars (7)</b></summary>

| Title | Description |
|---|---|
| First Star! | Collect your very first star |
| Power Growing | Collect 8 stars |
| A Quarter Complete | Collect 30 stars |
| One More For Luck | Collect 31 stars |
| Half Century | Collect 50 stars |
| Making Progress | Collect 70 stars |
| Star Collector | Collect all 120 stars |

</details>

<details>
<summary><b>🧢 Caps (3)</b></summary>

| Title | Description |
|---|---|
| Take Flight | Unlock the Wing Cap |
| Solid Power | Unlock the Metal Cap |
| Now You See Me | Unlock the Vanish Cap |

</details>

<details>
<summary><b>🎖️ Ranks (8)</b></summary>

| Title | Description |
|---|---|
| Six-Star Challenge | Collect all 6 main stars in a single course |
| Coin Hoarder | Collect a 100-coin star |
| Coin Master | Collect every coin in a course |
| Basement Explorer | Collect all main stars from the basement courses |
| First Floor Champion | Collect all main stars from the first floor |
| Second Floor Champion | Collect all main stars from the second floor |
| Third Floor Champion | Collect all main stars from the third floor |
| Castle Secrets | Find all of the castle's secret stars |

</details>

<details>
<summary><b>👹 Bosses (11)</b></summary>

| Title | Description |
|---|---|
| Eye To Eye | Defeat Mr. I |
| Bug Squashed | Defeat Wiggler |
| Bombs Away | Defeat King Bob-omb |
| Bully Buster | Defeat the Big Bully in LLL |
| Hands Down | Defeat Eyerok |
| Whomp Down | Defeat King Whomp |
| Ghost Hunter | Defeat every Big Boo in BBH |
| First Encounter | Defeat Bowser in the first battle |
| Back For More | Defeat Bowser in the second battle |
| Final Showdown | Defeat Bowser in the final battle |
| True Completion | Defeat the final Bowser after collecting all 120 stars |

</details>

<details>
<summary><b>💀 Deaths (8)</b></summary>

| Title | Description |
|---|---|
| Watch Your Step | Lose a life by falling |
| Sandy Situation | Lose a life in quicksand |
| Squashed! | Get crushed and lose a life |
| Bowser Wins | Lose a life during a Bowser battle |
| Boss Trouble | Lose a life to a boss |
| Wrong Move | Lose a life to a regular enemy |
| Out Of Breath | Lose a life by drowning |
| Too Hot! | Lose a life from fire or lava |

</details>

<details>
<summary><b>✨ Extras (9)</b></summary>

| Title | Description |
|---|---|
| Slide Expert | Perform 100 slides |
| Jump Machine | Perform 1,000 jumps |
| Chatty Plumber | Talk to NPCs 25 times |
| Race Champion | Win every tracked race |
| Hello, Yoshi! | Talk with Yoshi |
| Free At Last | Release the Chain Chomp |
| Metal-Free Dive | Get the Metal-Head Mario star without using the Metal Cap |
| Caught Cheating | Activate a cheat |
| Roll Credits | Reach the game's ending |

</details>

---

## 🛠️ Achievements API (For Mod Developers)

Are you a mod developer interested in adding your own custom achievements, icons, and unlock conditions to your mod, or creating an `[AM]` achievement addon pack? 

👉 **[Read the full Achievements API Documentation here (API.md)](./API.md)**

---

## 🖼️ Icons

For copyright reasons, **this repository does not ship any icon images**. To get icons in the popup and in the menu:

1. Create (or obtain with permission) your own `.png` images.
2. Name them exactly as listed in [`SM64Coop Achievements Icon Naming Guide`](textures/SM64%20Achievement%20Icon%20Naming%20Guide.txt) (for example `stars_1.png`, `bosses_big_bob.png`, `deaths_falling.png`, `cheater.png`...).
3. Drop them inside the mod's `textures/` folder.

Please **only use images you own or have the right to use**.

> [!WARNING]
> All icons must be 64×64 pixels.

---

## 📁 Project structure

```text
sm64coop-achievements/
├── lang_0_core.lua               # Translation manager and storage handler
├── lang_en.lua                   # English localization (fallback)
├── lang_es.lua                   # Spanish localization
├── lang_ca.lua                   # Catalan localization
├── lang_gl.lua                   # Galician localization
├── lang_eu.lua                   # Basque localization
├── lang_pt.lua                   # Portuguese localization
├── lang_fr.lua                   # French localization
├── main.lua                      # Mod logic, menu and settings
├── in-game language setting.txt  # Documentation guide for language setup
└── textures/
    └── SM64 Achievement Icon Naming Guide.txt # File names expected for the icons
```
---

## 🐛 Known limitations / bug reports

- Progress is stored with `mod_storage`, so it is **local to each player** (not shared in multiplayer).
- Cheat detection depends on the field names used by the *Cheats* mod of SM64Coop.
- Achievements are tracked for the **local player** only.

Found a bug? Open an [issue](../../issues) and include:

- Your SM64Coop version and platform (PC / Android...).
- What you were doing when it happened.
- Any error shown in the game console.

---

## 🤝 Contributing

Pull requests are welcome. If you want to add an achievement, add a new entry to the `LIST` table in `main.lua` and the matching condition in the corresponding `check_*` function or event hook. If you want to add or fix a translation, edit the corresponding `lang_*.lua` file.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE). The license covers **the code only**; Nintendo's and Moon64's assets and trademarks are not included and remain the property of their owners.

---

## 🙏 Credits

- Idea and style inspired by the achievements of **Moon64**.
- Built for **SM64CoopDX**.
- Menu input logic based on the approach used by the **Character Select** mod.
- Made by [gg21kiy](https://github.com/gg21kiy).
