# BiSCompanion — un addon pour WoW Retail et WoW Forever

Addon World of Warcraft : équipement Best-in-Slot (BiS), listes personnalisées, infobulles et talents. **Un seul ZIP installable fonctionne sur les deux éditions** grâce aux manifests spécifiques à chaque client. Il n'est pas nécessaire de sélectionner un mode dans les options : le jeu charge lui-même le bon fichier `.toc`.

| Client | Version du jeu testée dans les données | Interface | Fonctionnalités |
| --- | --- | --- | --- |
| **Retail / Midnight** | 12.1.5 | `120105` | Listes BiS, builds et codes d'import de talents |
| **WoW Forever** | 1.60.1 | `16001` | **BiS en préparation** ; planificateur de talents avec liens/prérequis, 51 points, 45 builds Icy Veins et sauvegardes personnelles |

Version commune de l'addon : **2.4.1** (mode comparaison côte à côte pour les talents Forever ; Retail inchangé hors numéro de version).

## Installation — le même ZIP dans les deux clients

1. Téléchargez [BiSCompanion-Universal-2.4.1.zip](releases/BiSCompanion-Universal-2.4.1.zip) (ou construisez-le à partir des sources avec la commande ci-dessous).
2. Extrayez **le dossier `BiSCompanion`** à la racine de `Interface/AddOns` de **Retail** ou de **Forever**. Si les deux jeux sont installés, utilisez exactement la **même archive** dans chacun des deux répertoires.
3. Redémarrez le client et activez BiSCompanion dans le menu « AddOns ».

**Attention :** installez le *dossier* `BiSCompanion`, pas directement les fichiers Lua dans `AddOns`, et ne placez pas le ZIP non extrait dans `AddOns`. En cas de mise à jour depuis une ancienne édition, supprimez d'abord l'ancien dossier de l'addon (sans toucher à `WTF` / `SavedVariables`), puis extrayez le nouveau.

### Pourquoi un seul ZIP fonctionne

WoW choisit automatiquement le fichier `.toc` adapté :

- `BiSCompanion_Standard.toc` : Retail / Midnight, interface `120105`, utilise uniquement les modules et données Retail.
- `BiSCompanion_Forever.toc` : Forever, interface `16001`, utilise uniquement les modules et données Forever, et les deux variantes de modules dans `compat/forever/Core/`.
- `BiSCompanion.toc` : manifeste Retail de repli pour les systèmes qui ne reconnaissent pas le suffixe `_Standard`.

Le ZIP contient les fichiers Lua des deux éditions, mais **seuls les fichiers énumérés par le manifeste sélectionné sont exécutés**. La présence du code d'une autre édition dans le dossier n'entraîne pas son chargement. Les SavedVariables gardent les mêmes noms pour conserver les préférences existantes, chaque client ayant son propre dossier `WTF`.

