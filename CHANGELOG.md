# BiSCompanion - Changelog

## 2.5.0 - WoW Forever Pre-Raid BiS gear

- Enabled **Pre-Raid BiS** gear recommendations for WoW Forever 1.60.1.
- Added **28 equipment profiles** across 9 classes with **470 cross-referenced item IDs**.
- Added separate **Feral DPS** and **Feral Tank** equipment profiles for Druids, without changing the three classic talent trees.
- Shows item icons and acquisition information (quest, dungeon, boss, crafting, reputation) in the gear interface.
- Re-enabled custom gear lists and their selection on Forever; previously saved lists remain preserved.
- Remembers the selected Forever equipment role per character.
- Added three separately audited gear-data modules (9 + 9 + 10 profiles), with an all-or-nothing activation check.
- Added offline integrity checks and kept unverified historical rankings excluded from the installed addon.
- Retail gear and talent features remain unchanged; one universal ZIP still supports both game clients.

**Testing:** All 28 lists and 470 item IDs checked statically against a dated offline snapshot; some IDs are cross-referenced from Classic and still need in-game confirmation. WoW Forever client testing is still required, particularly for icon loading and equipment UI. **Beta recommended.**

## 2.4.1 - Forever side-by-side talent comparison

- Added a **Compare side by side** / **Mode comparaison** button to the WoW Forever talent planner.
- Scales and places the game's Talents window on the left and BiSCompanion's planner on the right, fitting both to the available screen space.
- Opens the game's Talents window when possible; otherwise shows a clear instruction to open it manually.
- Restores **both windows' original scales and anchor positions** when exiting comparison, closing either window, or switching away from the game's Talents tab.
- Does not rearrange protected windows in combat. If comparison must end during combat, restoration is deferred until combat ends.
- Restricts the feature to **WoW Forever**. Retail talents, equipment and existing addon behavior are unchanged.

**Testing:** Lua syntax and mock-frame interaction tests passed. In-game UI placement remains to be tested on WoW Forever 1.60.1, including different resolutions and third-party UI addons.

## 2.4.0 - Forever talent planner

- 45 sourced Icy Veins talent-build templates across 27 Forever specializations.
- Editable talent planner with prerequisites, 51-point maximum, and named personal builds.
- Single universal ZIP for Retail and Forever, with Forever equipment BiS still paused while data is reviewed.
