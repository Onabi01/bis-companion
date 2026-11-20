"""Build one installable BiSCompanion ZIP for Retail and WoW Forever.

The client selects BiSCompanion_Standard.toc or BiSCompanion_Forever.toc.
The unsuffixed BiSCompanion.toc is a Retail fallback for older loaders.
Only files named by the chosen TOC are executed, even though the archive
contains both editions' Lua code.
"""

import argparse
import re
from pathlib import Path, PurePosixPath
from zipfile import ZIP_DEFLATED, ZipFile

ROOT = Path(__file__).resolve().parents[1]
MANIFESTS = {
    "default": "BiSCompanion.toc",
    "retail": "BiSCompanion_Standard.toc",
    "forever": "BiSCompanion_Forever.toc",
}
EXPECTED_INTERFACES = {"retail": "120105", "forever": "16001"}


def read_manifest(client):
    """Return (version, interface, listed Lua paths) for a manifest."""
    manifest = ROOT / MANIFESTS[client]
    content = manifest.read_text(encoding="utf-8-sig")
    version = re.search(r"(?m)^## Version:\s*([^\s]+)", content)
    interface = re.search(r"(?m)^## Interface:\s*([^\s]+)", content)
    if version is None or interface is None:
        raise ValueError(f"Manifest missing Version or Interface: {manifest.name}")

    paths = []
    seen = set()
    for raw in content.splitlines():
        reference = raw.strip()
        if not reference or reference.startswith("#"):
            continue
        name = reference.replace("\\", "/")
        rel = PurePosixPath(name)
        if rel.is_absolute() or ".." in rel.parts or rel.suffix.lower() != ".lua":
            raise ValueError(f"Unsafe or unsupported path in {manifest.name}: {reference}")
        if name.casefold() in seen:
            raise ValueError(f"Duplicate file in {manifest.name}: {name}")
        seen.add(name.casefold())
        source = ROOT.joinpath(*rel.parts)
        if not source.is_file() or not source.resolve().is_relative_to(ROOT.resolve()):
            raise FileNotFoundError(f"Missing or invalid file in {manifest.name}: {name}")
        paths.append(name)
    return version.group(1), interface.group(1), paths


def get_package_files():
    """Validate manifests and return version + all files in the universal ZIP."""
    specs = {client: read_manifest(client) for client in MANIFESTS}
    if specs["default"] != specs["retail"]:
        raise ValueError("Default manifest must be identical to Retail's manifest")
    versions = {info[0] for info in specs.values()}
    if len(versions) != 1:
        raise ValueError(f"All manifests must advertise one addon version: {versions}")
    for client, interface in EXPECTED_INTERFACES.items():
        if specs[client][1] != interface:
            raise ValueError(f"Unexpected {client} interface: {specs[client][1]}")

    retail_files = set(specs["retail"][2])
    forever_files = set(specs["forever"][2])
    if "Core/UI.lua" not in retail_files or "Core/EncounterJournal.lua" not in retail_files:
        raise ValueError("Missing Retail core modules")
    if not {"compat/forever/Core/UI.lua", "compat/forever/Core/EncounterJournal.lua"} <= forever_files:
        raise ValueError("Missing Forever-specific core modules")
    if {"Core/UI.lua", "Core/EncounterJournal.lua"} & forever_files:
        raise ValueError("Forever would load the Retail-specific UI modules")
    if {"compat/forever/Core/UI.lua", "compat/forever/Core/EncounterJournal.lua"} & retail_files:
        raise ValueError("Retail would load the Forever-specific UI modules")
    if {"ForeverData.lua", "ForeverBiS60.lua", "ForeverTalentPlanner.lua", "ForeverPreRaidGear.lua"} & retail_files:
        raise ValueError("Retail would load Forever data")
    if "ForeverPreRaidGear.lua" not in forever_files or "ForeverData.lua" not in forever_files:\n        raise ValueError("Forever must ship validated pre-raid gear and its safety gate")\n    if {"ForeverBiS60.lua", "CommonItems.lua"} & forever_files:
        raise ValueError("Forever must not load unverified BiS or Retail item catalogs")
    if {"BisData.lua", "Retail1215.lua", "TalentData.lua", "Core/Talents.lua"} & forever_files:
        raise ValueError("Forever would load Retail data")

    files = set(MANIFESTS.values()) | retail_files | forever_files
    # Ship a copy of the GPL notice along with the bundled Lua files.
    files.add("LICENCE.txt")
    return versions.pop(), sorted(files)


def package(out_dir):
    version, files = get_package_files()
    out_dir.mkdir(parents=True, exist_ok=True)
    output = out_dir / f"BiSCompanion-Universal-{version}.zip"
    with ZipFile(output, "w", compression=ZIP_DEFLATED, compresslevel=9) as archive:
        for relative in files:
            archive.write(ROOT / relative, "BiSCompanion/" + relative)
    print(f"Created {output}: {len(files)} files (one package for Retail and Forever)")
    return output


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out-dir", type=Path, default=ROOT / "dist")
    args = parser.parse_args()
    package(args.out_dir)


if __name__ == "__main__":
    main()
