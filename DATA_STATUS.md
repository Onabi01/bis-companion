# État des données (9 novembre 2026)

## Retail Midnight 12.1.5

- `BiSCompanion_Standard.toc` (et le manifeste de repli `BiSCompanion.toc`) cible l'interface `120105`.
- Les 40 spécialisations et leurs 80 entrées d'arbres héroïques disposent d'une liste d'équipement issue des tableaux « Overall Best in Slot » d'Icy Veins. Les identifiants des objets ont été recoupés avec les fiches Wowhead. Une liste de spécialisation est partagée entre ses deux arbres héroïques.
- Les nouvelles listes sont dans `Retail1215*.lua`, sauf les sept spécialisations déjà mises à jour directement dans `BisData.lua` : Dévoreur, les trois Mages et les trois Démonistes.
- Des imports de talents du guide Method 12.1.5 sont chargés lorsqu'un arbre héroïque est explicitement indiqué dans le guide. Une table vide signifie qu'aucun code actuel vérifié n'a été attribué à cet arbre. Les imports ne sont pas testés dans le client.
- L'arbre Annihilator remplace Fel-Scarred pour Vengeance dans la table de Midnight. Les identifiants d'arbres Annihilator et Void-Scarred restent inconnus ; leur sélection automatique peut donc échouer, mais la sélection manuelle reste disponible.
- `python tools/validate_1215.py` contrôle les 33 nouvelles listes modulaires, leurs slots et leurs IDs. `python tools/audit_coverage.py` contrôle les clés de tous les fichiers Lua du manifeste.

Sources : [Icy Veins, exemple de liste](https://www.icy-veins.com/wow/blood-death-knight-pve-tank-gear-best-in-slot), [Method, exemple de talents](https://www.method.gg/guides/vengeance-demon-hunter/talents), [Wowhead](https://www.wowhead.com/).

## Forever 1.60.1

- `BiSCompanion_Forever.toc` cible l'interface `16001` et charge un jeu de données séparé, ainsi que les variantes `compat/forever/Core/` des modules UI et EncounterJournal.
- Les neuf classes et 27 arbres de spécialisation classiques sont sélectionnables manuellement. La classe du personnage est présélectionnée.
- `ForeverBiS60.lua` contient les 27 listes de niveau 60, soit 444 objets. Chaque ID provient du lien de la fiche objet du classement [wow-forever.gg](https://wow-forever.gg/tools/gear/). Les emplacements absents de certains tableaux source restent absents de l'addon ; l'emplacement d'arme à distance est affiché lorsqu'il existe.
- Ces classements sont calculés à partir des poids statistiques du site. Ils ne tiennent pas nécessairement compte des effets d'équipement, des bonus d'ensemble, des résistances ou de la disponibilité réelle des objets. Le site indique que très peu de ses objets ont une source d'obtention connue. Ces listes sont donc des points de départ à revoir en jeu, et non des BiS validés par simulation.
- Les builds de talents préconfigurés Forever ne sont pas renseignés ; un planificateur visuel séparé existe. L'affichage des 14 emplacements de Paladin Rétribution a été testé en jeu sur Forever 1.60.1 le 9 novembre 2026. Les autres spécialisations et les objets dont l'icône reste « ? » ne sont pas encore vérifiés en jeu. Les données Retail ne sont pas chargées par le manifeste Forever.
- `python tools/validate_forever.py` contrôle la présence des 27 listes, l'unicité des emplacements et IDs et les fichiers du manifeste.

Sources : [Warcraft Wiki, format TOC](https://warcraft.wiki.gg/wiki/Toc_file), [classements de niveau 60](https://wow-forever.gg/tools/gear/), [WoW Forever officiel](https://worldofwarcraft.blizzard.com/en-us/forever/).

## Mise à jour

`tools/update_data.py` valide un JSON revu manuellement, même pour une seule entrée d'arbre héroïque. Il affiche le diff par défaut. `--apply` fusionne l'entrée dans `tools/reviewed_data.json`, écrit `RetailReviewedGear.lua` et `RetailReviewedTalents.lua` et les charge après les données intégrées. Le script ne remplace plus les fichiers historiques. L'extraction automatique fiable des guides et des identifiants n'est pas encore implémentée.

## Archive universelle (14 novembre 2026)

- La version commune 2.3.0 est distribuée en **un seul ZIP**. Les manifests `_Standard.toc` et `_Forever.toc` sélectionnent des listes de fichiers distinctes ; un manifeste `.toc` sans suffixe sert de repli Retail.
- Les fichiers `compat/forever/Core/` sont désormais directement référencés dans le manifeste Forever, sans remplacement de fichiers lors du packaging.
- `tools/validate_packages.py` contrôle que les deux manifests sont présents, que les chemins existent et que chaque client charge uniquement son jeu de données.
- La compatibilité est confirmée par des contrôles **statiques**, pas par une exécution en jeu sur les deux clients.
