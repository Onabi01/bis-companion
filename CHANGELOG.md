# BiSCompanion - Changelog

## 2.5.2 - Forever Pre-Raid sets par build

- Paladin Retribution : deux sets intégrés dans le même menu d'équipement :
  - **Pre-Raid BiS - Unsealed Wrath** : conserve le set hybride Retribution de 2.5.1.
  - **Pre-Raid BiS - Shockadin** : 16 objets pour le build Holy Shock, avec IDs recoupés sur Wowhead Forever.
- Sets intégrés protégés contre la modification et la suppression. Duplication en liste personnelle possible.
- Le set Shockadin peut être défini comme BiS favori, enregistré dans SavedVariables et pris en compte dans les tooltips.
- Structure extensible à d'autres variantes de builds sans modifier la liste des 28 spécialisations ou les 45 presets talents.
- Module exclusivement Forever ; Retail et les données BiS existantes sont inchangés.
- **Beta** : certains objets Shockadin sont propres à l'Alliance et quelques sources de butin ne sont pas confirmées dans Forever. Variantes Horde et autres spécialisations à auditer.

**Validation :** contrôles automatiques d'intégrité, packaging et syntaxe Lua via GitHub Actions ; test en jeu requis.

## 2.5.1 - Sécurisation des listes personnelles Forever

- Dupliquer une liste d'équipement conserve maintenant toutes les métadonnées des objets (notamment « Relic » et les icônes hors cache).
- Impossible d'écraser silencieusement une liste personnelle existante lors de la création ou de la duplication pour la même spécialisation.
- Les noms réservés « Default » et « Pre-Raid BiS » ne peuvent plus servir à créer une liste personnelle.
- Affichage de l'icône via `GetItemIcon` si les informations complètes de l'objet sont encore en cours de chargement.
- Toujours 28 listes Pre-Raid BiS, 470 équipements et 2 rôles Féral ; aucune modification des objets ou talents Forever et aucune modification fonctionnelle Retail.

**Tests :** Structure de l'archive et données vérifiées ; validation Lua 5.1 et tests automatiques GitHub Actions. Tests dans le client WoW Forever encore nécessaires.

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
