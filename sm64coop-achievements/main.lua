-- name: Achievements Mod
-- description: Moon64-style achievements for SM64Coop.\nConfigurable from the Mod Menu. Open the achievements menu with /achievements or from the pause menu.\nIncludes AchievementsAPI for custom [AM] mods and Multi-Language support (EN, ES, CA, GL, EU, PT, FR, DE)!

------------------------------------------------------------
-- 0) LOCALIZATION SYSTEM
------------------------------------------------------------
LANG_DATA = LANG_DATA or {}

local LANG_CODES = {
    [1] = "en", -- English
    [2] = "es", -- Spanish (Castellano)
    [3] = "ca", -- Catalan (Catala)
    [4] = "gl", -- Galician (Galego)
    [5] = "eu", -- Basque (Euskara)
    [6] = "pt", -- Portuguese (Portugues)
    [7] = "fr", -- French (Francais)
    [8] = "de", -- German (Deutsch)
}

local LANG_CODE_TO_ID = {}
for idx, code in ipairs(LANG_CODES) do
    LANG_CODE_TO_ID[code] = idx
end

------------------------------------------------------------
-- 1) ACHIEVEMENTS  { id, icon (PNG in /textures or TextureInfo), title, description }
------------------------------------------------------------
local LIST = {
    -- Stars
    { "get1Stars",   "stars_1",   "First Star!",             "Collect your very first star" },
    { "get8Stars",   "stars_8",   "Power Growing",           "Collect 8 stars" },
    { "get30Stars",  "stars_30",  "A Quarter Complete",      "Collect 30 stars" },
    { "get31Stars",  "stars_31",  "One More For Luck",       "Collect 31 stars" },
    { "get50Stars",  "stars_50",  "Half Century",            "Collect 50 stars" },
    { "get70Stars",  "stars_70",  "Making Progress",         "Collect 70 stars" },
    { "get120Stars", "stars_120", "Star Collector",          "Collect all 120 stars" },
    -- Caps
    { "unlockWingCap",   "caps_wing_cap",   "Take Flight",    "Unlock the Wing Cap" },
    { "unlockMetalCap",  "caps_metal_cap",  "Solid Power",    "Unlock the Metal Cap" },
    { "unlockVanishCap", "caps_vanish_cap", "Now You See Me", "Unlock the Vanish Cap" },
    -- Ranks
    { "get6MainStars",    "ranks_f",     "Six-Star Challenge",    "Collect all 6 main stars in a single course" },
    { "get100CoinStar",   "ranks_e",     "Coin Hoarder",          "Collect a 100-coin star" },
    { "getAllCoins",      "ranks_d",     "Coin Master",           "Collect every coin in a course" },
    { "getBasementStars", "ranks_c",     "Basement Explorer",     "Collect all main stars from the basement courses" },
    { "getFloor1Stars",   "ranks_b",     "First Floor Champion",  "Collect all main stars from the first floor" },
    { "getFloor2Stars",   "ranks_a",     "Second Floor Champion", "Collect all main stars from the second floor" },
    { "getFloor3Stars",   "ranks_s",     "Third Floor Champion",  "Collect all main stars from the third floor" },
    { "getCastleStars",   "ranks_splus", "Castle Secrets",        "Find all of the castle's secret stars" },
    -- Bosses
    { "beatMrI",          "bosses_mr_i",       "Eye To Eye",       "Defeat Mr. I" },
    { "beatWiggler",      "bosses_wiggler",    "Bug Squashed",     "Defeat Wiggler" },
    { "beatKingBobOmb",   "bosses_big_bob",    "Bombs Away",       "Defeat King Bob-omb" },
    { "beatBigBullies",   "bosses_big_bully",  "Bully Buster",     "Defeat the Big Bully in LLL" },
    { "beatEyerok",       "bosses_eyerok",     "Hands Down",       "Defeat Eyerok" },
    { "beatKingWhomp",    "bosses_king_whomp", "Whomp Down",       "Defeat King Whomp" },
    { "beatAllBoos",      "bosses_big_boo",    "Ghost Hunter",     "Defeat every Big Boo in BBH" },
    { "beatFirstBowser",  "bowser_1",          "First Encounter",  "Defeat Bowser in the first battle" },
    { "beatSecondBowser", "bowser_2",          "Back For More",    "Defeat Bowser in the second battle" },
    { "beatFinalBowser",  "bowser_3",          "Final Showdown",   "Defeat Bowser in the final battle" },
    { "beatGame120Stars", "bowser_3_with_120_stars", "True Completion", "Defeat the final Bowser after collecting all 120 stars" },
    -- Deaths
    { "deathByFalling",  "deaths_falling",    "Watch Your Step", "Lose a life by falling" },
    { "deathBySand",     "deaths_quicksand",  "Sandy Situation", "Lose a life in quicksand" },
    { "deathByCrushing", "deaths_crushed",    "Squashed!",        "Get crushed and lose a life" },
    { "deathByBowser",   "deaths_bowser",     "Bowser Wins",      "Lose a life during a Bowser battle" },
    { "deathByBoss",     "deaths_boss",       "Boss Trouble",     "Lose a life to a boss" },
    { "deathByEnemy",    "deaths_standard",   "Wrong Move",       "Lose a life to a regular enemy" },
    { "deathByDrowning", "deaths_drowning",   "Out Of Breath",    "Lose a life by drowning" },
    { "deathByFire",     "extras_carpet_burn", "Too Hot!",         "Lose a life from fire or lava" },
    -- Extras
    { "slide100Times",    "extras_carpet_burn", "Slide Expert",    "Perform 100 slides" },
    { "jump1000Times",    "extras_jumper",      "Jump Machine",    "Perform 1,000 jumps" },
    { "talk25Times",      "extras_talker",      "Chatty Plumber",  "Talk to NPCs 25 times" },
    { "beatEveryRace",    "extras_runner",      "Race Champion",   "Win every tracked race" },
    { "talkWithYoshi",    "extras_yoshi",       "Hello, Yoshi!",   "Talk with Yoshi" },
    { "releaseChainChomp", "extras_chain_chomp", "Free At Last",   "Release the Chain Chomp" },
    { "swimmer",          "extras_swimmer",     "Metal-Free Dive", "Get the Metal-Head Mario star without using the Metal Cap" },
    { "cheater",          "cheater",            "Caught Cheating", "Activate a cheat" },
    { "watchEndCredits",  "extras_cake",        "Roll Credits",    "Reach the game's ending" },
}

