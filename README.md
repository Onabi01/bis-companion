# BiSCompanion — WoW Retail & WoW Forever

Addon World of Warcraft proposant des listes d'équipements Best-in-Slot (BiS), des informations dans les infobulles et une interface liée au personnage. Le dépôt contient **deux éditions**, construites à partir des mêmes sources avec les adaptations nécessaires pour chaque client.

| Édition | Interface | Version de l'addon | Talents |
| --- | --- | --- | --- |
| **Retail (Midnight 12.1.5)** | `120105` | `2.2.5` | Builds et codes d'import ; certains restent à confirmer dans le jeu |
| **Forever (1.60.1)** | `16001` | `2.2.6` | Planificateur visuel non intrusif, sans achat automatique de talents |

## Installation

Ne copiez **pas le dépôt brut** dans les deux clients : chaque version doit recevoir son propre paquet, avec un fichier de chargement nommé exactement `BiSCompanion.toc`.

À partir de Python 3 (sans dépendances supplémentaires) :

```bash
python tools/package_addon.py --target retail
python tools/package_addon.py --target forever
# ou : python tools/package_addon.py --target all
```

Les fichiers ZIP installables sont créés dans `dist/`. Choisissez uniquement l'archive correspondant à votre client et extrayez le dossier `BiSCompanion` qu'elle contient dans le répertoire `Interface/AddOns` de ce client (le nom exact de ce répertoire dépend de l'installation).

**Attention :** les deux éditions ne doivent pas être mélangées dans le même dossier d'addon. Pour passer d'une édition à l'autre, remplacez le dossier installé, après avoir sauvegardé vos données de jeu si besoin.

## Organisation

- `BiSCompanion.toc` : manifeste source **Retail** ; définit le chargement des modules Retail.
- `BiSCompanion_Forever.toc` : manifeste source **Forever** ; devient `BiSCompanion.toc` lors du packaging Forever.
- `Core/` : modules partagés (données, interface, personnage, infobulles, Guide de l'aventurier, talents Retail).
- `Retail1215*.lua`, `RetailTalent1215*.lua`, `RetailCommon1215.lua` : données Retail.
- `ForeverMapping.lua`, `ForeverData.lua`, `ForeverBiS60.lua`, `ForeverTalentPlanner.lua` : données et planificateur Forever.
- `compat/forever/Core/` : copies spécifiques Forever de deux modules Core ; le packaging les substitue **uniquement** dans l'archive Forever. Cela conserve exactement les comportements contenus dans les ZIP sources, sans imposer les modifications Retail à Forever.
- `tools/` : validation, couverture, préparation des données et packaging.
- `DATA_STATUS.md` : limites connues et provenance des jeux de données. À lire avant toute publication.

## Contrôles

```bash
python tools/validate_1215.py
python tools/validate_forever.py
python tools/audit_coverage.py
python tools/package_addon.py --target all
python tools/validate_packages.py
```

Ces contrôles vérifient les manifests et la structure des données, **pas** l'exécution de l'addon dans les deux clients. Un test dans Retail et dans Forever reste indispensable avant toute distribution.

## Maintenance

Les versions ont des jeux de données et des interfaces/API différents : ne copiez pas les données d'un client vers l'autre. Modifiez les fichiers partagés avec précaution, puis reconstituez et testez les **deux** ZIP.

L'état des données du 9 novembre 2026 figure dans `DATA_STATUS.md` ; en particulier, les informations BiS ne sont pas toutes validées par simulation ou en jeu.

## Licence

Voir [LICENCE.txt](LICENCE.txt) (GNU GPL v3 ou ultérieure selon la déclaration du projet).
