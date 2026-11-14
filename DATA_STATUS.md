# État des données (9 novembre 2026)

## Retail Midnight 12.1.5

- `BiSCompanion_Standard.toc` (et le manifeste de repli `BiSCompanion.toc`) cible l'interface `120105`.
- Les 40 spécialisations et leurs 80 entrées d'arbres héroïques disposent d'une liste d'équipement issue des tableaux « Overall Best in Slot » d'Icy Veins. Les identifiants des objets ont été recoupés avec les fiches Wowhead. Une liste de spécialisation est partagée entre ses deux arbres héroïques.
- Les nouvelles listes sont dans `Retail1215*.lua`, sauf les sept spécialisations déjà mises à jour directement dans `BisData.lua` : Dévoreur, les trois Mages et les trois Démonistes.
- Des imports de talents du guide Method 12.1.5 sont chargés lorsqu'un arbre héroïque est explicitement indiqué dans le guide. Une table vide signifie qu'aucun code actuel vérifié n'a été attribué à cet arbre. Les imports ne sont pas testés dans le client.
- L'arbre Annihilator remplace Fel-Scarred pour Vengeance dans la table de Midnight. Les identifiants d'arbres Annihilator et Void-Scarred restent inconnus ; leur sélection automatique peut donc échouer, mais la sélection manuelle reste disponible.
- `python tools/validate_1215.py` contrôle les 33 nouvelles listes modulaires, leurs slots et leurs IDs. `python tools/audit_coverage.py` contrôle les clés de tous les fichiers Lua du manifeste.

Sources : [Icy Veins, exemple de liste](https://www.icy-veins.com/wow/blood-death-knight-pve-tank-gear-best-in-slot), [Method, exemple de talents](https://www.method.gg/guides/vengeance-demon-hunter/talents), [Wowhead](https://www.wowhead.com/).

## Forever 1.60.1 — équipements suspendus (14 novembre 2026)

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

- La version commune 2.3.1 est distribuée en **un seul ZIP**. Les manifests `_Standard.toc` et `_Forever.toc` sélectionnent des listes de fichiers distinctes ; un manifeste `.toc` sans suffixe sert de repli Retail.
- Les fichiers `compat/forever/Core/` sont désormais directement référencés dans le manifeste Forever, sans remplacement de fichiers lors du packaging.
- `tools/validate_packages.py` contrôle que les deux manifests sont présents, que les chemins existent et que chaque client charge uniquement son jeu de données.
- Les changements de la 2.3.1 désactivent uniquement l'édition et les données d'équipement Forever ; l'interface Retail n'est pas modifiée.
- La compatibilité est confirmée par des contrôles **statiques**, pas par une exécution en jeu sur les deux clients.