local ACH = {}
for _, a in ipairs(LIST) do
    ACH[a[1]] = { id = a[1], icon = a[2], title = a[3], desc = a[4] }
end
ACH["__preview"] = { id = "__preview", icon = "stars_1", title = "Achievement preview", desc = "Popup position test" }

-- Helper function to support both string texture names and pre-loaded TextureInfo objects
local function resolve_texture(icon)
    if type(icon) == "userdata" or type(icon) == "table" then
        return icon
    elseif type(icon) == "string" then
        local tex = get_texture_info(icon)
        if tex then return tex end
    end
    return get_texture_info("stars_1")
end

-- Game data -------------------------------------------------
local STAR_GOALS = { 1, 8, 30, 31, 50, 70, 120 }
local BOSS_STARS = {
    { LEVEL_BOB, 1, "beatKingBobOmb" },
    { LEVEL_WF,  1, "beatKingWhomp" },
    { LEVEL_BBH, 1, "beatAllBoos" },
    { LEVEL_BBH, 6, "beatMrI" },
    { LEVEL_LLL, 1, "beatBigBullies" },
    { LEVEL_SSL, 4, "beatEyerok" },
    { LEVEL_THI, 6, "beatWiggler" },
}
local BOSS_BHVS = {
    id_bhvKingBobomb, id_bhvWhompKingBoss, id_bhvBigBully, id_bhvBigBullyWithMinions,
    id_bhvBigChillBully, id_bhvGhostHuntBigBoo, id_bhvBalconyBigBoo, id_bhvMerryGoRoundBigBoo,
    id_bhvMrI, id_bhvMrIParticle, id_bhvWigglerHead, id_bhvEyerokBoss, id_bhvEyerokHand,
}

local function has_bhv(obj, id)
    if obj == nil or id == nil then return false end
    local r = obj_has_behavior_id(obj, id)
    return r == true or (type(r) == "number" and r ~= 0)
end

local function is_boss(obj)
    for _, id in ipairs(BOSS_BHVS) do
        if has_bhv(obj, id) then return true end
    end
    return false
end

local LEVEL_COINS = {
    [LEVEL_BOB] = 146, [LEVEL_WF] = 141, [LEVEL_JRB] = 104, [LEVEL_CCM] = 154,
    [LEVEL_BBH] = 151, [LEVEL_HMC] = 134, [LEVEL_LLL] = 133, [LEVEL_SSL] = 136,
    [LEVEL_DDD] = 106, [LEVEL_SL] = 125, [LEVEL_WDW] = 147, [LEVEL_TTM] = 135,
    [LEVEL_THI] = 182, [LEVEL_TTC] = 128, [LEVEL_RR] = 146,
}
local RACE_STARS = {
    { COURSE_BOB, 2 },
    { COURSE_THI, 3 },
    { COURSE_CCM, 3 },
}
local FLOORS = {
    { id = "getBasementStars", courses = { COURSE_HMC, COURSE_LLL, COURSE_SSL, COURSE_DDD } },
    { id = "getFloor1Stars",   courses = { COURSE_BOB, COURSE_WF, COURSE_JRB, COURSE_CCM, COURSE_BBH } },
    { id = "getFloor2Stars",   courses = { COURSE_SL, COURSE_WDW, COURSE_TTM, COURSE_THI } },
    { id = "getFloor3Stars",   courses = { COURSE_TTC, COURSE_RR } },
}

------------------------------------------------------------
-- 2) SETTINGS
------------------------------------------------------------
local function load_num(k, d)
    local v = tonumber(mod_storage_load(k))
    if v == nil then return d end
    return v
end

local function load_bool(k, d)
    local v = mod_storage_load(k)
    if v == nil then return d end
    return v == "1"
end

local function save_val(k, v)
    if type(v) == "boolean" then v = v and "1" or "0" end
    mod_storage_save(k, tostring(v))
end

