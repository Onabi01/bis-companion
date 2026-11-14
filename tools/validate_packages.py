"""Validate that a single archive loads only client-specific files for each WoW edition."""

from pathlib import Path
from zipfile import ZipFile

from package_addon import ROOT, MANIFESTS, get_package_files, read_manifest


def verify():
    version, files = get_package_files()
    path = ROOT / "dist" / f"BiSCompanion-Universal-{version}.zip"
    if not path.is_file():
        raise FileNotFoundError(f"Build first: {path}")

    with ZipFile(path) as archive:
        member_names = archive.namelist()
        names = set(member_names)
        expected = {"BiSCompanion/" + name for name in files}
        assert len(member_names) == len(names), "Duplicate ZIP paths"
        assert names == expected, (sorted(names - expected), sorted(expected - names))
        assert all(name.startswith("BiSCompanion/") for name in names), "Unexpected ZIP folder"
        for relative in files:
            assert archive.read("BiSCompanion/" + relative) == (ROOT / relative).read_bytes(), (
                "Archive differs from source", relative
            )
        for client in MANIFESTS:
            declared_version, interface, paths = read_manifest(client)
            assert declared_version == version
            for filename in paths:
                assert "BiSCompanion/" + filename in names, (client, filename)
            print(f"{client} manifest: {interface}, {len(paths)} Lua files")
        # Both TOCs are in one folder, but each client reads only its own manifest.
        retail_files = set(read_manifest("retail")[2])
        forever_files = set(read_manifest("forever")[2])
        assert "ForeverTalentPlanner.lua" not in retail_files
        assert "Core/Talents.lua" not in forever_files
        assert "compat/forever/Core/UI.lua" not in retail_files
        assert "Core/UI.lua" not in forever_files
        assert "ForeverBiS60.lua" not in forever_files
        assert "CommonItems.lua" not in forever_files
        assert "BiSCompanion/ForeverBiS60.lua" not in names
        assert "BiSCompanion/CommonItems.lua" not in names
        assert "ForeverTalentPlanner.lua" in forever_files

    print(f"Universal ZIP: OK ({len(files)} files, {path.stat().st_size} bytes)")


if __name__ == "__main__":
    verify()
