"""Build separate installable packages for WoW Retail and WoW Forever.

Both packages contain a BiSCompanion/ folder and one active BiSCompanion.toc.
The Forever-specific Core implementations are used only in the Forever ZIP.
"""
import argparse
import re
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile

ROOT = Path(__file__).resolve().parents[1]
MANIFESTS = {
    "retail": ROOT / "BiSCompanion.toc",
    "forever": ROOT / "BiSCompanion_Forever.toc",
}


def get_files(target):
    manifest = MANIFESTS[target]
    text = manifest.read_text(encoding="utf-8")
    version = re.search(r"(?m)^## Version:\s*([^\s]+)", text)
    if not version:
        raise ValueError(f"Version missing from {manifest}")
    files = {}
    for line in text.splitlines():
        ref = line.strip()
        if not ref or ref.startswith("#"):
            continue
        relative = Path(ref.replace("\\", "/"))
        if relative.is_absolute() or ".." in relative.parts:
            raise ValueError(f"Unsafe manifest entry: {ref}")
        if relative.suffix.lower() != ".lua":
            raise ValueError(f"Unexpected manifest entry: {ref}")
        source = ROOT / relative
        if target == "forever":
            override = ROOT / "compat" / "forever" / relative
            if override.is_file():
                source = override
        if not source.is_file():
            raise FileNotFoundError(f"Missing {relative} for {target} ({source})")
        files[relative.as_posix()] = source
    return version.group(1), manifest, files


def package(target, out_dir):
    version, manifest, files = get_files(target)
    out_dir.mkdir(parents=True, exist_ok=True)
    output = out_dir / f"BiSCompanion-{target.capitalize()}-{version}.zip"
    with ZipFile(output, "w", ZIP_DEFLATED) as archive:
        archive.write(manifest, "BiSCompanion/BiSCompanion.toc")
        for relative, source in sorted(files.items()):
            archive.write(source, f"BiSCompanion/{relative}")
    print(f"Created {output}: {len(files)} Lua files + 1 manifest")
    return output


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--target", choices=("retail", "forever", "all"), default="all")
    parser.add_argument("--out-dir", type=Path, default=ROOT / "dist")
    args = parser.parse_args()
    targets = MANIFESTS if args.target == "all" else [args.target]
    for target in targets:
        package(target, args.out_dir)


if __name__ == "__main__":
    main()