local SOUNDS = {
    [1] = SOUND_GENERAL_COIN,
    [2] = SOUND_GENERAL_RED_COIN,
    [3] = SOUND_GENERAL_COLLECT_1UP,
    [4] = SOUND_MENU_STAR_SOUND,
    [5] = SOUND_MENU_COLLECT_SECRET,
    [6] = SOUND_GENERAL_STAR_APPEARS,
}
local SOUND_MAX = 6

local function play_unlock_sound(id)
    local snd = SOUNDS[id]
    if snd then play_sound(snd, gGlobalSoundSource) end
end

local cfg = {
    enabled    = load_bool("cfg_enabled", true),
    sound      = load_num("cfg_sound_id", load_bool("cfg_sound", true) and 1 or 0),
    hide       = load_bool("cfg_hide", false),
    hpos       = load_num("cfg_hpos", 1),
    vpos       = load_num("cfg_vpos", 2),
    scale      = load_num("cfg_scale", 100),
    seconds    = load_num("cfg_seconds", 5),
    block      = load_bool("cfg_block", true),
    pause_bind = load_num("cfg_pause_bind", 1),
    lang       = load_num("cfg_lang", 1),
}

-- Localization helper functions ---------------------------
local function get_current_lang_code()
    return LANG_CODES[cfg.lang] or "en"
end

local function get_ui_text(key)
    local code = get_current_lang_code()
    if LANG_DATA[code] and LANG_DATA[code].ui and LANG_DATA[code].ui[key] then
        return LANG_DATA[code].ui[key]
    end
    if LANG_DATA["en"] and LANG_DATA["en"].ui and LANG_DATA["en"].ui[key] then
        return LANG_DATA["en"].ui[key]
    end
    return key
end

local function get_ach_text(ach)
    if not ach then return "", "" end
    local code = get_current_lang_code()
    -- Check if external API achievement provided custom translations table
    if ach.translations and ach.translations[code] then
        local t = ach.translations[code]
        return t.title or ach.title, t.desc or ach.desc
    end
    -- Check built-in language files
    if LANG_DATA[code] and LANG_DATA[code].achievements and LANG_DATA[code].achievements[ach.id] then
        local t = LANG_DATA[code].achievements[ach.id]
        return t.title or ach.title, t.desc or ach.desc
    end
    -- Fallback to English language file or default achievement strings
    if LANG_DATA["en"] and LANG_DATA["en"].achievements and LANG_DATA["en"].achievements[ach.id] then
        local t = LANG_DATA["en"].achievements[ach.id]
        return t.title or ach.title, t.desc or ach.desc
    end
    return ach.title, ach.desc
end

------------------------------------------------------------
-- 3) ACHIEVEMENT SAVE DATA
------------------------------------------------------------
local cache = {}
local queue = {}
local custom_counters = { "slides", "jumps", "talks" }

local function key(id)
    return "s" .. get_current_save_file_num() .. "_" .. id
end

local function is_unlocked(id)
    local k = key(id)
    if cache[k] == nil then cache[k] = (mod_storage_load(k) == "1") end
    return cache[k]
end

local cheats_used = false
local function blocked(id)
    return cheats_used and cfg.block and id ~= "cheater"
end

local function unlock(id)
    if not ACH[id] or is_unlocked(id) or blocked(id) then return end
    local k = key(id)
    cache[k] = true
    mod_storage_save(k, "1")
    if cfg.enabled then table.insert(queue, id) end
end

local function bump(name, goal, id)
    if blocked(id) then return end
    local k = key("count_" .. name)
    local n = (tonumber(mod_storage_load(k)) or 0) + 1
    mod_storage_save(k, tostring(n))
    if n >= goal then unlock(id) end
end

local function reset_current_save()
    for _, a in ipairs(LIST) do
        local k = key(a[1])
        cache[k] = false
        mod_storage_save(k, "0")
    end
    for _, n in ipairs(custom_counters) do
        mod_storage_save(key("count_" .. n), "0")
    end
end

local function count_unlocked()
    local n = 0
    for _, a in ipairs(LIST) do
        if is_unlocked(a[1]) then n = n + 1 end
    end
    return n
end

------------------------------------------------------------
-- 3.5) PUBLIC API FOR EXTERNAL MODS (_G.AchievementsAPI)
------------------------------------------------------------
_G.AchievementsAPI = {
    VERSION = "1.1.0",
    TRIGGER = {
        CUSTOM      = "custom",      -- Unlocked manually via AchievementsAPI.unlock(id)
        ACTION      = "action",      -- Unlocks when Mario performs an ACT_* (supports goal count)
        LEVEL_ENTER = "level_enter", -- Unlocks when entering a specific LEVEL_*
        STAR_COUNT  = "star_count",  -- Unlocks when reaching X stars
        COIN_COUNT  = "coin_count",  -- Unlocks when reaching X coins in a course
        INTERACT    = "interact",    -- Unlocks when interacting with a specific behavior ID (id_bhv*)
    }
}

local api_triggers = {}

