# État des données (20 novembre 2026)

## Retail Midnight 12.1.5

- `BiSCompanion_Standard.toc` (et le manifeste de repli `BiSCompanion.toc`) cible l'interface `120105`.
- Les 40 spécialisations et leurs 80 entrées d'arbres héroïques disposent d'une liste d'équipement issue des tableaux « Overall Best in Slot » d'Icy Veins. Les identifiants des objets ont été recoupés avec les fiches Wowhead. Une liste de spécialisation est partagée entre ses deux arbres héroïques.
- Les nouvelles listes sont dans `Retail1215*.lua`, sauf les sept spécialisations déjà mises à jour directement dans `BisData.lua` : Dévoreur, les trois Mages et les trois Démonistes.
- Des imports de talents du guide Method 12.1.5 sont chargés lorsqu'un arbre héroïque est explicitement indiqué dans le guide. Une table vide signifie qu'aucun code actuel vérifié n'a été attribué à cet arbre. Les imports ne sont pas testés dans le client.
- L'arbre Annihilator remplace Fel-Scarred pour Vengeance dans la table de Midnight. Les identifiants d'arbres Annihilator et Void-Scarred restent inconnus ; leur sélection automatique peut donc échouer, mais la sélection manuelle reste disponible.
- `python tools/validate_1215.py` contrôle les 33 nouvelles listes modulaires, leurs slots et leurs IDs. `python tools/audit_coverage.py` contrôle les clés de tous les fichiers Lua du manifeste.

