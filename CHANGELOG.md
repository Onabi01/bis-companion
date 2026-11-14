# BiSCompanion - Changelog

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