--- Register a new achievement from an external mod
-- @param data table: { id, title, desc, icon, trigger, value, goal, translations }
function _G.AchievementsAPI.register(data)
    if type(data) ~= "table" or not data.id or type(data.id) ~= "string" then
        return false
    end
    if ACH[data.id] then
        return false -- Prevent duplicate IDs
    end

    -- Uses provided icon (TextureInfo or string name), or defaults to the exact achievement ID
    local icon_ref = data.icon or data.id
    local title_str = data.title or "Custom Achievement"
    local desc_str = data.desc or ""

    table.insert(LIST, { data.id, icon_ref, title_str, desc_str })
    ACH[data.id] = {
        id           = data.id,
        icon         = icon_ref,
        title        = title_str,
        desc         = desc_str,
        translations = data.translations -- Optional table: { es = { title = "...", desc = "..." }, ... }
    }

    local trig = data.trigger or _G.AchievementsAPI.TRIGGER.CUSTOM
    local goal = data.goal or 1
    if goal > 1 then
        table.insert(custom_counters, "api_" .. data.id)
    end

    if trig ~= _G.AchievementsAPI.TRIGGER.CUSTOM then
        table.insert(api_triggers, {
            id      = data.id,
            trigger = trig,
            value   = data.value,
            goal    = goal
        })
    end

    return true
end

--- Manually unlock an achievement
function _G.AchievementsAPI.unlock(id)
    unlock(id)
end

--- Add +1 progress to a counter-based achievement
function _G.AchievementsAPI.add_progress(id, goal)
    bump("api_" .. id, goal or 1, id)
end

--- Check if an achievement is already unlocked
function _G.AchievementsAPI.is_unlocked(id)
    return is_unlocked(id)
end

--- Get current active language code ("en", "es", "ca", "gl", "eu", "pt", "fr", "de")
function _G.AchievementsAPI.get_language()
    return get_current_lang_code()
end

------------------------------------------------------------
-- 4) CONDITIONS
------------------------------------------------------------
local prev_action = 0
local tick = 0
local last_boss_hit = -1000

local function check_deaths(m)
    local lvl = gNetworkPlayers[0].currLevelNum
    local f = m.floor
    if f ~= nil and f.type == SURFACE_DEATH_PLANE and m.pos.y < m.floorHeight + 2048 then
        unlock("deathByFalling")
    end
    if m.health >= 0x100 then return end
    local a = m.action
    if lvl == LEVEL_BOWSER_1 or lvl == LEVEL_BOWSER_2 or lvl == LEVEL_BOWSER_3 then
        unlock("deathByBowser")
    elseif tick - last_boss_hit < 90 then
        unlock("deathByBoss")
    elseif a == ACT_QUICKSAND_DEATH then
        unlock("deathBySand")
    elseif a == ACT_DROWNING then
        unlock("deathByDrowning")
    elseif a == ACT_SQUISHED or m.squishTimer > 0 then
        unlock("deathByCrushing")
    elseif a == ACT_BURNING_JUMP or a == ACT_BURNING_FALL or a == ACT_BURNING_GROUND or a == ACT_LAVA_BOOST then
        unlock("deathByFire")
    elseif a == ACT_STANDING_DEATH or a == ACT_DEATH_ON_BACK or a == ACT_DEATH_ON_STOMACH then
        unlock("deathByEnemy")
    end
end

local function check_save_progress(m)
    local file = get_current_save_file_num() - 1
    for course = COURSE_BOB, COURSE_RR do
        local flags = save_file_get_star_flags(file, course - 1)
        if (flags & 0x3F) == 0x3F then unlock("get6MainStars") end
        if (flags & 0x40) ~= 0 then unlock("get100CoinStar") end
    end
    for _, floor in ipairs(FLOORS) do
        local all = true
        for _, course in ipairs(floor.courses) do
            if (save_file_get_star_flags(file, course - 1) & 0x3F) ~= 0x3F then all = false break end
        end
        if all then unlock(floor.id) end
    end
    local all_races = true
    for _, r in ipairs(RACE_STARS) do
        if (save_file_get_star_flags(file, r[1] - 1) & (1 << (r[2] - 1))) == 0 then
            all_races = false
            break
        end
    end
    if all_races then unlock("beatEveryRace") end
    if (save_file_get_star_flags(file, -1) & 0x1F) == 0x1F then unlock("getCastleStars") end
    local flags = save_file_get_flags()
    if (flags & SAVE_FLAG_HAVE_WING_CAP)   ~= 0 then unlock("unlockWingCap") end
    if (flags & SAVE_FLAG_HAVE_METAL_CAP)  ~= 0 then unlock("unlockMetalCap") end
    if (flags & SAVE_FLAG_HAVE_VANISH_CAP) ~= 0 then unlock("unlockVanishCap") end
    for _, n in ipairs(STAR_GOALS) do
        if m.numStars >= n then unlock("get" .. n .. "Stars") end
    end
end

local function check_chain_chomp()
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_BOB then return end
    local o = obj_get_first_with_behavior_id(id_bhvChainChomp)
    if o == nil then return end
    local st = o.oChainChompReleaseStatus
    if st ~= nil and st ~= CHAIN_CHOMP_NOT_RELEASED then unlock("releaseChainChomp") end
end