Sources : [Icy Veins, exemple de liste](https://www.icy-veins.com/wow/blood-death-knight-pve-tank-gear-best-in-slot), [Method, exemple de talents](https://www.method.gg/guides/vengeance-demon-hunter/talents), [Wowhead](https://www.wowhead.com/).

## Historique Forever 1.60.1 — équipements suspendus en 2.3.1 (14 novembre 2026)

- Le manifeste `BiSCompanion_Forever.toc` cible l'interface `16001` ; il charge désormais `ForeverData.lua` et **ne charge plus** `ForeverBiS60.lua` ni `CommonItems.lua`.
- Les neuf classes et 27 spécialisations classiques restent sélectionnables, avec des listes BiS **intentionnellement vides**.
- Les 444 objets et 27 classements précédents n'étaient pas suffisamment fiables pour Forever. Le fichier `ForeverBiS60.lua` est **conservé comme archive source à auditer**, mais n'est plus inclus dans le ZIP ni exécuté en jeu.
- `CommonItems.lua` étant un catalogue de sets et crafts Retail, il est également exclu du manifeste Forever.
- L'interface Forever masque les contrôles d'édition, le menu des listes et les slots d'équipement, et explique que les BiS sont en préparation. Le planificateur de talents reste accessible.
- **SavedVariables intactes** : les listes personnelles historiques ne sont pas détruites ; leur affichage et leur reconnaissance comme BiS sont temporairement désactivés pour éviter de signaler de mauvais objets.
- `python tools/validate_forever.py` contrôle le mode suspendu, les 27 listes vides et l'accès au planificateur.

## Mise à jour

`tools/update_data.py` valide un JSON revu manuellement, même pour une seule entrée d'arbre héroïque. Il affiche le diff par défaut. `--apply` fusionne l'entrée dans `tools/reviewed_data.json`, écrit `RetailReviewedGear.lua` et `RetailReviewedTalents.lua` et les charge après les données intégrées. Le script ne remplace plus les fichiers historiques. L'extraction automatique fiable des guides et des identifiants n'est pas encore implémentée.

## Archive universelle (14 novembre 2026)

- La version commune 2.5.0 est distribuée en **un seul ZIP**. Les manifests `_Standard.toc` et `_Forever.toc` sélectionnent des listes de fichiers distinctes ; un manifeste `.toc` sans suffixe sert de repli Retail.
- Les fichiers `compat/forever/Core/` sont désormais directement référencés dans le manifeste Forever, sans remplacement de fichiers lors du packaging.
- `tools/validate_packages.py` contrôle que les deux manifests sont présents, que les chemins existent et que chaque client charge uniquement son jeu de données.
- Les changements de la 2.3.1 désactivent uniquement l'édition et les données d'équipement Forever ; l'interface Retail n'est pas modifiée.
- La compatibilité est confirmée par des contrôles **statiques**, pas par une exécution en jeu sur les deux clients.

## Forever : recommandations et planificateur (14 novembre 2026)

- Version 2.4.0 : 45 recommandations Icy Veins (44 builds niveau 60 et un build de progression niveau 30), couvrant 27 spécialisations parmi neuf classes. Les répartitions sont stockées séparément des sauvegardes personnelles et chargées seulement sur Forever.
- Source de correspondance : Zael98/Zbuilds (`Data.lua`, génération 2026-11-14 13:44), contenant des choix de talents et des liens vers les guides Icy Veins ; métadonnées d'arbre de TalentsForever.com (CC BY 4.0). Les guides restent accessibles par leurs URL, sans recopie des articles.
- Prérequis `C_Traits` : rangées débloquées par groupes de 5 points antérieurs dans le même arbre ; `visibleEdges` pour les connexions conditionnelles ; jamais d'achat automatique.
- Les builds sont soumis à validation des rangs, positions, liens et 51 points lors de leur sélection. Une mise à jour du client peut imposer une révision des données. Test en jeu toujours nécessaire.

## Forever : comparaison côte à côte (14 novembre 2026, version 2.4.1)

- Le nouveau module `ForeverComparison.lua` est chargé uniquement par `BiSCompanion_Forever.toc`, après le planificateur.
- Le bouton **Mode comparaison** adapte les tailles et positions des fenêtres `PlayerSpellsFrame.TalentsFrame` (interface de jeu) et `BiSCompanionForeverTalentPlanner` (addon) pour les afficher côte à côte.
- Les échelles et les points d'ancrage d'origine sont conservés uniquement en mémoire pendant le mode et restaurés lorsqu'il se termine, y compris en cas de fermeture des talents ou du planificateur. Pendant le combat, la restauration attend `PLAYER_REGEN_ENABLED`.
- Des tests Lua simulés valident l'ouverture des talents, l'activation, la restauration et les protections en combat. La compatibilité avec le positionnement réel des panneaux Blizzard reste à valider en jeu.

## Forever Pre-Raid BiS (20 novembre 2026, version 2.5.0)

- Réactivation du mode équipement sur Forever (interface `16001`) par `ForeverPreRaidGear.lua`, après la validation des 28 profils et des 470 entrées par emplacement.
- Profil supplémentaire `Druid_FeralTank` et conservation de `Druid_Feral` pour Feral DPS. Les trois arbres de talents classiques restent inchangés.
- Nom **Pre-Raid BiS** uniquement pour le joueur. La provenance externe des classements n'apparaît pas dans le menu du jeu.
- Snapshot d'audit `tools/data/forever_preraid_snapshot.json` issu des pages pré-raid **WoW Forever de wowtbc.gg**, consultées le 20 novembre 2026. Les données sont des faits d'items (noms, emplacements, sources) ; aucun article ni texte explicatif des guides n'est copié.
- IDs recoupés avec le catalogue `Napalmsteak/WoW-Classic-Item-Caches` (`Forever Cache.json` et `Classic Era Cache.json`, commit épinglé `eff4560809de2e852e9164183e3edf5a795edd20`), puis les pages de vrais objets Wowhead Forever pour dix ajouts récents absents de ces snapshots.
- 470 entrées disposant toutes d'un ID numérique non ambigu. 453 icônes de secours issues des caches ; les autres dépendent du cache d'objets du client WoW.
- Le module ne s'active que si les 28 profils sont présents et que chaque ID est valide. L'ancien fichier non vérifié `ForeverBiS60.lua` et le catalogue Retail `CommonItems.lua` restent exclus du TOC et du ZIP.
- Sauvegardes personnelles conservées ; sélection de rôle par personnage stockée dans `BiSCompanionCustomData.foreverGearSpecByCharacter`. Les choix de sets et crafts spécifiques à Retail sont désactivés dans le sélecteur Forever.
- **Limites :** listes pré-raid encore susceptibles d'évoluer avec les nouveaux drops de Forever ; IDs recoupés, mais chargement des 470 objets et fonctionnement des clics dans le client 1.60.1 à vérifier en jeu. Diffuser d'abord comme Beta.

### Découpage en trois lots de données

- Lot 1 : `ForeverPreRaidLot1.lua` (Guerrier, Paladin, Chasseur), 9 profils / 150 équipements.
- Lot 2 : `ForeverPreRaidLot2.lua` (Voleur, Prêtre, Chaman), 9 profils / 152 équipements.
- Lot 3 : `ForeverPreRaidLot3.lua` (Mage, Démoniste, Druide), 10 profils / 168 équipements dont Féral Tank.
- `ForeverPreRaidGear.lua` active les BiS seulement si les trois lots sont présents. Aucun chargement partiel.
- `tools/data/forever_preraid_lot[1-3].json` enregistre les trois découpages pour l'audit.
- Certains IDs sont confirmés par correspondance des noms Classic Era uniquement, faute de données Forever pour ces objets. Leur disponibilité reste à vérifier en jeu.
 
## Forever : variantes d'equipement 2.5.4 (20 novembre 2026)

- Base intacte : 28 profils / 470 selections. Un set Shockadin distinct deja livre (16 selections).
- Cette version ajoute 10 sets de 16 ou 17 objets (164 selections) pour huit specialisations, soit 39 sets disponibles et 650 selections au total. Les memes objets peuvent se repeter entre sets.
- Source de choix d'equipement : https://wowforeverbislist.com/preraid/ (builds actualises le 19 novembre 2026). Noms et IDs recoupes avec les bases d'objets WoW Forever et les trois lots de base.
- Aucun nouveau set n'est ajoute quand seule la repartition de talents change ; les sets integres restent en lecture seule et les sauvegardes personnelles ne sont pas modifiees.
- Holy-Prot Paladin : Songstone of Ironforge (Alliance) et Eye of Orgrimmar (Horde) comme recompenses de quete distinctes.
- Fiabilite BETA : certains butins sont presents via des bases Classic ou n'ont pas encore ete observes dans Forever ; profession requise ou objet non decouvert pour certains choix (notamment Knowledge of the Timbermaw). Disponibilite effective, factions et optimisation a confirmer en jeu.
- L'interface ne possede pas encore de slots munitions / carquois pour les sets Hunter.
- Tests : tools/validate_forever_additional_builds.py (integrite statique) et tools/test_forever_additional_builds.lua (runtime, non-regression, conservation de Shockadin).
