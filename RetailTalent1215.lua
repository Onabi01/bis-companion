-- Midnight 12.1.5 talent builds from Method guides.
-- Empty tables mean no current import code was exposed in the checked guide.
BiSCompanionTalentData = BiSCompanionTalentData or {}

-- https://www.method.gg/guides/blood-death-knight/talents
BiSCompanionTalentData["DK_Blood_Deathbringer"] = {
    { buildName = "Deathbringer Single Target", heroTree = "Deathbringer", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWGzMmxMzMYbmZmmZZGjxMGAAAAwMzMzMzMDzYMAYMzMzAAAMmtBGwSwywEYYBwMmBAgZGAzYA" },
    { buildName = "Deathbringer Mythic+", heroTree = "Deathbringer", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzwMmZmhZZmZmmZxYmxMGAAAAwMmZmZmZYGDAYmZmZGAAgxsNwAWC2GmADLAmxMAAMzAYYA" },
}
BiSCompanionTalentData["DK_Blood_San'layn"] = {
    { buildName = "San’layn Single Target", heroTree = "San'layn", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwYWmZGmxMzMMbzMz0MbGzMmxAAAAAmZmZmZmZYGjBAjZmZGAAADMwMW0YZDklBsBYGzAAAmZghB" },
    { buildName = "San’layn Mythic+", heroTree = "San'layn", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwMzyMzMmxMzMMLzMz0MLGjxMGAAAAwMmZmZmZYGDAYmZmZGAAADMwMW0YZBklBsBYGzAAAmZghB" },
}

-- https://www.method.gg/guides/frost-death-knight/talents
BiSCompanionTalentData["DK_Frost_Deathbringer"] = {
    { buildName = "[Raid/Cleave] Breath of Sindragosa", heroTree = "Deathbringer", importCode = "CsPAAAAAAAAAAAAAAAAAAAAAAMAmZMjZAz2MzMzMLzMjMjxYYmxgZmZmZmZmZAAAAAAAAAYMbDMgFwywEyYBzMmZGYAYYmBYmBD" },
    { buildName = "[Mythic+] Frostbane", heroTree = "Deathbringer", importCode = "CsPAAAAAAAAAAAAAAAAAAAAAAMAzMMjZAz2MzMzMLzMjMjxYYmxgZmZmZmZmZAAAAAAAAAYMbDMgFwywEyYBzMmZGYAYYmBYmBD" },
}
BiSCompanionTalentData["DK_Frost_Rider of the Apocalypse"] = {
}

-- https://www.method.gg/guides/unholy-death-knight/talents
BiSCompanionTalentData["DK_Unholy_Rider of the Apocalypse"] = {
    { buildName = "[Raid] Riders Single Target", heroTree = "Rider of the Apocalypse", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTzmZmZMjBAAAAAAAgZGmZAwyMmZ2mZGjZAbmFDDZgZjhGLAYGAGzMjZAmZmxYA" },
    { buildName = "[Raid/Mythic+] Riders Cleave", heroTree = "Rider of the Apocalypse", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTzmZmZMjBAAAAAAAgZGGDAWmxMz2MzYMDYzsZYIDMbM0YBDYGAGzMjZAmZmxYA" },
    { buildName = "[Raid/Mythic+] Riders AoE", heroTree = "Rider of the Apocalypse", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmhZMDDz2MzMTzmxMzMjBAAAAAAAgZGzYAwyMmZ2MzYMDYzsZYIDMbM0YBDYGAGzMjZAmZmxYA" },
}
BiSCompanionTalentData["DK_Unholy_San'layn"] = {
    { buildName = "[Raid] San’layn Single Target", heroTree = "San'layn", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMjZMDDz2MzMTjZmxYGDAAAAAAAAzDMMGAsMDzsZmxMzYgBmxiGLbA2mYDAzAYmZmZMDmZwMzYA" },
    { buildName = "[Mythic+] San’layn Blightfall", heroTree = "San'layn", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAYmhZMGDz2MzMTzyMzYMjBAAAAAAAg5BGDDAWmhZ2MzYMjBGYGbassAYbiNMgZAMzMzMmBzMYMjB" },
}

-- https://www.method.gg/guides/arms-warrior/talents
BiSCompanionTalentData["Warrior_Arms_Slayer"] = {
    { buildName = "Slayer - Single Target", heroTree = "Slayer", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMmZGAAAghphZGzMWmZmZGMmZAAAAAMzyMDIMWWGYBMgZYCZGsBmZYsNwyMLDwMDAmhBA" },
    { buildName = "Slayer - Cleave", heroTree = "Slayer", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMz8AmZGAAAghphZGzMWmZmZGMmZAAAAAMWmZgJMWWGYBMgZYCZGsBmZYsNYWmZbAmZAwMMA" },
    { buildName = "Slayer - AoE / Mythic+", heroTree = "Slayer", importCode = "CcEASWsDSHNyPDXnbxuIhH3ZdjZmZmFzYmZGAAAghphZGzMWmZmZGMmZAAAAAMWmZgJMW2GYBMgZYCZGsBmZYsNYWmZbAmZAwMMA" },
}
BiSCompanionTalentData["Warrior_Arms_Colossus"] = {
    { buildName = "Colossus - Single Target", heroTree = "Colossus", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMmZAAAAMMNMGzwyMzMzwMmZAAAAAM2mZAZBYzMG2gBmRb0YwCYmBz2MYZmlBzMAgZGGA" },
    { buildName = "Colossus - Cleave", heroTree = "Colossus", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAAzMzsMzMmZAAAAMMNMGzwyMzMzwMmZAAAAAM2mZgJA2MjhNYgZ0GNGsAmZwsNDWmZbwMDAYmhBA" },
    { buildName = "Colossus - AoE / Mythic+", heroTree = "Colossus", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAgZmxsMzMzYGAAAghphxYmxyMzMzwMmZAAAAAM2MDMZDYzMGWgBmRb0YwCYmhx2MMbmtBzMAAzwA" },
}

-- https://www.method.gg/guides/fury-warrior/talents
BiSCompanionTalentData["Warrior_Fury_Slayer"] = {
    { buildName = "Slayer: Single Target", heroTree = "Slayer", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDDmx2yMzMzMmxMzMjZmZWmZGjZmthZGAAIGLLDsAmgZYCMDbAzMbMGAAMzYYMzMMYA" },
    { buildName = "Slayer: Cleave", heroTree = "Slayer", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDDmx2yMzMzMmxMzMjZMzyMzYMzsNmZGAAIGLLDsAmgZYCMDbAzMbMGAAMzYYMzMMYA" },
    { buildName = "Slayer: AoE/Mythic+", heroTree = "Slayer", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDDmZ2WmZmZmxMmZMjZMzyMzYMzsNmZGAAIGLLDsAmgZYCMDbAmZjxAAgZGDzMzMMYA" },
}
BiSCompanionTalentData["Warrior_Fury_Mountain Thane"] = {
    { buildName = "Mountain Thane: Single Target", heroTree = "Mountain Thane", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDDzMz2yMzMzMMmZmZMjZWmZGjZmlxMzAAAhB2glNjGzAysgZsAYGMGAMzAYYMzMMYA" },
    { buildName = "Mountain Thane: Cleave", heroTree = "Mountain Thane", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDDzMz2yMzMzMMmZmZMjZWmZGjZmlxMzAAAhB2glNjGzAysgZsAYGMGAMzAYYMzMMYA" },
    { buildName = "Mountain Thane: AoE/Mythic+", heroTree = "Mountain Thane", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgGDDzMz2yMmZmxMmZMjZMzyMzYMzsMmZGAAIMwGssZ0YGQmFMjFAzgxAgZGADzMzMMYA" },
}

-- https://www.method.gg/guides/protection-warrior/talents
BiSCompanionTalentData["Warrior_Prot_Mountain Thane"] = {
    { buildName = "Raid Standard / Defensive - Recommended", heroTree = "Mountain Thane", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAzMzwMzYGzmxsMjxY0wMDLzMzMDGzMAAAAYZMAzYAGYDWWMaMDgZLmZDzMmZwsBAzMAAMDMG" },
    { buildName = "Raid Advanced / Offensive", heroTree = "Mountain Thane", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAzMjZmZmZGzmxsMjxY0wMDLzMzMDGzMAAAAYZAYGDwAbwyiRjZAMbxMbwMMDzsBAzMAAMDMG" },
    { buildName = "Mythic+ Standard", heroTree = "Mountain Thane", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAjZMmZmZGzmZmlZMGjGzYGLzMzMDDzMAAAAYZmBwYAGYDWWMaMDgZLmZDGzMDjNAYmBAADMG" },
}
BiSCompanionTalentData["Warrior_Prot_Colossus"] = {
}