local CHEAT_CODES = {
    "moonJump", "godMode", "infiniteLives", "superSpeed",
    "responsiveControls", "rapidFire", "bljAnywhere", "alwaysTripleJump",
}
local function check_cheats()
    local t = gPlayerSyncTable[0]
    for _, code in ipairs(CHEAT_CODES) do
        if t[code] == true then
            cheats_used = true
            unlock("cheater")
            return
        end
    end
end

local function check_api_triggers_update(m, action_changed)
    local lvl = gNetworkPlayers[0].currLevelNum
    for _, t in ipairs(api_triggers) do
        if not is_unlocked(t.id) then
            if t.trigger == _G.AchievementsAPI.TRIGGER.ACTION and action_changed then
                if m.action == t.value then
                    if t.goal > 1 then
                        bump("api_" .. t.id, t.goal, t.id)
                    else
                        unlock(t.id)
                    end
                end
            elseif t.trigger == _G.AchievementsAPI.TRIGGER.LEVEL_ENTER then
                if lvl == t.value then unlock(t.id) end
            elseif t.trigger == _G.AchievementsAPI.TRIGGER.STAR_COUNT then
                if m.numStars >= (t.value or 1) then unlock(t.id) end
            elseif t.trigger == _G.AchievementsAPI.TRIGGER.COIN_COUNT then
                if m.numCoins >= (t.value or 1) then unlock(t.id) end
            end
        end
    end
end

local function on_mario_update(m)
    if m.playerIndex ~= 0 then return end
    tick = tick + 1
    check_cheats()
    local action_changed = (m.action ~= prev_action)
    if action_changed then
        local a = m.action
        if a == ACT_BUTT_SLIDE then
            bump("slides", 100, "slide100Times")
        elseif a == ACT_JUMP or a == ACT_DOUBLE_JUMP or a == ACT_TRIPLE_JUMP or a == ACT_LONG_JUMP then
            bump("jumps", 1000, "jump1000Times")
        elseif a == ACT_READING_NPC_DIALOG then
            bump("talks", 25, "talk25Times")
        end
        prev_action = a
    end
    check_api_triggers_update(m, action_changed)
    check_deaths(m)
    local lvl = gNetworkPlayers[0].currLevelNum
    local need = LEVEL_COINS[lvl]
    if need and m.numCoins >= need then unlock("getAllCoins") end
    if lvl == LEVEL_ENDING then unlock("watchEndCredits") end
    if tick % 15 == 0 then
        check_save_progress(m)
        check_chain_chomp()
    end
end

local function on_interact(m, obj, itype)
    if m.playerIndex ~= 0 then return end
    if is_boss(obj) then last_boss_hit = tick end
    if has_bhv(obj, id_bhvYoshi) then unlock("talkWithYoshi") end

    -- Check API interact triggers
    for _, t in ipairs(api_triggers) do
        if not is_unlocked(t.id) and t.trigger == _G.AchievementsAPI.TRIGGER.INTERACT then
            if has_bhv(obj, t.value) then
                if t.goal > 1 then
                    bump("api_" .. t.id, t.goal, t.id)
                else
                    unlock(t.id)
                end
            end
        end
    end

    if (itype & INTERACT_STAR_OR_KEY) == 0 then return end
    local lvl = gNetworkPlayers[0].currLevelNum
    if lvl == LEVEL_BOWSER_1 then
        unlock("beatFirstBowser")
    elseif lvl == LEVEL_BOWSER_2 then
        unlock("beatSecondBowser")
    elseif lvl == LEVEL_BOWSER_3 then
        unlock("beatFinalBowser")
        if m.numStars >= 120 then unlock("beatGame120Stars") end
    else
        local act = ((obj.oBehParams >> 24) & 0xFF) + 1
        if lvl == LEVEL_HMC and act == 3 and (m.flags & MARIO_METAL_CAP) == 0 then
            unlock("swimmer")
        end
        for _, b in ipairs(BOSS_STARS) do
            if b[1] == lvl and b[2] == act then unlock(b[3]) end
        end
    end
end

------------------------------------------------------------
-- 5) ACHIEVEMENTS MENU: state & input
------------------------------------------------------------
local gallery = { open = false, page = 1, pages = 1, only_unlocked = false }
local PAUSE_BINDS = {
    [1] = { mask = X_BUTTON, name = "X" },
    [2] = { mask = Y_BUTTON, name = "Y" },
    [3] = { mask = L_TRIG,   name = "L" },
}

local function menu_is_allowed(m)
    if m == nil then m = gMarioStates[0] end
    if m.action == ACT_FIRST_PERSON or (m.prevAction == ACT_FIRST_PERSON and is_game_paused()) then
        return false
    elseif m.prevAction == ACT_FIRST_PERSON and not is_game_paused() then
        m.prevAction = ACT_WALKING
    end
    if (m.action & ACT_GROUP_CUTSCENE) ~= 0 then return false end
    if m.action == ACT_INTRO_CUTSCENE then return false end
    if m.action == ACT_EXIT_LAND_SAVE_DIALOG then return false end
    if gNetworkPlayers[0].currActNum == 99 then return false end
    if obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then return false end
    return true
end

local function nullify_inputs(m)
    local c = m.controller
    c.buttonDown = 0
    c.buttonPressed = 0
    c.extStickX = 0
    c.extStickY = 0
    c.rawStickX = 0
    c.rawStickY = 0
    c.stickMag = 0
    c.stickX = 0
    c.stickY = 0