Documentation du format et de la sélection automatique des TOC : [Warcraft Wiki](https://warcraft.wiki.gg/wiki/.toc).

## Construction de l'archive unique

Python 3.9+ (bibliothèque standard uniquement) :

```bash
python tools/validate_1215.py
python tools/validate_forever.py
python tools/validate_forever_talents.py
python tools/validate_forever_comparison.py
python tools/audit_coverage.py
python tools/package_addon.py
python tools/validate_packages.py
```

Le résultat est `dist/BiSCompanion-Universal-2.4.1.zip`. Le script ne produit **qu'une seule archive** contenant le dossier installable. Il refuse de créer un ZIP incomplet ou de mélanger les modules d'exécution Retail et Forever.

## Organisation des sources

- `BiSCompanion.lua`, `Core/Data.lua`, `Core/Character.lua`, `Core/Tooltip.lua` : logique commune aux deux éditions.
- `Core/UI.lua`, `Core/EncounterJournal.lua`, `Core/Talents.lua` : modules Retail.
- `compat/forever/Core/UI.lua`, `compat/forever/Core/EncounterJournal.lua`, `ForeverTalentPlanner.lua`, `ForeverIcyVeinsBuilds.lua`, `ForeverComparison.lua` : adaptations, planification, recommandations et comparaison des talents Forever ; les deux premiers sont **référencés directement par le TOC Forever**.
- `BisData.lua`, `ClassSpecMapping.lua`, `TalentData.lua`, `Retail1215*.lua`, `RetailTalent1215*.lua`, `RetailCommon1215.lua` : données Retail.
- `ForeverMapping.lua`, `ForeverData.lua` : correspondances de classe et 27 listes vides Forever. `ForeverBiS60.lua` (ancien classement non validé) et `CommonItems.lua` (catalogue Retail) **ne sont pas chargés ni inclus dans le ZIP**.
- `tools/` : validations et générateur du ZIP unique.
- `DATA_STATUS.md` : provenance et limites connues des données. À consulter avant distribution.

## Équipement sur Forever : fonctionnalité suspendue

Les anciens classements Forever contenaient des objets incorrects pour ce client. Tant que les équipements, les sets et leurs sources ne sont pas vérifiés, **aucune liste BiS par défaut n'est chargée et l'édition d'équipement est désactivée**. Un message explicatif apparaît à la place des icônes BiS, du sélecteur d'objets et des boutons Créer/Dupliquer/Supprimer. Les classes et spécialisations restent reconnues et **le planificateur de talents fonctionne toujours**.

Les listes personnalisées enregistrées dans `WTF/SavedVariables` **ne sont ni supprimées ni écrasées**. Elles sont simplement masquées et ignorées pour la détection BiS/les infobulles pendant cette suspension. Les anciennes données Forever restent dans les sources GitHub, hors du ZIP.

## Tests et limites

Les vérifications ci-dessus valident la présence des fichiers, les interfaces, la sélection logique des modules et le format des données ; **elles ne remplacent pas des tests dans les clients WoW**. Il reste à vérifier en jeu le chargement automatique, l'interface, la détection BiS et le planificateur Forever. Les données BiS ne sont pas toutes validées par simulation ou tests en jeu (voir `DATA_STATUS.md`).

## Licence

Voir [LICENCE.txt](LICENCE.txt) (GNU GPL v3 ou version ultérieure, selon la déclaration du projet).

## Talents sur Forever (2.4.0)

- Les recommandations **Icy Veins** sont proposées dans le menu du planificateur, par spécialisation. Elles contiennent les répartitions de points des 45 modèles répertoriés (dont un modèle de progression niveau 30). Une recommandation n'est pas un personnage pré-équipé : ce sont des **points projetés**, jamais achetés dans le jeu.
- Le planificateur utilise le dessin des trois arbres et les connexions renvoyées par **C_Traits** : prérequis des flèches, limite de **51 points** et cinq points requis par palier dans le même arbre. Il refuse les builds dont les positions/rangs ne correspondent plus aux données du client.
- Le bouton **Enregistrer / Save** copie le plan sous un nom dans `BiSCompanionCustomData.foreverNamedTalentBuilds`. **Nouveau / New** repart de zéro. La sélection d'un modèle ne modifie jamais le modèle Icy Veins. Les anciens brouillons `foreverTalentPlans` restent stockés.
- Les modèles proviennent de [guides Icy Veins WoW Forever](https://www.icy-veins.com/wow-forever/). Les correspondances de talents et les codes ont été recoupés avec les données de [Zbuilds (Zael98)](https://github.com/Zael98/Zbuilds) générées le 14 novembre 2026. Les noms et positions proviennent de données WoW Forever et de [Talents Forever](https://talentsforever.com/) (CC BY 4.0). Aucun texte de guide n'est recopié ; les liens des guides sont conservés.
- **À tester en jeu :** la disposition du talent tree, le chargement des recommandations et les flèches. Une différence de version de Forever peut rendre un build incompatible ; dans ce cas, le programme ne le charge pas plutôt que de placer de mauvais points.

## Mode comparaison des talents sur Forever (2.4.1)

Dans le planificateur Forever, clique sur **Mode comparaison**. Le module ouvre la fenêtre **Talents** du jeu si possible, puis positionne **les talents officiels à gauche** et **BiSCompanion à droite**. Il adapte les échelles à l'espace disponible sans modifier l'échelle générale de l'interface.

- Le bouton devient **Quitter comparaison**. Un second clic restaure l'échelle et les points d'ancrage d'origine des **deux** fenêtres.
- Fermer l'une des fenêtres ou quitter l'onglet Talents du jeu restaure aussi la disposition initiale.
- Les fenêtres ne sont pas déplacées en combat. Si le mode est quitté pendant un combat, la restauration attend la fin du combat.
- Sur les petits écrans, le mode refuse une disposition qui rendrait les fenêtres illisibles et affiche une explication dans le chat.
- Si la fenêtre du jeu n'a pas pu être ouverte automatiquement, ouvre les Talents avec **N**, puis clique de nouveau sur le bouton.

Cette fonction ne change aucun talent en jeu, ne modifie pas les builds sauvegardés et n'est pas chargée sur Retail. **À vérifier dans le client Forever 1.60.1**, notamment avec des addons modifiant la fenêtre de talents.

Les détails par version sont dans [CHANGELOG.md](CHANGELOG.md).
