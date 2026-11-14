BiSCompanionTalentData = BiSCompanionTalentData or {}

-- Midnight 12.1.5: https://www.method.gg/guides/arcane-mage/talents
local arcaneSpellslinger1215 = {
    { buildName = "Raid Single Target", heroTree = "Spellslinger", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMDamxAAAwAAgAmZmZZZmJWAAYDzMzM2sMzMzyMGjZmBLMzMzMDAwAAAMzsAAmBADzMD" },
    { buildName = "Mythic+ / Raid Cleave", heroTree = "Spellslinger", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMDamxAAAwAAgAmZmZZZmJWAAYbwMzwmlZMjZMmZmZGWYmZmZGAgBAAYmZDAMDAGmZG" },
}
local arcaneSunfury1215 = {
    { buildName = "Mythic+ / Raid Cleave", heroTree = "Sunfury", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMDamxAAAwAAmZmmlllZAgYDAgNYmZYzyMmZZGjZmZmhFmZmZmBAYAAAGgZGwMAYYmZA" },
    { buildName = "Raid Single Target", heroTree = "Sunfury", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMDamxAAAwAAmZmmlllZAgYDAgNMzMzYzyMzMLzYMmZGswMzMzMAADAAwAMzAmBADzMD" },
}
-- https://www.method.gg/guides/fire-mage/talents
local fireSunfury1215 = {
    { buildName = "Season 1 Set", heroTree = "Sunfury", importCode = "C8DAAAAAAAAAAAAAAAAAAAAAAYGGLzMzswMzIzMGAAAGAwMz0sstMDAwmZmx2YmZGLAAAAAYxMzMDAAMmxMmZmZmFAMzQGjxgZYMA" },
    { buildName = "Season 2 Set", heroTree = "Sunfury", importCode = "C8DAAAAAAAAAAAAAAAAAAAAAAYGGLzMzswMzIzMGAAAGAwMz0sstMDAwmZmx2MzMzYBAAAAALmZmZAAgZMmZmZMzsMAMzQGjBMDjB" },
}
-- https://www.method.gg/guides/frost-mage/talents
local frostSpellslinger1215 = {
    { buildName = "Raid", heroTree = "Spellslinger", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZm5BmFMzEzMGzMzMziZmZMjZAAAgZmZWWmZaDAA2AAAALAstMmZmZY2GGzwCAAAzsBMTGDYGMMA" },
    { buildName = "Mythic+", heroTree = "Spellslinger", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZm5BmFMzEzMGzMzMziZmZMjZgAAAzMzssMz0GAAsBAAAWAYbZMzMzwsNMmhFAAAmZDYGGDYGMMA" },
}
local frostFrostfire1215 = {
    { buildName = "Raid", heroTree = "Frostfire", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZm5BmFMzEzMGzMzMWMzMzMGzsMTzMLzCAAAaBAA2AAAALAstMmZmZYMjxM2WAAAAzMYGGDYghB" },
    { buildName = "Mythic+", heroTree = "Frostfire", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzwYZmZmFMzEzMGzMzMWMzMzMGzsMTzMLzCAAAaBAA2AAAALAstMmZm5BYMjxM2WAAAAzMYmMGwADD" },
}
-- https://www.method.gg/guides/affliction-warlock/talents
local afflictionSoulHarvester1215 = {
    { buildName = "Raid Single Target", heroTree = "Soul Harvester", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjhZmZmlBAAYmZZ2mZmFzAAjttBGwAmhlADbDAAAzAAAYmZMjZGDDzYmZGDmZmBAYGYA" },
    { buildName = "Mythic+ / Multi Target", heroTree = "Soul Harvester", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAwMMzoZzM2mZmZWGAAwMzsMbzMzyYAgx2yADYCmhtADbDAAAGAAAzMjZMzsNGzgZmZGDzMzAAMDMA" },
}
local afflictionHellcaller1215 = {
    { buildName = "Spread Multi Target", heroTree = "Hellcaller", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjBzMmlBAAYmZZWmZmlxAAWgBmFjGzAysAWGAAAMAAwMDmZGzMMGmZmZmZGMzMzAAmBG" },
}
-- https://www.method.gg/guides/demonology-warlock/talents
local demonologyDiabolist1215 = {
    { buildName = "Raid Single Target", heroTree = "Diabolist", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjxmZGzyAAAAAAAAGzYYBGYb0GNsYwMLzyMzMmBAmhZmZmZAGzYMbAAgZmZmZGzwyMGwA" },
    { buildName = "Mythic+ / AoE", heroTree = "Diabolist", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjxmZGzyAAAAAAAAGzYYBGYb0GNsYYmZZ2mZmxMAwMMmZmZAGzYMbAAgZmZmZGzwyMGwA" },
}
local demonologySoulHarvester1215 = {
    { buildName = "Raid Single Target", heroTree = "Soul Harvester", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjxmZGzyAAAAAAAMWWGYADYGWCZsZwMLzyMzMmBAmhZmZAmZGzYMbAAgZmZmZGzwyMGwA" },
    { buildName = "Mythic+ / AoE", heroTree = "Soul Harvester", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAwMzMzoZjxmZGzyAAAAAAAMWWGYADYGWCZsZYmZZ2mZmxMAwMMmZAmZGzYMbAAgZmZmZGzwyMGwA" },
}
-- https://www.method.gg/guides/destruction-warlock/talents
local destructionHellcaller1215 = {
    { buildName = "Raid Single Target", heroTree = "Hellcaller", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZmpZbMMzMmtZxMzMLGjFzAAgZmxMzsZBGYWMaMDgZL2YAAgxAjNAgZGYmxMDAAAzMzAAwYYA" },
    { buildName = "Raid Cleave", heroTree = "Hellcaller", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZmpZbMMzMmtZbmZmZxYWWMDAAmxYmZ2sADMLGNmBwsFbMAAwYA2AAmZgZGzMAAAMzMDAAjhB" },
    { buildName = "Mythic+", heroTree = "Hellcaller", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZmpZbMMzMmtZbmZmZxMzyyYAAwMGzMzmFYgZxoxMAmtYjBAAGzwAAgZGwMmZ2AAAMzMDAAMM" },
}
local destructionDiabolist1215 = {
    { buildName = "Raid Single Target", heroTree = "Diabolist", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZmpZbMMzMmtZxMzMLGjFzAAgZmxMzsBGzYYhMw2wGNWYAAgxAjNAMzAYmxMDAAAzMzAAwYYA" },
    { buildName = "Raid Cleave", heroTree = "Diabolist", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZmpZbMMzMmtZxMzMLGjFzAAgZmxMzsZBGYWMaMDgZL2YAAgxAjNAgZGYmxMDAAAzMzAAwYYA" },
    { buildName = "Mythic+ / AoE", heroTree = "Diabolist", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAwMmZmpZbMMzMmtZbmZmZxMzyyYAAwMGzMzGYMjhFyAbDb0YhBAAGzwAAMzAwMmZ2AAAMzMDAAMM" },
}

-- Devourer, Midnight 12.1.5: https://www.method.gg/guides/devourer-demon-hunter/talents
BiSCompanionTalentData["DH_Devourer_Annihilator"] = {
    { buildName = "Raid Cleave / Mythic+", heroTree = "Annihilator", importCode = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAQgHYMDjZA" },
    { buildName = "Raid Single Target", heroTree = "Annihilator", importCode = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMzMzMjZmZGzsYGjFtswMzMzWbzMzAYGDABegxghB" },
}
BiSCompanionTalentData["DH_Devourer_Void-Scarred"] = {
    { buildName = "Raid Single Target", heroTree = "Void-Scarred", importCode = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMmZmZMzMDzsMzYsptFAEwAYMzMbzMTz2MbzMMmxA" },
    { buildName = "Raid Cleave", heroTree = "Void-Scarred", importCode = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMmZmZmZmZYmlZGjNtsAgAGAjZmZbmZa2mZzMjxMGA" },
    { buildName = "Mythic+", heroTree = "Void-Scarred", importCode = "CgcBAAAAAAAAAAAAAAAAAAAAAAAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMmZmZmZmZYmlZYsplFAEwAYMzMbzMTz2MbzMDmxA" },
}

-- Death Knight - Blood (Deathbringer)
BiSCompanionTalentData["DK_Blood_Deathbringer"] = {
    { buildName = "Mythic+", heroTree = "Deathbringer", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwwYmZGzYmZGmxMzMNDDzMmxAAAAAzMzMzMzMzmZmxAAAYmZmBAAAM22GYALBbDTghFAmBbA" },
}

-- Death Knight - Blood (San'layn)
BiSCompanionTalentData["DK_Blood_San'layn"] = {
    { buildName = "Mythic+", heroTree = "San'layn", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwwYmZYGzMzwMmZmpZGDzMmxAAAAAzMzMzMzMzmZmxAAAYmZmBAAAYgBmxoxyGILDYDgZwGA" },
    { buildName = "Raid Cleave", heroTree = "San'layn", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwwgZYGzMzwMmZmpZGzYmxMGAAAAYmZmZmZmZ2MzMGAAAzMzMDAAAYgBmxoxyGILDYDgZwGA" },
    { buildName = "Raid Single Target", heroTree = "San'layn", importCode = "CoPAAAAAAAAAAAAAAAAAAAAAAwwgZYGzMzwMmZmpZGzYmxMGAAAAYmZmZmZmZ2MzMGAAAzMzMDAAAYgBmxoxyGILDYDgZwGA" },
}

-- Death Knight - Frost (Rider of the Apocalypse)
BiSCompanionTalentData["DK_Frost_Rider of the Apocalypse"] = {
    { buildName = "Raid Single target", heroTree = "Rider of the Apocalypse", importCode = "CsPAAAAAAAAAAAAAAAAAAAAAAMDwMzYGjZGGmZmZmhxMyMmZmhZgHwMDmZmZmBAAAAAAAAAAAgNzihBGY20QDbGzMzYmBmxA" },
    { buildName = "Raid Cleave", heroTree = "Rider of the Apocalypse", importCode = "CsPAAAAAAAAAAAAAAAAAAAAAAMDwMzwMzMzwwYmZmhxMTmxMjhZAmZmZmZmZmBAAAAAAAAAAAgNzihBGY20QDbGzMzYMwwA" },
    { buildName = "Mythic+ BoS", heroTree = "Rider of the Apocalypse", importCode = "CsPAAAAAAAAAAAAAAAAAAAAAAMDwMzYGjZGGmZmZmhxMyMmZMMGwMzMzMzMzMAAAAAAAAAAAAsZWMMwAzmGaYzYmZGzMwwA" },
    { buildName = "Mythic+ FrostBane", heroTree = "Rider of the Apocalypse", importCode = "CsPAAAAAAAAAAAAAAAAAAAAAAYAmZGzYMzwwMzMzMMmRmxMDzMzgZGmZmZmZmBAAAAAAAAAAAgNzmhBGY20QDbGjZGzMgxA" },
}

-- Death Knight - Unholy (Rider of the Apocalypse)
BiSCompanionTalentData["DK_Unholy_Rider of the Apocalypse"] = {
    { buildName = "Raid Single Target", heroTree = "Rider of the Apocalypse", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAgZGzMjxwMmZmZaYmZmxMGAAAAAAAAmZmZhZGzAAmtZMzY2mZmBzAsYWMMkBmNGasAAzAYA" },
    { buildName = "Raid Cleave", heroTree = "Rider of the Apocalypse", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAgZGzMjxwMmZmZaYmZmxMGAAAAAAAAmZmZjZGzAAmtZYGz2MzMYGgFzihhMwsxQjFMAzAYA" },
    { buildName = "Mythic+", heroTree = "Rider of the Apocalypse", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMDzYmxwMzMzMTDzYMzMGAAAAAAAAmZmZDzYmBAsNDzY2mZmxYGgFzihhMwsxQjFMAzAYA" },
}

-- Death Knight - Unholy (San'layn)
BiSCompanionTalentData["DK_Unholy_San'layn"] = {
    { buildName = "Raid Single Target", heroTree = "San'layn", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAgZGzMjxwMmZmZaYmZmxMGAAAAAAAAmZmZhZGzAAmtZMzY2mZmhZGGYgZMassBYZiNAYGAA" },
    { buildName = "Raid Cleave", heroTree = "San'layn", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAgZGzMjxwMmZmZaYmZmxMGAAAAAAAAmZmZjZGzAAmtZYGz2MzMMzwADMjRjlNALTshBYGAA" },
    { buildName = "Mythic+", heroTree = "San'layn", importCode = "CwPAAAAAAAAAAAAAAAAAAAAAAAwMDzYmxwMzMzMTDzYMzMGAAAAAAAAmZmZDzYmBAsNDzYWmZmxMzwADMjRjlFALTshBYGAA" },
}

-- Mage - Arcane - Sunfury
BiSCompanionTalentData["Mage_Arcane_Sunfury"] = {
    { buildName = "Raid Single Target", heroTree = "Sunfury", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAYMMbzgZ8AjZxwYmhx0MjZAAAAAAYAAzMTLz2yMAQsBAAAAAAAWYwMLzyMmZMzMmHYmZmxMsMG" },
    { buildName = "Raid Cleave", heroTree = "Sunfury", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAYMMbzgZ8AjZxwYmhx0MjZAAAAAAYAAzMTLz2yMAQsBAAAAAAAWGDmZZWmxMjZmhHYmZmxMsMG" },
    { buildName = "Mythic+", heroTree = "Sunfury", importCode = "C4DAAAAAAAAAAAAAAAAAAAAAAYMLmtZwMjZmF4BMzwYamxMAAAAAAMAgZmplZbbGAI2AAAAAAYDAjBzsMLzYmxYGmZmZGzYWGD" },
}

-- Mage - Arcane - Spellslinger
BiSCompanionTalentData["Mage_Arcane_Spellslinger"] = {
}

-- Mage - Fire (Sunfury)
BiSCompanionTalentData["Mage_Fire_Sunfury"] = {
    { buildName = "Raid", heroTree = "Sunfury", importCode = "C8DAAAAAAAAAAAAAAAAAAAAAAYMMbzgZmZMLGYmhpxMjZAAAAAAYgAmZmWmllZAA2MmBjZGzMmFzyYYmhZ2mhZWGGAAAAAAA" },
    { buildName = "Mytic+", heroTree = "Sunfury", importCode = "C8DAAAAAAAAAAAAAAAAAAAAAAYGMbGMzYmZxDAzMjpxMjZGAAAAAADEwMz0yssNDAwmZmBjZGmxsYWGDzMbmZbGLzsgBAAAAAAA" },
}

-- Mage - Fire (Frostfire)
BiSCompanionTalentData["Mage_Fire_Frostfire"] = {
    { buildName = "Raid", heroTree = "Frostfire", importCode = "C8DAAAAAAAAAAAAAAAAAAAAAAYMMbzCmZmxsYgZGmGzMmBAAAAAgZWmpZmtZBCAAYxYGMzMjZmZWMLjxMPAmZbGMLYAAAAAAAA" },
    { buildName = "Mythic+", heroTree = "Frostfire", importCode = "C8DAAAAAAAAAAAAAAAAAAAAAAYMMbzgZGzMLeAYmZMNmZMDAAAAAAzsMTzMbzCEAAwiZmZmZGjZmZsYMzYGMzsNjFWAAAAAAAA" },
}

-- Mage - Frost _Frostfire
BiSCompanionTalentData["Mage_Frost_Frostfire"] = {
    { buildName = "Single Target", heroTree = "Frostfire", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzYzsZwMjZmFPAMzMNGjxMzghZYmZmZmZmZmZmxMzMmZWmpZmtZBAAAtAAAAAAALAAAAAAAAA" },
    { buildName = "Multi", heroTree = "Frostfire", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzYzsZwMjZmFPAMzMNGjxMzghZYmZmZmZmZmZmxMzMmZWmpZmtZBAAAtAAAAAAALAAAAAAAAA" },
}

-- Mage - Frost Spellslinger
BiSCompanionTalentData["Mage_Frost_Spellslinger"] = {
    { buildName = "Single Target", heroTree = "Spellslinger", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzYzsZwMjZmFPAMzMNGjxMzghZYmZmZmZmZmZmxMzMmZWmpZmtZBAAAtAAAAAAALAAAAAAAAA" },
    { buildName = "Multi", heroTree = "Spellslinger", importCode = "CAEAAAAAAAAAAAAAAAAAAAAAAMzYzsZwMjZmFPAMzMNGjxMzghZYmZmZmZmZmZmxMzMmZWmpZmtZBAAAtAAAAAAALAAAAAAAAA" },
}

-- Rogue - Assassination (Deathstalker)
BiSCompanionTalentData["Rogue_Assassination_Deathstalker"] = {
    { buildName = "Raid Single Target with Cleave", heroTree = "Deathstalker", importCode = "CMQAAAAAAAAAAAAAAAAAAAAAAMjZmhxM2mBAAAAAgZDWmBAAAAAg22mZGMzYMzMLz2MzMmBDzMzYmNLjZA2MLDMglglhJwwCA" },
    { buildName = "Mythic+", heroTree = "Deathstalker", importCode = "CMQAAAAAAAAAAAAAAAAAAAAAAYmZMzMmBAAAAAAYWmxsMDAAAAAAttMzMYmBzMzysMYMmZmZmZmZYzyYGgNzyADYJYbYCMsMA" },
}

-- Rogue - Assassination (Deathstalker)
BiSCompanionTalentData["Rogue_Assassination_Fatebound"] = {
    { buildName = "Raid Single Target with Cleave", heroTree = "Fatebound", importCode = "CMQAAAAAAAAAAAAAAAAAAAAAAMjZmhxMYAAAAAAY2glZAAAAAAottZmxMzMGzMzysMzMjZwwMzMmZz2YGADsAzY0Y2AZbAbA" },
}

-- Rogue - Outlaw Fatebound
BiSCompanionTalentData["Rogue_Outlaw_Fatebound"] = {
    { buildName = "Raid Single Target", heroTree = "Fatebound", importCode = "CQQAAAAAAAAAAAAAAAAAAAAAAAAM2mxMjZMmZmZYGGMjhZmZmWmxsNDAAAAAA22mZGMzMzCsMbDAAAAzMDYgNYGjGzGgtJsYA" },
}

-- Rogue - Outlaw Trickster - Hidden Opportunity
BiSCompanionTalentData["Rogue_Outlaw_Trickster"] = {
    { buildName = "Raid Cleave / M+", heroTree = "Trickster", importCode = "CQQAAAAAAAAAAAAAAAAAAAAAAAAM2mBjZGmZmZYGegxMzMMzMz0yMmtZAAAAAAw22MzgZmZWglZbAAAAYmZAwY2MMkBmFWoF2MA" },
}

-- Rogue - Subtlety
BiSCompanionTalentData["Rogue_Subtlety_Deathstalker"] = {
    { buildName = "Raid : Single Target", heroTree = "Deathstalker", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAAM2mBAAAAAALjZWmGzswDMzYMMzYmZGGz2YGzYbmZMzMjBsMbDAAAgZGMsYWGYALgthJkZBG" },
    { buildName = "Mythic+", heroTree = "Deathstalker", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAAM2mBAAAAAALjxy0YswDMzgZMzYmZGGz2sMjZsNzMYmxYMzysNAAAAmZwwmZbgBsAWGmQmFYA" },
}

-- Rogue - Subtlety
BiSCompanionTalentData["Rogue_Subtlety_Trickster"] = {
    { buildName = "Raid : Single Target", heroTree = "Trickster", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAAM2mBAAAAAALjZWmGzsMGzYMMMzMzwY2GzMzYbmZmZmZMglZbAAAAYGMAGzmhBGYW0CtYDG" },
    { buildName = "Raid : Cleave", heroTree = "Trickster", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAAM2mBAAAAAALjxy0YmFmZGjxMeAzMzwY2GzYGbzMjZmZMYsMbDAAAgZGMAGzmhBGYW0CtYDG" },
    { buildName = "Mythic+", heroTree = "Trickster", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAAM2mBAAAAAgZZMWmGzgZmxYGjxMzMMmtZxYstNzMYmxYMzysNAAAAMDGAjZzwADMLahWsBD" },
}

-- Demon Hunter - Havoc (Aldrachi Reaver)
BiSCompanionTalentData["DH_Havoc_Aldrachi Reaver"] = {
    { buildName = "Raid Single Target Exergy", heroTree = "Aldrachi Reaver", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYGMzMzYMzMjZmJmZGAAAAAAwsZMbzwMzsNzMbWmlxwMzwYZbWmBDjtNmkhZmBWWA" },
    { buildName = "Raid Single Target No Mover", heroTree = "Aldrachi Reaver", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYGMzMzYMzMjZmJmZGAAAAAAwsZMbzwMzsNzMbYZGMzMmxy2sMDGGbbMJDzMDssA" },
    { buildName = "Mythic+/Cleave Low Mover", heroTree = "Aldrachi Reaver", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZGjZmZMmJzMzAAAAAAAmFjxMMzMbjZ2wyMDGDjltZZGMM22YSmxMzwYZB" },
    { buildName = "Mythic+/Cleave Exergy", heroTree = "Aldrachi Reaver", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmxMzYMzMjxMZmZGAAAAAAwsYMmhZmZjZ2sMLzMYmhxy2sMDGGbbMJz4BmZYssA" },
}

-- Demon Hunter - Havoc (Fel-Scarred)
BiSCompanionTalentData["DH_Havoc_Fel-Scarred"] = {
    { buildName = "Raid Single Target Inertia", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYAzMzgZmZMmJmZGAAAAAAwsMmxMMGLzMzmtZZegZmZmZZwGsMLmxwsppBzMzMstB" },
    { buildName = "Raid Single Target No Mover", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZGzMzgZmZMmJmZGAAAAAAwsMmxMMGLjZ2wyMmxMjhlNYZ2MjhZTTjxMzMDbb" },
    { buildName = "Mythic+/Cleave Inertia", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmxMzgZmZMmJzMzAAAAAAAmlhxMMzMbjZ2sNLzMYmhxyGsMbmxwsopxwMjhtN" },
    { buildName = "Mythic+/Cleave Low Mover", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZmZmZGMzMjxMZmZGAAAAAAwsMMmhZmZbMzGWmZwYYssBLzmZMMLaaMmZGDbb" },
}

-- Demon Hunter - Vengeance Fel-Scarred
BiSCompanionTalentData["DH_Vengeance_Fel-Scarred"] = {
    { buildName = "Raid Single Target DPS", heroTree = "Fel-Scarred", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAGjZmZMmZkZmxYYMbzMYsNjZegZMzwMjZGbjZYGMAAAAALziZMMbaagZmZYbD" },
    { buildName = "Raid Single Target with Cleave", heroTree = "Fel-Scarred", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAGjZmZMmZkZmxYYmZbmBjtZMzDMjZwMjZGbjZYGMAAAAALziZMMbaagZmZYbD" },
    { buildName = "Mythic+", heroTree = "Fel-Scarred", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAGjZmZMMjMzMYYmZbmxYsNjZMjZwMz2MzsZmZbmhZAAAAAWmFzYYW00AzMw2G" },
}

-- Demon Hunter - Vengeance Aldrachi Reaver
BiSCompanionTalentData["DH_Vengeance_Aldrachi Reaver"] = {
    { buildName = "Mythic+ Defensive", heroTree = "Aldrachi Reaver", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAGjxMjhZkZmhZYmZbMMsNjZmhZMGz2MzsZmZbmhZAAAAY2mBDjlFmkBzMMWWA" },
    { buildName = "Mythic+ Cheat", heroTree = "Aldrachi Reaver", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAGjxMjhZkZmhZYmZbMMsNjZmxMjBz2MzsZmZbmhZAAAAY2mBDjlFmkBzMMWWA" },
}

-- Monk - Brewmaster Master of Harmony
BiSCompanionTalentData["Monk_BM_Master of Harmony"] = {
    { buildName = "Raid Default - Standard/Defensive", heroTree = "Master of Harmony", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGzYWmx2MmZAAAAAAAYZBjwMwMMzGD2mZmhZZMGbzyMttZx2MzwsAAALz20ysNzyAAACADbA" },
    { buildName = "Raid - Single Target with Cleave", heroTree = "Master of Harmony", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgxmxMmxsMjNmZGAAAAAAAWWAxMDMDDMGbzMzYmlhZsNLz02mtZbmZYWAAglZbaZ2mZZAAABwMsA" },
    { buildName = "Mythic+ - Standard", heroTree = "Master of Harmony", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbDzYGzyM2mxMDAAAAAAALLwEzMwMMYGsNzMDzywMWmlZiHYZ2mZGmFAAYZ2mWmtZWGAAQAMDbA" },
}

-- Monk - Brewmaster Shado-Pan
BiSCompanionTalentData["Monk_BM_Shado-Pan"] = {
    { buildName = "Raid", heroTree = "Shado-Pan", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgxmxMmxsMjNmZGAAAAAAAWWAxMDMDDMGbzMzYmlhZsNLz02mtZbmZYWAAgNEAAAz2s0MzMLMDLA" },
    { buildName = "Mythic+", heroTree = "Shado-Pan", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbDzMzYWmx2YmZAAAAAAAYZBmYmBmhBzgtZmZYWGmx2sMTYb2mZGmFAAYDBAAwsNLNzMzCzwG" },
}

-- Monk - Mistweaver Conduit of the Celestials
BiSCompanionTalentData["Monk_MW_Conduit of the Celestials"] = {
    { buildName = "Yu'lon Raid", heroTree = "Conduit of the Celestials", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghFLzAbYGzMLPAbbLzyMDbzy22MzyCzoZmZgZYGGYbmZGmtxYwiJAAAAAIALWmllZbmZCAA2A" },
    { buildName = "Chi-ji Raid", heroTree = "Conduit of the Celestials", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghFmZZMLGzYmZBbbLzyMDmNbzMLLMjmZmBmhZYgtZmZY2GjBLmAAAAAgAsYZW2mtZmJAAYD" },
}

-- Monk - Mistweaver Master of Harmony
BiSCompanionTalentData["Monk_MW_Master of Harmony"] = {
    { buildName = "Mythic+ Beginner Build", heroTree = "Master of Harmony", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghFLzsMmFz2MmxG2WWmtxDgZbZZmZZhxEzMwMMDDsNzMDzGzMMLPwEAAAAgZbaZ2mZZ2AABAAbA" },
    { buildName = "Mythic+ Advanced Build", heroTree = "Master of Harmony", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghFLzsMmFz2MmxG2WWmtxDgZbZZmZZhxEzMwMMDDsNzMDzGzMMLPwEAAAAgZbab2mZZ2AABAAbA" },
}

-- Monk - Windwalker Shado-pan
BiSCompanionTalentData["Monk_WW_Shado-pan"] = {
    { buildName = "Mythic+", heroTree = "Shado-pan", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYAMzM2mZMzMDAAAAAAAAAAALLDjYmhxMMswM2mZmhZjZGsMTAAsMmhZmhtZAAsBANLzSzMzsAYG" },
    { buildName = "Raid", heroTree = "Shado-pan", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzsMAmZMLzMmZGAAAAAAAAAAAssMMiZGYGGWMzYbmZGmthZwyMBAwyMzgZG2mBAwGA0sMLNzMzCgZA" },
}

-- Monk - Windwalker Conduit of the Celestials
BiSCompanionTalentData["Monk_WW_Conduit of the Celestials"] = {
    { buildName = "Raid", heroTree = "Conduit of the Celestials", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYmBzYGzyMDGAAAAAAAAAAAYZZYEzMwMMsYmx2MzMMbDzglZCAAmZGzMzMbzAAYZZWWmtZmJIAYA" },
    { buildName = "Mythic+", heroTree = "Conduit of the Celestials", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYmBDzMzyMDGAAAAAAAAAAAYZZYmYmhxMgFmx2MzMMbDzglZCAglZmZMDzsNDAgllZZZ2mZmgAgBA" },
}


-- Paladin - Holy Lightsmith
BiSCompanionTalentData["Paladin_Holy_Lightsmith"] = {
    { buildName = "Raid - Beacon of Virtue", heroTree = "Lightsmith", importCode = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAzAAAAYbmZmxMmZYGzyMDLzgZ22MtFzYGzMDDMbZAADA2A2YWmxMAIAgZmltlWmZYDAsZYYMzA" },
    { buildName = "M+ - Beacon of Virtue", heroTree = "Lightsmith", importCode = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAzAAAMAbjZmxMmZsYMLzMsMDmZbbm2aMjZMzMMwslBAMAYDYjZxMGAEAwMzy2SLzMsBYG2MwMMA" },
}

-- Paladin - Holy Herald
BiSCompanionTalentData["Paladin_Holy_Herald"] = {
    { buildName = "Raid - Beacon of Virtue", heroTree = "Herald", importCode = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAzAAAAYbmZmxMmZwMzyMDLzgZ22MtFzYGzMDDMbZAADYwGwGzyMmZWmtZmZrBAAEwCAYzwwYGA" },
    { buildName = "Raid - Beacon of Faith", heroTree = "Herald", importCode = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAzAAAAYZmZmxMmZwMzyYYZGMz2mptYGzYmZYgZLDAYAD2A2YWmxMzysNzMbNAAgAWwAYzwwYGA" },
    { buildName = "M+ - Beacon of Faith", heroTree = "Herald", importCode = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAzAAAMALjZmZmxMDGzyYYZGMz22Mt1YGzYmZYgZLDAYAwGwGzyMjZWmtZmZrBAAEwCgZYzAzwA" },
    { buildName = "M+ - Beacon of Virtue", heroTree = "Herald", importCode = "CEEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAzAAAMAbjZmZmxMjFjZxMsMDmZbz0WjZMjZmhBmtMAgBAbAbMLzMmZZ2mZmtGAAQALAmhNDMDDA" },
}

-- Paladin - Protection (Templar)
BiSCompanionTalentData["Paladin_Prot_Templar"] = {
    { buildName = "Mythic+", heroTree = "Templar", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsZMYWGLzMjZmZZbmZGzsNmxAAAMAAAAAAA0WzMzihZGGD2aDAGDMAAbDAAwMTbzysNDQgNGMMgBzshB" },
}

-- Paladin - Protection (Lightsmith)
BiSCompanionTalentData["Paladin_Prot_Lightsmith"] = {
    { buildName = "Raid Damange", heroTree = "Lightsmith", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsMzMMzyYZMzMzM2mZmhBDDAAwAAAAAAAQyMzyMMzwYM2aDAGDAwMYbAAAQAmZW2WabmxiZwwAmhZYMA" },
    { buildName = "Raid Defensive", heroTree = "Lightsmith", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsZMMzyYZmZMzM2mZmZmZjhBAAYAAAAAAAIZmZZGmZYMYrNAYMAAzgtBAAABYmZZbptZGLMYYAzwMMG" },
    { buildName = "Mythic+", heroTree = "Lightsmith", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsNj5BYWGLjZMzMLbzMzYGjZMAAADAAAAAAAt1MzsYYmhxgt2AgxADAw2AAAgAMzsst02MjFzghBMYmNMA" },
    { buildName = "Mythic+ Push keys", heroTree = "Lightsmith", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsZMYWGLzMjZmZZbmZGzsNmxAAAMAAAAAAA0WzMzihZGGD2aDAGDMAAbDAAACwMzy2SbzMWYwwAGMzGG" },
}

-- Paladin - Retribution
BiSCompanionTalentData["Paladin_Ret_Templar"] = {
    { buildName = "Raid Single Target", heroTree = "Templar", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAamltZmtltxYbMz22MbAAAAAAY00MMMzYbGMbDzysNDDDmhZsswGAAAZmptZZ2mBAsBMAYMmhZA" },
    { buildName = "Raid Single Target with Cleave", heroTree = "Templar", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAYAAamltZmtltxYbMz22MbAAAAAAY00MMMzYbGMbDjZbGbDDmhZsswGAAAZmptZZ2mBAsBMAYMmhZA" },
    { buildName = "Mythic+", heroTree = "Templar", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAYAgRmltZmtltZGbGz2mZbAAAAAAY2aaGGmZsNDmthxsNzy2YGMDzYZhNAAAyMTbzysNDAYDYAADDD" },
    { buildName = "Delves/Open World", heroTree = "Templar", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAYAgRjltZmtltZGLzYW2YbAAAAAAY2aaGGMjtZMmthxsNzy2YGMDzYZhNAAAyMTbzysNDAYDYAAYYGA" },
}

-- Priest - Discipline Oracle
BiSCompanionTalentData["Priest_Disc_Oracle"] = {
    { buildName = "Raid", heroTree = "Oracle", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAAgNzMDGjxMDzsx2MzMzMzMAAAAAAAAAAYWmlZbwMzgZhxMMjBLsNTjJWmBYmFsRxY2GgxGWAAA" },
    { buildName = "Mythic +", heroTree = "Oracle", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAAglZmZwYMmBzsZ2mZmZmZmBAAAAAAAAAAWsMbDmZGMLMmxYMYxsNTzMxiBYmNsQxYWGgxGWAAA" },
}

-- Priest - Discipline Voidweaver
BiSCompanionTalentData["Priest_Disc_Voidweaver"] = {
    { buildName = "Raid", heroTree = "Voidweaver", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAAglZmZ8AGjxMzYmNz2MzMzMGAAAAAAAAAAwilZbwMzgZhxMmZMYhtZamJWGYmBAFgZZ22AjNbAAA" },
    { buildName = "Mythic+", heroTree = "Voidweaver", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAAglZmZ8AGjxMzYmNz2MzMzMGAAAAAAAAAAwilZbwMzgZhxMmZMYhtZamJWGYmBAFgZZ22AjNbAAA" },
}

-- Priest - Holy
BiSCompanionTalentData["Priest_Holy_Archon"] = {
    { buildName = "Raid", heroTree = "Archon", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwAAAAAAAgxYmZbmZGzwwMMz2MjZAAAAwsYZ2G2mZGMLMmhZMYZBmZmaWAAzsZZysYAIjBbsY2GA" },
    { buildName = "Mythic+", heroTree = "Archon", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAzmxDMGjZYGzMmZmx2MzMAAAAglZZ2GMzMYWYWmxgBLsxMzUzCAzsgFCjZZANWgFMWGA" },
    { buildName = "Delves/Quests", heroTree = "Archon", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAzmhxsMMMjZmHYmZGLzMzAAAAAYZ2G2mZGMLMLzYmxglNwMTNLAgZWsMZ2MAkxgNMWGA" },
}

-- Priest - Holy
BiSCompanionTalentData["Priest_Holy_Oracle"] = {
    { buildName = "Raid", heroTree = "Oracle", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAMGzMbzMzYGDmZmx2MMDAAAAmFLz2w2MzgZhZZGjxglFYGqZBgZWwChxsMgGLwCLmtBA" },
    { buildName = "Mythic+", heroTree = "Oracle", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAzmxDMGjZYGzMmZmx2MzMAAAAglZZ2GMzMYWYWmxgBLsxMzUzCAzsgFCjZZANWgFMWGA" },

}

-- Priest - Shadow Archon
BiSCompanionTalentData["Priest_Shadow_Archon"] = {
    { buildName = "Raid Single Target", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMMGAAAAAAAAAAAAjxygZmZbZjZmZmZmZZwsxMzMjZjBGjhZxsN1MDWwMAzsZZ0sZAIjxCAsNA" },
    { buildName = "Raid Cleave", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMMGAAAAAAAAAAAAjxygZmZbZjZmZmZmZZwsxMzMjZjBGjhZxsN1MDWwMAzsZZ0sZAIjxCAsNA" },
    { buildName = "Mythic+", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMmBAAAAAAAAAAAAjxCjZmZbZjZmZmZmZZwsxMzMjZjBGjhZxsN1MDWwMAzsZZ0sZAIjxCAsNDA" },
}
 
-- Priest - Shadow Voidweaver
BiSCompanionTalentData["Priest_Shadow_Voidweaver"] = {
    { buildName = "Raid Single Target", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMDMzDAAAAAAAAAAAAYM2GMzMLbbMzYmZmZZwsxMzMjZjBGjhZxsN1MDWgZmBACwsNbLBzGbA2mB" },
    { buildName = "Raid Cleave", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMDMzDAAAAAAAAAAAAYM2GMzMLbbMzYmZmZZwsxMzMjZjBGjhZxsN1MDWgZmBACwsNbLBzGbA2mB" },
    { buildName = "Mythic+", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMDmZAAAAAAAAAAAAYM2YMzMLbbMzYmZmZZwsxMzMjZjBGjhZxsN1MDWgZmBACwsNbLBzGLA2mB" },
}

-- Shaman - Elemental Farseer
BiSCompanionTalentData["Shaman_Ele_Farseer"] = {
    { buildName = "Raid Single Target", heroTree = "Farseer", importCode = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAAMbzyyMjZGzysMGMYmBAAAAwmZ2gBMgZjJkZBAMbTzYY2YMTMzMzYYbmZGMbDWmZmZmZYmNA" },
    { buildName = "Raid Cleave", heroTree = "Farseer", importCode = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAAMbz2yMjZGz2sMmBMzMDAAAAAYzMG2gFYGN0YDAMbTzgxGjZaYmZGzYZGzYxsMWsYGDGzMbDA" },
}

-- Shaman - Elemental Stormbringer
BiSCompanionTalentData["Shaman_Ele_Stormbringer"] = {
    { buildName = "Mythic+", heroTree = "Stormbringer", importCode = "CYQAAAAAAAAAAAAAAAAAAAAAAAAAAAAYb2WmZmZGz2sMGMMDDAAAAAYzMG2gFYGN0YDAMbTzgxGjZaYmZGzYZGzYxsMWsYmZmxwMbDA" },
}

-- Shaman - Restoration (Totemic)
BiSCompanionTalentData["Shaman_Resto_Totemic"] = {
    { buildName = "Totemic Chain Heal Raid", heroTree = "Totemic", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAAAGAAAAAjZmZZmtxMjxysMWMswCsAzYTjlBkZgNmZmFLmtZmZmMbLMz0YGmZDLzYGMGmlxAAgB" },
    { buildName = "Totemic Chain Heal M+", heroTree = "Totemic", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAAAGAAAAAzMzMLzsMzMjhZZsYGYBWgZsox2AyMwGzMziFz2MzMysBz0YmhhxixMYWGLzyMDAAG" },
}

-- Shaman - Restoration (Totemic)
BiSCompanionTalentData["Shaman_Resto_Farseer"] = {
    { buildName = "Totemic Chain Heal Raid", heroTree = "Farseer", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYMzMbzsNMzDMLLz2YxwiNzsADYCmFmAjFMzsYZmtZmZmMbLMz0YGmZDLzYGMGmlxAAgB" },
    { buildName = "Totemic Chain Heal M+", heroTree = "Farseer", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYmZmZbmthZegZzsNWMjFLmZBGwEMLMBGLYmZxyMbzMDZ2gZaMzwwYxYGLmlxysMzAAgB" },
}

-- Shaman - Enhancement Stormbringer
BiSCompanionTalentData["Shaman_Enh_Stormbringer"] = {
    { buildName = "Single Target", heroTree = "Stormbringer", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMDmZGjtZmZGsNzYZYAAAAAAAAAAbA2MjhNyCMDDNYBAWmmZGssYmZmhxMz2wyMzEYYWmZAAGD" },
    { buildName = "Raid Cleave", heroTree = "Stormbringer", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMDMzMjtZmZGsNzYZMAAAAAAAAAAbA2MjhNyCMDDNYBAWmmZGssYmZmhxMz2wyMzEYYWmZAAGD" },
    { buildName = "Mythic+/AoE", heroTree = "Stormbringer", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMDMzDMjtZmZegZmlZGYAAAAAAAAAA2AsZGDbkFYGGawCAmlJDMLLmxgxYmthlZmpZhlZWGzMAAjB" },
    { buildName = "Delves", heroTree = "Stormbringer", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMDMzDMjtZmZegZmlZGYAAAAAAAAAA2AsZGDbkNYGGawCAmlJDYZxMzMDzYmthlZmJLsMWGzMAAjB" },
}

-- Shaman - Enhancement Totemic
BiSCompanionTalentData["Shaman_Enh_Totemic"] = {
    { buildName = "Single Target", heroTree = "Totemic", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZGGDzMzMzMbzMWGAAAAAAAAAAgFYDmxiGbDgZC2AglpZmBLLmZmZYMzsNsMzMBGmlZGAgBA" },
    { buildName = "Raid Cleave", heroTree = "Totemic", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZGGYmZmZmZbmxyYAAAAAAAAAAgFYDmxiGbDgZC2AglpZmBLLmZmZYMzsNsMzMBGmlZGAgBA" },
    { buildName = "Mythic+/AoE", heroTree = "Totemic", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZwMYmxMzMbmxyYGAAAAAAAAAAsAbwMW0YbAMTwGAmlJzALLMzMDGzsNsMzMNLsMWGzMAAzA" },
    { buildName = "Delves", heroTree = "Totemic", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMjZGGYmZmZmZbmxyYAAAAAAAAAAgFYDmxiGbDgZC2AwsMZGYZxMzMDzYmthlZmJYZsMmZAAGA" },
}

-- Warlock - Affliction Hellcaller
BiSCompanionTalentData["Warlock_Aff_Hellcaller"] = {
    { buildName = "Raid Single target", heroTree = "Hellcaller", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAAzMzMzMjY2MwsNzMDz2AAAAmZMziZmxyMzMbmxMDAYGLwAziRjZAZ2ALzAAAAAAAAAjZD" },
    { buildName = "Raid Cleave", heroTree = "Hellcaller", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAgZmZmZmZEzmBmNzMDz2AAAAmZMziZmxyMzMLGmZAAzYDGYWMaMDIzCYZGAAAAAAAAMjZD" },
    { buildName = "Mythic+", heroTree = "Hellcaller", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAAzMzMzMjY2MMmNzMDz2AAAAmZMzyMjxyMzMLmxMDAYGLwAziRjZAZ2ALzAAAAAAAAgZYB" },
}

-- Warlock - Affliction Soul Harvester
BiSCompanionTalentData["Warlock_Aff_Soul Harvester"] = {
    { buildName = "Raid Single Target", heroTree = "Soul Harvester", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAAzMzMzMjY2MwsNzMDz2AAAAmZMzyMjxiZmZhZmZAAzM2WGYATwMsFYYbGAAAAAAAAMzMbA" },
    { buildName = "Raid Cleave", heroTree = "Soul Harvester", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAgZmZmZmZEzmBmNzMDz2AAAAmZMziZmxyMzMLGmZAAzYDGYWMaMDIzCYZGAAAAAAAAMjZD" },
    { buildName = "Mythic+", heroTree = "Soul Harvester", importCode = "CkQAAAAAAAAAAAAAAAAAAAAAAAzMzMzMjY2MMmNzMDz2AAAAmZMzyMjxyMzMLMzMDAYmxyyADYCmhtADbzAAAAAAAAgZYB" },
}

-- Warlock - Demonology Soul Harvester
BiSCompanionTalentData["Warlock_Demo_Soul Harvester"] = {
    { buildName = "Raid Single Target", heroTree = "Soul Harvester", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAAMzMzMjYWMMmtZmZYWGAAAAAAAAAAzMW2GYADYG2CZsxMmhtZmZZZMzMjxMGmZGjhZmBAAA" },
    { buildName = "Raid Cleave", heroTree = "Soul Harvester", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAAMzMzMjYWMMmtZmZYWGAAAAAAAAAAzMW2GYADYG2CZsxYMjtxMbzYmZGjZMMzMzMzgZAAA" },
    { buildName = "Mythic+", heroTree = "Soul Harvester", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAAmZmZmZEzihxsZmZYWGAAAAAAAAAAzMW2GYADYG2CZsxYMjtxMbzYmZGjZMMzMzMzgZAAA" },
}

-- Warlock - Demonology Diabolist
BiSCompanionTalentData["Warlock_Demo_Diabolist"] = {
    { buildName = "Raid Single Target ", heroTree = "Diabolist", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAAmZmZmZEzmhxsZmZYWGAAAAAAAAAAzAGzYYBGYZ0CNswMmhtZmZZZMzMjxMGmZGjhZmBAAA" },
    { buildName = "Raid Cleave", heroTree = "Diabolist", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAAmZmZmZEzmhxsZmZYWGAAAAAAAAAAzAGzYYBGYb0CNswYMjtxMbzYmZGjZMMzMzMzgZAAA" },
    { buildName = "Mythic+", heroTree = "Diabolist", importCode = "CoQAAAAAAAAAAAAAAAAAAAAAAAmZmZmZEzmhxsZmZYWGAAAAAAAAAAzAGzYYBGYb0CNswMjZmtxMbmZmZGjZmBjZmxgZAAA" },
}

-- Warlock - Destruction Hellcaller
BiSCompanionTalentData["Warlock_Destro_Hellcaller"] = {
    { buildName = "Mythic+", heroTree = "Hellcaller", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAAmZmZmZEzmBmtZmZYWmNjxMzsYGjlZmBAAAAGmZbZmZZGLwAziRjZAMbxGGAAAAAAAzYMDAA" },
}

-- Warlock - Destruction Diabolist
BiSCompanionTalentData["Warlock_Destro_Diabolist"] = {
    { buildName = "Single Target", heroTree = "Diabolist", importCode = "CsQAAAAAAAAAAAAAAAAAAAAAAAmZmZmZEzmBmtZmZYWmNzwMzsYGjFzMAAAAwMzwyMzyMgxMGWIDsNsQjFMAAAAAAAGzMzAA" },
}

-- Warrior - Arms Colossus
BiSCompanionTalentData["Warrior_Arms_Colossus"] = {
    { buildName = "Mythic+", heroTree = "Colossus", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAghZmxMmZmHY2mtllxMAAAADmGMzyYGGLjZmxiZmxMDGGAAAAAAAmxsNYAbxAWMjhFYgZ0GNgFA" },
    { buildName = "Delves/Leveling/Open World", heroTree = "Colossus", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAghZmxMmxY2mtllxMAAAADmGGzyMzwYZMzM2MzMMDGGAAAAAAAmxsNGDYLzAWMjhFYgZ0GNgFA" },
}

-- Warrior - Arms Slayer
BiSCompanionTalentData["Warrior_Arms_Slayer"] = {
    { buildName = "Single Target Raid", heroTree = "Slayer", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAAMjZmxMmZ2mlllZGAAAADmGmZWMzwMGMjNzMDzwMMAAAAAAA8AjZZmZGgwYbbgFwAmhJkB2A" },
    { buildName = "Raid Multitarget", heroTree = "Slayer", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAAMjZmxMmHY2mlllZmBAAAYw0wMzyMzwMGMjNzMDGmhBAAAAAAgHYMLzMzAEGbbDsAGwMMhMwGA" },
    { buildName = "Mythic+", heroTree = "Slayer", importCode = "CcEAAAAAAAAAAAAAAAAAAAAAAghZmZmxMGWmtllZmBAAAYw0gZWYGmZZMzMWMzMmZwwAAAAAAAwDwsMzMDYLMW2GYDMgZYCZgNA" },
}

-- Warrior - Fury Slayer
BiSCompanionTalentData["Warrior_Fury_Slayer"] = {
    { buildName = "Single Target Raid", heroTree = "Slayer", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQjhZmNzMMjBzswMzMmhZYmttxYmZWwMmZmxMzsMM8AmZAAAQM22GYBMBzwEYwGA" },
    { buildName = "Multitarget Raid", heroTree = "Slayer", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQjhZmNzMMjBzswMzMmhZYmttZGzMzCmxMzMmZsMMYmZAAAQM22GYBMBzwEYwGA" },
    { buildName = "Mythic+", heroTree = "Slayer", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQjBzsZmhZMYmFmZmZmhZYmttZGzMzCmxMzMmZsMMYmZAAAQM22GYBMBzwEYwGA" },
}

-- Warrior - Fury 
BiSCompanionTalentData["Warrior_Fury_Mountain Thane"] = {
    { buildName = "Main Mythic+", heroTree = "Mountain Thane", importCode = "CgEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMaMwsMmhxyAzCzMzMzMjhZW2mZMzMbYmZGDzMzywgZMAAAIMwGssY0YGQmFYsAA" },
}

-- Warrior - Protection Mountain Thane
BiSCompanionTalentData["Warrior_Prot_Mountain Thane"] = {
    { buildName = "Raid Single Target", heroTree = "Mountain Thane", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAA02AAAAwYGzMzMDzsZmZZYGjRjZZMjlxyADbzMDGzDMMAAAAAAwyAAMjNADsBLLGNmBwsEjNMzM" },
    { buildName = "Raid Single Target with Cleave", heroTree = "Mountain Thane", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAA02AAAAwYmhZmZmZmNzMLDzYMaMLjZYsMww2Mzgx8ADDAAAAAAsMAAzYDwAbwyiRjZAMLxMbMjB" },
    { buildName = "Mythic+", heroTree = "Mountain Thane", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAAkBAAAgxMMzMzMzMbmZWGMGjGzyYGGLjZmhtZmxMwwAAAAAAALDAwM2AMwGssY0YGAzSY2YGzA" },
}

-- Warrior - Protection Colossus
BiSCompanionTalentData["Warrior_Prot_Colossus"] = {
    { buildName = "Mythic+", heroTree = "Colossus", importCode = "CkEAAAAAAAAAAAAAAAAAAAAAA0yAAAAwYGzMzMDzsZmZZwYMaMLjZYsMmZGWmZGzADDAAAAAAsMAAzYBAsZGDLkBmhFaYWYGzA" },
}

-- Hunter - Beast Mastery Dark Ranger
BiSCompanionTalentData["Hunter_BM_Dark Ranger"] = {
}

-- Hunter - Beast Mastery Pack Leader
BiSCompanionTalentData["Hunter_BM_Pack Leader"] = {
    { buildName = "Single Target", heroTree = "Pack Leader", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsBzohG2AAAAAAwwYMzyMzwMmBLDzMjZmZmJzYGzMmZYmhhxYGDMjZbZGmNAAAAAAYGA" },
    { buildName = "AoE No Multishot", heroTree = "Pack Leader", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsBzohG2AAAAAAwYGjZWmZGmxMYZYmZMmZmJzYGzMmZYmhhxYGDjZMbLzgNAAAAAAYGA" },
    { buildName = "AoE Multishot", heroTree = "Pack Leader", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsBzohG2AAAAAAwYGz8AWmZGmZMYZGzMjxMzMZGzYmxMDzMMMGzYYMjZbZGsBAAAAAAzA" },
}

-- Hunter - Survival (Parck Leader)
BiSCompanionTalentData["Hunter_Survival_Pack Leader"] = {
    { buildName = "Single Target", heroTree = "Pack Leader", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMG2gFYGGawyMzsMjZmxMzYMMGmZmZMbDAAAAAAAaGzYmZmZYGMMGmZghZWmZYBAAAAAYAA" },
    { buildName = "Mythic+ / Raid AOE", heroTree = "Pack Leader", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWgFYGGawyMzsMzMzMmxYGzMGjxMjZDAAAAAAAaGzYGzMDzghxwMDzywMLzgNAAAAAgBA" },
    { buildName = "Delves", heroTree = "Pack Leader", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWgFYGGawyMzsMzMzMmxYGzMGjxMjZDAAAAAAAaGzYGzMDzghxwMzYWGmxMYDAAAAAYAA" },
}

-- Hunter - Survival (Sentinel)
BiSCompanionTalentData["Hunter_Survival_Sentinel"] = {
    { buildName = "Single Target", heroTree = "Sentinel", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMGYgtxox2AY2AbzMz2MmZGzMjBGDzMzMzsNAAAAAAAoZMjZmZmhZYGGDzMwwMLzgNAAAAAgBA" },
    { buildName = "Raid/AOE", heroTree = "Sentinel", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMGYglxox2AY2AbzMzyMzMzYmZMjxYMGzMmNAAAAAAAoZMjZMzMMDzwYYmZMGmxMDbAAAAAAAA" },
    { buildName = "Mythic+ / AOE", heroTree = "Sentinel", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMGYglxoxyAY2AbzMWmZmZmZYMzMzYMGzMmFAAAAAAAoZMjZmZmhZwwYYmhZZYmlZAAAAAAgBA" },
    { buildName = "Delves", heroTree = "Sentinel", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMGYglxoxyAY2AbzMWmZmZmZMjZmxYMGzMmFAAAAAAAoZMjZMzMMDzwYYmZMGmxMYDAAAAAYAA" },
}

-- Hunter - Marksmanship (Sentinel)
BiSCompanionTalentData["Hunter_Marks_Sentinel"] = {
    { buildName = "Raid Single Target", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwADsNGN2GQmNsBAAAAAAAAAAAAAzYGzYmZGzoZGjhZGGDziZw2MmZw2mZmZmZ5BmZYMzYZzwygZA" },
    { buildName = "Raid Single Target with Cleave", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwADsNGNWGQmNsBAAAAAAAAAAAAAzYGzYmZYGNzYMMzwYYWWmBbjhZmltttZGDMzMmZmZWYMLDzM" },
    { buildName = "Mythic+", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwADsNGNWGQmNsBAAAAAAAAAAAAAzYGzYmZYGNzYMMzwYYWWmBbjhZmltttZGDMzMmZmZWYMLDzM" },
    { buildName = "Delves Build", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwADsNGNWGQmNsBAAAAAAAAAAAAAzYGzYmZYGNzYMMzwYYWWmBbjhZmltttZGDMzMmZmZWYMLDzM" },
}

-- Hunter - Marksmanship (Dark Ranger)
BiSCompanionTalentData["Hunter_Marks_Dark Ranger"] = {
    { buildName = "Raid Single Target", heroTree = "Dark Ranger", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAYstNwAmgZhtAzCAAAAAAAAAAAAAAzYGzMzMzYGZGjhZGYYmlZGMzY2wsZGzMzsMzMMmZmllxglB" },
    { buildName = "Raid Single Target with Cleave", heroTree = "Dark Ranger", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAYMbDMgJY2YJwsAAAAAAAAAAAAAAzYGzYmZGzIzYMMzwYYWWmBbDzYsssZmZmZWMzwYmZW2MsMYG" },
    { buildName = "Mythic+", heroTree = "Dark Ranger", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAYMbDMgJY2YJwsAAAAAAAAAAAAAAzYGzYmZGzIzYMMzwYYWWmBbDzYsssZmZGziZGGzMzymhlhZG" },
    { buildName = "Delves Build", heroTree = "Dark Ranger", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAYMbDMgJY2YJwsAAAAAAAAAAAAAAzYGzYmZGzIzYMMzwYYWWmBbDzYsssZmZGziZGGzMzymhlhZG" },
}

-- Druid - Balance - Elune's Chosen
BiSCompanionTalentData["Druid_Balance_Elune's Chosen"] = {
    { buildName = "Raid Single Target", heroTree = "Elune's Chosen", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALUmtMGzMwDYWYZmZAzMLzsMzyM2MzMmZWMLjxMzAWYAGLbzshxsNCMBAAAYxMzMAbGYA" },
    { buildName = "Raid Multi", heroTree = "Elune's Chosen", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALUmtMGzMwDYWYZmZAzMLmlZWmZ2mZmxMziZZMmBbYhBYssNzGGz2IwEAAAgFzMzAsZgB" },
    { buildName = "Mythic+", heroTree = "Elune's Chosen", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALUmtGGzMAzCLzMzCDjFzyMLzMbzMzMzMLmlxwgNswAMW2mZDjZbEYCAAAwiZGDwmxMG" },
}

-- Druid - Balance - Keeper of the Grove
BiSCompanionTalentData["Druid_Balance_Keeper of the Grove"] = {
    { buildName = "Mythic+", heroTree = "Keeper of the Grove", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALUmtwYmBYWYZmZWYYwsMzyMzyYmZmZWMLjZMDbYhBYAW2GbYamZZEAAAgNzMzAsZMjB" },
    { buildName = "Delve Team", heroTree = "Keeper of the Grove", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALUmtmxYmBYWYZmxCDDzsMz2MzCzMzMzyMmZYM2wCDwAstNWw0Mz2IAAAAbMzMAbGzYA" },
}

-- Druid - Feral (Druid of the Claw)
BiSCompanionTalentData["Druid_Feral_Druid of the Claw"] = {
    { buildName = "Raid Single Target", heroTree = "Druid of the Claw", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmZjxsYmxMz2s9AGbzMzYmZAAAAAAWCmFDMzomxsMzyMzYMjZAAAAAAgBAAAAoZWmlZmtBEYBMDALMYA" },
    { buildName = "Raid Cleave", heroTree = "Druid of the Claw", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmZb2MzCzMzMbzGjtZmZmHYmBAAAAAYJY2MGzgaGzyYZmZWGzYAAAAAAAAAAAACAmtZWa2mZZDmZAYhZYA" },
    { buildName = "M+", heroTree = "Druid of the Claw", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmZb2mZWYmZmZzGsNzMz8AzMAAAAAALBzmxYGUzYWGLzMzyYGDAAAAAAYAAAAAamlZZmZbABWAzAwCzwA" },
    { buildName = "Delves", heroTree = "Druid of the Claw", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmZb2mZWYmZmZzGsNzMz8AzMAAAAAALBzmxYGUzYWGLzMzyYGDAAAAAAYAAAAAamlZZmZbABWAzAwCzwA" },
}

-- Druid - Feral (Wildstalker)
BiSCompanionTalentData["Druid_Feral_Wildstalker"] = {
}

-- Druid - Guardian Elune's Chosen
BiSCompanionTalentData["Druid_Guardian_Elune's Chosen"] = {
    { buildName = "Mythic+", heroTree = "Elune's Chosen", importCode = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzYmhZWmZgZMzYxMzwsYZAbGGNRmZWmZbmZWGzYAAAAAAwwYALbzshxsMAmCAAAsZMDALGYA" },
}

-- Druid - Guardian Druid of the Claw
BiSCompanionTalentData["Druid_Guardian_Druid of the Claw"] = {
    { buildName = "Raid Single target", heroTree = "Druid of the Claw", importCode = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzYMzMzyMMmZwYxMMzsYZAgRTmmZmlZ2mZGjZYAAAAAAYMzAAAAgamtZZmZZAAswYAYxMYA" },
    { buildName = "Raid Cleave", heroTree = "Druid of the Claw", importCode = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzYMzMzyMMmZwYxMMzsYZAgRTmmZmlZ2mZGjZYAAAAAAYMzAAAAgamtZZmZZAAswYAYxMYA" },
}

-- Druid - Restoration Wildstalker
BiSCompanionTalentData["Druid_Resto_Wildstalker"] = {
    { buildName = "Raid Infinity bloom", heroTree = "Wildstalker", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAsNmZGLbjZmxiZb4BYstNz2itZAAAAAAAAAAAAsZoZjx0MDwsMzyMzwwMAAAAAgBAMAAQAAAz2MbNbzsZjxMDwshRD" },
    { buildName = "Mythic+ - Rejuv", heroTree = "Wildstalker", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAsxMzYZbmZmxiZbMYstMzyitZAAAAAAAAAAAAsNIbwkhZmxsYWmZsMjZmBAAAAAAAAAABAAMbzs1sNziNGzAMzCoB" },
    { buildName = "Mythic+ - Lifebloom", heroTree = "Wildstalker", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAsxMzYxMzMzsY2GDGLLjtFbzAAAAAAAAAAAAYbQ2gJDzMjZxsMzYZGzMDAAAAAAAMAAQAAAz2MbNbzsYjxMwwsAaA" },
    { buildName = "Delves", heroTree = "Wildstalker", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAsxMzYjZmZGmtZmHAzyywitZAAAAAAAAAAAAsNoZDzkxMMmFzyMzsYMzAAAAAAAAYAAIAAgZbmtmtZWsBzAGziBN" },
}

-- Druid - Restoration Keeper of the Grove
BiSCompanionTalentData["Druid_Resto_Keeper of the Grove"] = {
    { buildName = "Raid - Ramping Rejuv", heroTree = "Keeper of the Grove", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAsNmZGLbjZmxiZDPAjttZWWsNDAAAAAAAAAAAgNDNbMmmZAmlZWmZGGmBAAAAAMAAGwyyYBTzMLDAAQALMmZAzshRD" },
}

-- Evoker - Augmentation Chronowarder
BiSCompanionTalentData["Evoker_Augmentation_Chronowarder"] = {
    { buildName = "Raid Single Target", heroTree = " Chronowarder", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgxMbzMzMMzwMmZmZGzAAAAAAMAAYmBwYM1wMzAAAAgZMz2YmZbMzYYGGYMLWYBGYGGaELYMA" },
    { buildName = "Raid Cleve", heroTree = " Chronowarder", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgxMbzMzMMzwMLzYmZMDAAAAAwAAgZGAjxUDzMDAAAAmxMbjZmtxMjhZYgxsYhFYgZYoRsgxA" },
    { buildName = "Mythic+ / AOE", heroTree = " Chronowarder", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgZZmtZmZGmBzsMjZmxMbAAAAAgBAAzMwwYoGmZGAAAAMzMz2YmZbMzYYGGYMLWYBGYGGaELYMA" },
}

-- Evoker - Augmentation Scalecommander
BiSCompanionTalentData["Evoker_Augmentation_Scalecommander"] = {
    { buildName = "Raid Single Target", heroTree = " Scalecommander", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgxMbzMzMMGmxMzMzYGAAAAAgBAAzMAGjpGmZGAAAAMjZ2GzMbjZGDzsZMYBWGDjtBwMRshxA" },
    { buildName = "Raid Cleave", heroTree = " Scalecommander", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgxMbzMzMMGmZZGzMjZAAAAAAGAAMzAYMmaYmZAAAAwMmZbMzsNmZMMzmxgFYZMM2GAzExGGD" },
    { buildName = "Raid multi", heroTree = " Scalecommander", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgxMbzMzMMGmZZGzMjZAAAAAAGAAMzAYMmaYmZAAAAwMmZbMzsNmZMMzmxgFYZMM2GAzExGGD" },
    { buildName = "Mythic+", heroTree = " Scalecommander", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAgZZmtZmZGGYmlZMzMmZDAAAAAMAAYmBGGD1wMzAAAAgZmZ2GzMLjZGDzsZMYBWGDjtBwMRshxA" },
}

-- Evoker - Devastation Scalecommander
BiSCompanionTalentData["Evoker_Devastation_Scalecommander"] = {
    { buildName = "Raid", heroTree = " Scalecommander", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMzAzwMYADGz0YmZysNzyMmZmZGzsNDYGzsNmZWGzADMGsALjRjtBkZQwGG" },
    { buildName = "Raid Single Target", heroTree = " Scalecommander", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMzMYmNzgBMYMTzYmJz2YZYmZmZMz2MgZMz2YmZZMDMwYwCsMGN2GQmBBbYA" },
    { buildName = "Mythic+", heroTree = " Scalecommander", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmZGYGmxMDmZmxw0wMTmtZWmxMzMzYmlZAzYsNmZMmBGgBLwyY0YZAZGEshZA" },
    { buildName = "Delves", heroTree = " Scalecommander", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMzAzwMDDmZww0MmZysNzyMmZmZGzsNDYmZswMz2YGYAGsALjRjtBkZQwGmB" },
}

-- Evoker - Devastation Flameshaper
BiSCompanionTalentData["Evoker_Devastation_Flameshaper"] = {
    { buildName = "Raid", heroTree = " Flameshaper", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzYmhZmFzYmBMYMTzYmJjxyMzMzwYmlZAzYmNmZWmZgZgZMDsAWAzwEYJYZYA" },
    { buildName = "Raid Single Target", heroTree = " Flameshaper", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzYmhZmFzYmBMYMTzYmJjxyYmZGmHYmlZAzYmNmZWmZgZgZMDsAWAzwEYJYZYA" },
    { buildName = "Mythic+", heroTree = " Flameshaper", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGzYmxsMzYmBmxYYaYmpZ2GLDGGjZWmBMzMz2YmxYGMDMjZgFwGYGmALBLDD" },
    { buildName = "Mythic+ Scintillation", heroTree = " Flameshaper", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGzYmxsMzYmBmxYYaYmJz2YZwMDjZWmBMzMz2YmxYGMDMjZgFwGYGmALBLDD" },
}

-- Evoker - Preservation Flameshaper
BiSCompanionTalentData["Evoker_Preservation_Flameshaper"] = {
    { buildName = "Raid Echoshaper", heroTree = " Flameshaper", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAYmZMbzghZGzixMbjZGAAgZMjhxYGhZAAAAmZmJzsNzYWmZGAMjZgFwCYGmQ2gNDD" },
}

-- Evoker - Preservation Chronowarden
BiSCompanionTalentData["Evoker_Preservation_Chronowarden"] = {
    { buildName = "Raid Echowarden", heroTree = " Chronowarden", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZMbDMmZGz2MmZbADAAYghZGzMxMDAAAwMzMNjFzMjZmBAgxsZhFYgZ0QDGLwM" },
    { buildName = "Raid Big Blossoms", heroTree = " Chronowarden", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAYmZ2GzDMzMmBzCmZzMzYAAwMjZMMGzImZAAAAmZmJzYmxsNzAADMmNLsADMjGaALwA" },
    { buildName = "Mythic+ Echowarden", heroTree = " Chronowarden", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ2GDwMzYWMzMbDYAAwMjZMzMGmJGzAAAAbzMzkx2MjxYGAAGzmFWgBmRDNYsAD" },
    { buildName = "Delves", heroTree = " Chronowarden", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZMbDMmZGz2MmZbADAAYghZGzMxMDAAAwMzMNjFzMjZmBAgxsZhFYgZ0QDGLwM" },
}
BiSCompanionTalentData["Mage_Arcane_Spellslinger"] = arcaneSpellslinger1215
BiSCompanionTalentData["Mage_Arcane_Sunfury"] = arcaneSunfury1215
BiSCompanionTalentData["Mage_Fire_Sunfury"] = fireSunfury1215
BiSCompanionTalentData["Mage_Frost_Spellslinger"] = frostSpellslinger1215
BiSCompanionTalentData["Mage_Frost_Frostfire"] = frostFrostfire1215
BiSCompanionTalentData["Mage_Fire_Frostfire"] = {}
BiSCompanionTalentData["Warlock_Aff_Soul Harvester"] = afflictionSoulHarvester1215
BiSCompanionTalentData["Warlock_Aff_Hellcaller"] = afflictionHellcaller1215
BiSCompanionTalentData["Warlock_Demo_Diabolist"] = demonologyDiabolist1215
BiSCompanionTalentData["Warlock_Demo_Soul Harvester"] = demonologySoulHarvester1215
BiSCompanionTalentData["Warlock_Destro_Hellcaller"] = destructionHellcaller1215
BiSCompanionTalentData["Warlock_Destro_Diabolist"] = destructionDiabolist1215