end

local input_cooldowns = {}
local FUNC_PAGE, FUNC_FILTER, FUNC_CLOSE = 1, 2, 3

local function run_with_cooldown(idx, condition, func, cooldown)
    if input_cooldowns[idx] == nil then input_cooldowns[idx] = 0 end
    if not condition then return end
    if input_cooldowns[idx] == 0 then
        func()
        input_cooldowns[idx] = cooldown or 4
    end
end

local function open_gallery()
    if gallery.open then return true end
    if not menu_is_allowed() then
        djui_chat_message_create(get_ui_text("menu_unavailable"))
        return false
    end
    gallery.open = true
    gallery.page = 1
    input_cooldowns[FUNC_PAGE] = 10
    input_cooldowns[FUNC_FILTER] = 10
    input_cooldowns[FUNC_CLOSE] = 10
    play_sound(SOUND_MENU_MESSAGE_APPEAR, gGlobalSoundSource)
    return true
end

local function close_gallery()
    if not gallery.open then return end
    gallery.open = false
    play_sound(SOUND_MENU_MESSAGE_DISAPPEAR, gGlobalSoundSource)
end

local function change_page(dir)
    gallery.page = ((gallery.page - 1 + dir) % gallery.pages) + 1
    play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, gGlobalSoundSource)
end

local function toggle_filter()
    gallery.only_unlocked = not gallery.only_unlocked
    gallery.page = 1
    play_sound(SOUND_MENU_CLICK_CHANGE_VIEW, gGlobalSoundSource)
end

local function on_before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    for idx, n in pairs(input_cooldowns) do
        if n > 0 then input_cooldowns[idx] = n - 1 end
    end
    local c = m.controller
    local bind = PAUSE_BINDS[cfg.pause_bind]
    if not gallery.open and bind ~= nil and is_game_paused()
        and m.action ~= ACT_EXIT_LAND_SAVE_DIALOG
        and (c.buttonPressed & bind.mask) ~= 0 then
        open_gallery()
    end
    if not gallery.open then return end
    if not menu_is_allowed(m) then
        gallery.open = false
        return
    end
    run_with_cooldown(FUNC_PAGE,
        (c.buttonPressed & (L_TRIG | L_JPAD)) ~= 0 or c.stickX < -45,
        function() change_page(-1) end, 8)
    run_with_cooldown(FUNC_PAGE,
        (c.buttonPressed & (R_TRIG | R_JPAD)) ~= 0 or c.stickX > 45,
        function() change_page(1) end, 8)
    run_with_cooldown(FUNC_FILTER,
        (c.buttonPressed & A_BUTTON) ~= 0,
        toggle_filter, 6)
    run_with_cooldown(FUNC_CLOSE,
        (c.buttonPressed & (B_BUTTON | START_BUTTON)) ~= 0,
        close_gallery, 6)
    nullify_inputs(m)
    if is_game_paused() then
        game_unpause()
    end
end

------------------------------------------------------------
-- 6) NOTIFICATION (popup)
------------------------------------------------------------
local current = nil

local function on_update()
    if not current and #queue > 0 then
        current = { a = ACH[table.remove(queue, 1)], t = 0 }
        play_unlock_sound(cfg.sound)
    end
    if current then
        current.t = current.t + 1
        if current.t >= cfg.seconds * 30 then current = nil end
    end
end

local function render_popup()
    if not current then return end
    local a, t = current.a, current.t
    local title_str, desc_str = get_ach_text(a)
    local total = cfg.seconds * 30
    local S = cfg.scale / 100
    local h = 32 * S
    local titleScale, descScale = 0.6 * S, 0.45 * S
    local pad = 6 * S
    local textW = math.max(djui_hud_measure_text(title_str) * titleScale,
                           djui_hud_measure_text(desc_str) * descScale)
    local w = h + pad * 2 + textW
    local sw, sh = djui_hud_get_screen_width(), djui_hud_get_screen_height()
    local margin = 8
    local slide = 1
    if t < 10 then slide = t / 10
    elseif t > total - 10 then slide = math.max(0, (total - t) / 10) end
    local x
    if cfg.hpos == 0 then x = margin
    elseif cfg.hpos == 1 then x = (sw - w) / 2
    else x = sw - w - margin end
    local y
    if cfg.vpos == 0 then y = margin - (1 - slide) * (h + margin)
    elseif cfg.vpos == 1 then y = (sh - h) / 2
    else y = sh - h - margin + (1 - slide) * (h + margin) end
    local alpha = math.floor(255 * slide)
    djui_hud_set_color(0, 0, 0, math.floor(170 * slide))
    djui_hud_render_rect(x, y, w, h)
    local tex = resolve_texture(a.icon)
    if tex then
        djui_hud_set_color(255, 255, 255, alpha)
        djui_hud_render_texture(tex, x, y, h / tex.width, h / tex.height)
    end
    djui_hud_set_color(255, 255, 255, alpha)
    djui_hud_print_text(title_str, x + h + pad, y + 3 * S,  titleScale)
    djui_hud_print_text(desc_str,  x + h + pad, y + 17 * S, descScale)
