"""Check the two package manifests and every file in each installable archive."""
import re
from pathlib import Path
from zipfile import ZipFile

from package_addon import ROOT, get_files


def verify(target):
    version, manifest, files = get_files(target)
    path = ROOT / "dist" / f"BiSCompanion-{target.capitalize()}-{version}.zip"
    if not path.is_file():
        raise FileNotFoundError(f"Build the packages first: {path}")
    with ZipFile(path) as archive:
        names = set(archive.namelist())
        expected = {"BiSCompanion/BiSCompanion.toc"} | {
            f"BiSCompanion/{rel}" for rel in files
        }
        assert names == expected, (target, sorted(names - expected), sorted(expected - names))
        active_toc = archive.read("BiSCompanion/BiSCompanion.toc")
        assert active_toc == manifest.read_bytes(), f"{target}: incorrect active toc"
        for rel, source in files.items():
            assert archive.read(f"BiSCompanion/{rel}") == source.read_bytes(), (target, rel)
        other = "ForeverTalentPlanner.lua" if target == "retail" else "Retail1215.lua"
        assert f"BiSCompanion/{other}" not in names, f"{target}: cross-client file leaked"
    print(f"{target}: OK, {len(files)} Lua files and active manifest ({path.name})")


if __name__ == "__main__":
    for target in ("retail", "forever"):
        verify(target)
