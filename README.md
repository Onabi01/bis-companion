# BiSCompanion — un addon pour WoW Retail et WoW Forever

Addon World of Warcraft : équipement Best-in-Slot (BiS), listes personnalisées, infobulles et talents. **Un seul ZIP installable fonctionne sur les deux éditions** grâce aux manifests spécifiques à chaque client. Il n'est pas nécessaire de sélectionner un mode dans les options : le jeu charge lui-même le bon fichier `.toc`.

| Client | Version du jeu testée dans les données | Interface | Fonctionnalités |
| --- | --- | --- | --- |
| **Retail / Midnight** | 12.1.5 | `120105` | Listes BiS, builds et codes d'import de talents |
| **WoW Forever** | 1.60.1 | `16001` | **BiS en préparation : équipement et édition désactivés temporairement** ; planificateur de talents disponible |

Version commune de l'addon : **2.3.1** (base 2.3.0, correction Forever sans modification de l'affichage Retail).

## Installation — le même ZIP dans les deux clients

1. Téléchargez [BiSCompanion-Universal-2.3.1.zip](releases/BiSCompanion-Universal-2.3.1.zip) (ou construisez-le à partir des sources avec la commande ci-dessous).
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
python tools/audit_coverage.py
python tools/package_addon.py
python tools/validate_packages.py
```

Le résultat est `dist/BiSCompanion-Universal-2.3.1.zip`. Le script ne produit **qu'une seule archive** contenant le dossier installable. Il refuse de créer un ZIP incomplet ou de mélanger les modules d'exécution Retail et Forever.

## Organisation des sources

- `BiSCompanion.lua`, `Core/Data.lua`, `Core/Character.lua`, `Core/Tooltip.lua` : logique commune aux deux éditions.
- `Core/UI.lua`, `Core/EncounterJournal.lua`, `Core/Talents.lua` : modules Retail.
- `compat/forever/Core/UI.lua`, `compat/forever/Core/EncounterJournal.lua`, `ForeverTalentPlanner.lua` : adaptations et talents Forever ; les deux premiers sont **référencés directement par le TOC Forever**.
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