end

local function render_pause_hint()
    local bind = PAUSE_BINDS[cfg.pause_bind]
    if bind == nil or not is_game_paused() or djui_hud_is_pause_menu_created() then return end
    if gMarioStates[0].action == ACT_EXIT_LAND_SAVE_DIALOG then return end
    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(FONT_NORMAL)
    local text = menu_is_allowed() and string.format(get_ui_text("pause_open"), bind.name)
                                    or get_ui_text("pause_unavailable")
    local sw, sh = djui_hud_get_screen_width(), djui_hud_get_screen_height()
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text(text, sw - djui_hud_measure_text(text) - 20, sh - 40, 1)
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)
end

------------------------------------------------------------
-- 7) ACHIEVEMENTS MENU rendering
------------------------------------------------------------
local function fit(text, scale, maxW)
    if djui_hud_measure_text(text) * scale <= maxW then return text end
    while #text > 1 and djui_hud_measure_text(text .. "...") * scale > maxW do
        text = text:sub(1, -2)
    end
    return text .. "..."
end

local function centered(text, scale, y, sw)
    djui_hud_print_text(text, (sw - djui_hud_measure_text(text) * scale) / 2, y, scale)
end

local MOUSE_LEFT = (type(MOUSE_BUTTON_LEFT) == "number") and MOUSE_BUTTON_LEFT or 1

local function gallery_layout(sw, sh)
    local barH, margin = 16, 6
    local barY = sh - barH - margin
    local closeW, closeH = 26, 14
    local prevW, nextW, filterW = 26, 26, 120
    return {
        close  = { x = sw - closeW - margin, y = margin, w = closeW, h = closeH, label = "X" },
        prev   = { x = margin, y = barY, w = prevW, h = barH, label = "<" },
        next   = { x = sw - nextW - margin, y = barY, w = nextW, h = barH, label = ">" },
        filter = { x = (sw - filterW) / 2, y = barY, w = filterW, h = barH, label = nil },
    }
end

local function point_in(b, px, py)
    return px >= b.x and px <= b.x + b.w and py >= b.y and py <= b.y + b.h
end

local function label_in_box(text, scale, b)
    local w = djui_hud_measure_text(text) * scale
    djui_hud_print_text(text, b.x + (b.w - w) / 2, b.y + (b.h - 10 * scale) / 2, scale)
end

local function handle_gallery_mouse()
    local mp = djui_hud_get_mouse_buttons_pressed()
    if mp == nil or (mp & MOUSE_LEFT) == 0 then return end
    local sw, sh = djui_hud_get_screen_width(), djui_hud_get_screen_height()
    local L = gallery_layout(sw, sh)
    local mx, my = djui_hud_get_mouse_x(), djui_hud_get_mouse_y()
    if point_in(L.close, mx, my) then
        close_gallery()
    elseif point_in(L.prev, mx, my) then
        change_page(-1)
    elseif point_in(L.next, mx, my) then
        change_page(1)
    elseif point_in(L.filter, mx, my) then
        toggle_filter()
    end
end

local function render_gallery()
    local sw, sh = djui_hud_get_screen_width(), djui_hud_get_screen_height()
    djui_hud_set_color(0, 0, 0, 220)
    djui_hud_render_rect(0, 0, sw, sh)
    djui_hud_set_color(255, 255, 255, 255)
    centered(string.format(get_ui_text("header"), count_unlocked(), #LIST), 1, 8, sw)
    local items = {}
    for _, a in ipairs(LIST) do
        if not gallery.only_unlocked or is_unlocked(a[1]) then items[#items + 1] = ACH[a[1]] end
    end
    local margin, gap = 14, 8
    local top, bottom = 30, sh - 40
    local cellH = 36
    local cols = (sw >= 400) and 2 or 1
    local rows = math.max(1, math.floor((bottom - top) / cellH))
    local per = cols * rows
    local cellW = (sw - margin * 2 - (cols - 1) * gap) / cols
    gallery.pages = math.max(1, math.ceil(#items / per))
    if gallery.page > gallery.pages then gallery.page = gallery.pages end
    if gallery.page < 1 then gallery.page = 1 end
    for i = 1, per do
        local it = items[(gallery.page - 1) * per + i]
        if not it then break end
        local col = (i - 1) % cols
        local row = math.floor((i - 1) / cols)
        local x = margin + col * (cellW + gap)
        local y = top + row * cellH
        local got = is_unlocked(it.id)
        djui_hud_set_color(255, 255, 255, got and 35 or 12)
        djui_hud_render_rect(x, y, cellW, cellH - 4)
        local tex = resolve_texture(it.icon)
        if tex then
            if got then djui_hud_set_color(255, 255, 255, 255) else djui_hud_set_color(45, 45, 45, 255) end
            djui_hud_render_texture(tex, x + 2, y + 2, 28 / tex.width, 28 / tex.height)
        end
        local title, desc = get_ach_text(it)
        if not got and cfg.hide then
            title = get_ui_text("locked_title")
            desc  = get_ui_text("locked_desc")
        end
        local tx, maxW = x + 34, cellW - 38
        if got then djui_hud_set_color(255, 225, 110, 255) else djui_hud_set_color(140, 140, 140, 255) end
        djui_hud_print_text(fit(title, 0.55, maxW), tx, y + 3, 0.55)
        if got then djui_hud_set_color(235, 235, 235, 255) else djui_hud_set_color(110, 110, 110, 255) end
        djui_hud_print_text(fit(desc, 0.4, maxW), tx, y + 16, 0.4)
    end
    djui_hud_set_color(200, 200, 200, 255)
    centered(string.format(get_ui_text("page"), gallery.page, gallery.pages), 0.5, sh - 54, sw)
    centered(get_ui_text("controls"), 0.4, sh - 44, sw)
    local L = gallery_layout(sw, sh)
    L.filter.label = gallery.only_unlocked and get_ui_text("show_all") or get_ui_text("unlocked_only")
    local mx, my = djui_hud_get_mouse_x(), djui_hud_get_mouse_y()
    for _, b in pairs(L) do
        local hover = mx ~= nil and point_in(b, mx, my)
        djui_hud_set_color(255, 255, 255, hover and 70 or 35)
        djui_hud_render_rect(b.x, b.y, b.w, b.h)
        djui_hud_set_color(255, 255, 255, 255)
        label_in_box(b.label, 0.5, b)
    end
end

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)
    if gallery.open and not menu_is_allowed() then gallery.open = false end
    if gallery.open then
        handle_gallery_mouse()
        if gallery.open then render_gallery() end
    else
        render_popup()
        render_pause_hint()
    end
end

------------------------------------------------------------
-- 8) MOD MENU and commands
------------------------------------------------------------
hook_mod_menu_slider("Language (1:EN 2:ES 3:CA 4:GL 5:EU 6:PT 7:FR 8:DE)", cfg.lang, 1, #LANG_CODES, function(_, v)
    cfg.lang = v
    save_val("cfg_lang", v)
end)
hook_mod_menu_checkbox("Show notifications", cfg.enabled, function(_, v) cfg.enabled = v save_val("cfg_enabled", v) end)
hook_mod_menu_slider("Unlock sound (0-6)", cfg.sound, 0, SOUND_MAX, function(_, v)
    cfg.sound = v
    save_val("cfg_sound_id", v)
end)
hook_mod_menu_slider("Horizontal pos (0:L 1:C 2:R)", cfg.hpos, 0, 2, function(_, v) cfg.hpos = v save_val("cfg_hpos", v) end)
hook_mod_menu_slider("Vertical pos (0:T 1:C 2:B)", cfg.vpos, 0, 2, function(_, v) cfg.vpos = v save_val("cfg_vpos", v) end)
hook_mod_menu_slider("Popup size (%)", cfg.scale, 50, 200, function(_, v) cfg.scale = v save_val("cfg_scale", v) end)
hook_mod_menu_slider("Duration (seconds)", cfg.seconds, 2, 15, function(_, v) cfg.seconds = v save_val("cfg_seconds", v) end)
hook_mod_menu_button("Test popup", function()
    table.insert(queue, "__preview")
end)
hook_mod_menu_checkbox("Lock on cheats", cfg.block, function(_, v) cfg.block = v save_val("cfg_block", v) end)
hook_mod_menu_slider("Pause bind (0:Off 1:X 2:Y 3:L)", cfg.pause_bind, 0, #PAUSE_BINDS, function(_, v) cfg.pause_bind = v save_val("cfg_pause_bind", v) end)
hook_mod_menu_checkbox("Hide locked details", cfg.hide, function(_, v) cfg.hide = v save_val("cfg_hide", v) end)

local function on_command(msg)
    msg = string.lower(msg or "")
    if msg == "reset" then
        reset_current_save()
        djui_chat_message_create(get_ui_text("reset_msg"))
        return true
    end
    if msg == "" or msg == "menu" then
        if gallery.open then
            close_gallery()
        else
            open_gallery()
        end
        return true
    end
    local sub, arg = msg:match("^(%S+)%s*(%S*)$")
    if sub == "lang" and arg and LANG_CODE_TO_ID[arg] then
        cfg.lang = LANG_CODE_TO_ID[arg]
        save_val("cfg_lang", cfg.lang)
        djui_chat_message_create(get_ui_text("lang_changed"))
        return true
    elseif LANG_CODE_TO_ID[msg] then
        cfg.lang = LANG_CODE_TO_ID[msg]
        save_val("cfg_lang", cfg.lang)
        djui_chat_message_create(get_ui_text("lang_changed"))
        return true
    end
    djui_chat_message_create(get_ui_text("cmd_help"))
    return true
end

hook_chat_command("achievements", "[menu|reset|lang] opens the achievements menu", on_command)

local has_notified = false
local function on_level_init()
    if not has_notified then
        djui_chat_message_create(get_ui_text("chat_notify"))
        has_notified = true
    end
end

hook_event(HOOK_MARIO_UPDATE, on_mario_update)
hook_event(HOOK_BEFORE_MARIO_UPDATE, on_before_mario_update)
hook_event(HOOK_ON_INTERACT, on_interact)
hook_event(HOOK_UPDATE, on_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_event(HOOK_ON_LEVEL_INIT, on_level_init)
