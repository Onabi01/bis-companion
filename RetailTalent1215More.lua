-- Midnight 12.1.5 talent imports from current Method guides.
-- An empty table means the guide exposed no build for that hero tree.
BiSCompanionTalentData = BiSCompanionTalentData or {}

-- https://www.method.gg/guides/havoc-demon-hunter/talents
BiSCompanionTalentData["DH_Havoc_Aldrachi Reaver"] = {
    { buildName = "Aldrachi Reaver - Raid", heroTree = "Aldrachi Reaver", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYgZmZ2mxMzMmZmMmZAAAAAAAzmxsNDzMz2MzYZmxMWmZYmlZ2mBDjlNmkxMjhFAAAAAAAwMDwAAAAwA" },
    { buildName = "Aldrachi Reaver - Mythic+", heroTree = "Aldrachi Reaver", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYGMzMz2MmZmxMzkxMDAAAAAAY2MmtZYmZ2mZGLzMmhZGmZZmtZwwYbjJZMzYYBAAAAAAAMzAMAAAAM" },
}
BiSCompanionTalentData["DH_Havoc_Fel-Scarred"] = {
    { buildName = "Fel-Scarred - Single Target", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYAzMz2MmZmxMzkxMDAAAAAAY2MmtZYmxyMzYZm5BmZWmZWGjB2mFzYY200wMjhNAAAAAAAAmZwAAAAwA" },
    { buildName = "Fel-Scarred - Raid Cleave (Recommended):", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZGzMz2MmZmxMzkxMDAAAAAAY2MmtZYmBPwMWmZegZYmxYWGYbWMjhZTTjZmxwGAAAAAAAAzMYAAAAYA" },
    { buildName = "Fel-Scarred - Mythic+ (Recommended)", heroTree = "Fel-Scarred", importCode = "CEkAAAAAAAAAAAAAAAAAAAAAAYmZGzMz2MmZmxMzkxMDAAAAAAY2MmtZYmBmxyMzDMDzMGzyAbziZMMbaaMzMG2AAAAGAAAAzMYAAAAYA" },
}

-- https://www.method.gg/guides/vengeance-demon-hunter/talents
BiSCompanionTalentData["DH_Vengeance_Aldrachi Reaver"] = {
    { buildName = "Aldrachi (Raid)", heroTree = "Aldrachi Reaver", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZMzMjMzMYWMzMjBjZGzYGzMDzMzM2MzsNGAAAAwsNDGGLLMhhZmxCAAAAGMAEgZGgBAAAwA" },
    { buildName = "Aldrachi Reaver (Mythic+)", heroTree = "Aldrachi Reaver", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZMMzkZmB2MjZwMjZGzMzMzYwMzM2YmtxwAAAAwsNDGGLLMhhZmZWAAAAwADgAMzAMAAAAG" },
}
BiSCompanionTalentData["DH_Vengeance_Annihilator"] = {
    { buildName = "Annihilator (Raid)", heroTree = "Annihilator", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZMzMjMzMYWMzMjBjZGzYGzMDzMzM2MzsNGAAAAAAAIgZmxGAAAAGMmZmZ2abmZGAYAAAAMA" },
    { buildName = "Annihilator (Mythic+)", heroTree = "Annihilator", importCode = "CUkAAAAAAAAAAAAAAAAAAAAAAAAMjZmZMMzkZmB2MjZwMjZGzMzMzYwMzM2YmtxwAAAAAAAIgZmZ2AAAAwAzMzMzWbzMzAADAAAgB" },
}

-- https://www.method.gg/guides/balance-druid/talents
BiSCompanionTalentData["Druid_Balance_Keeper of the Grove"] = {
    { buildName = "Spread Cleave - Keeper of the Grove", heroTree = "Keeper of the Grove", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMD8AmFzMzMYYGjZWGbzYGbsMzyYmZGLYYAGgltxGmmZWGBAAAYzMzMzgNDMmBwMDAMA" },
}
BiSCompanionTalentData["Druid_Balance_Elune's Chosen"] = {
    { buildName = "Elune’s Chosen - Single Target", heroTree = "Elune's Chosen", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMYYGjZWmhxMWYZmlZGjZ2wAgx2yMDGz2IwEAAAgFzMzMD2MMGzAAYmBLDA" },
    { buildName = "Stacked Cleave - Elune’s Chosen", heroTree = "Elune's Chosen", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNjxMDwswMzMYYGjZWmZxMzYhlZWGjZGLYYAGbbzMYMbjATAAAAWMzMzMYzYGjZAAMzADA" },
    { buildName = "Mythic+ - Elune’s Chosen", heroTree = "Elune's Chosen", importCode = "CYGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWoMbNMmZgxsMzMzMLMgxMLzsYMzswyMLjxMjNMAYstNzgxsNCMBAAAYhZmZGsZMjxAAwMDWGA" },
}

-- https://www.method.gg/guides/feral-druid/talents
BiSCompanionTalentData["Druid_Feral_Wildstalker"] = {
    { buildName = "Wildstalker", heroTree = "Wildstalker", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAwYMDGzMjxstMPwyYbmZGzMDAAAALBzGMmZUzYWmZmZGjZMDAAAAAAwAAAAoZWmlZmZmlZWaWmZZDMzAsYGMAAmZwMbYA" },
    { buildName = "Wildstalker", heroTree = "Wildstalker", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2YmZmxY2M2mZZGzMmZAAAAYJY2MMmZUzYWMzMzsMmhBAAAAAAYAAAAEAMLzs0sMzyGYmBYxMYAAMzAgB" },
}
BiSCompanionTalentData["Druid_Feral_Druid of the Claw"] = {
    { buildName = "Druid of the Claw", heroTree = "Druid of the Claw", importCode = "CcGADBD3hSPCL9Y9gz68WcKvMAAAAAAwghxYmZmxsxDsMz2MzMmZGAAAAWCmNYMzomxsMzMzMGzYGAAAAAAgBAAAQzsMLzMzACsAmZAWMDGAAAzshB" },
    { buildName = "Druid of the Claw Convoke + Rake", heroTree = "Druid of the Claw", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmZ2MzMzMGzmx2YbGzMmZAAAAYJY2M8AmZUzYWMzMzsMm5BMAAAAAAADAAAgmZZWmZmBEYBmZGgFGMAAAmZDD" },
    { buildName = "Druid of the Claw Incarn + Swipe", heroTree = "Druid of the Claw", importCode = "CcGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZ2YGzMzMzmx2MLzYm5BmZAAAAYJY2MMmZUzYWMzMzsMmhBAAAAAAYAAAA0MLzyMzMgALgZGgFzgBAAwMbYA" },
}

-- https://www.method.gg/guides/guardian-druid/talents
BiSCompanionTalentData["Druid_Guardian_Druid of the Claw"] = {
}
BiSCompanionTalentData["Druid_Guardian_Elune's Chosen"] = {
    { buildName = "Elune’s Chosen (Mythic+)", heroTree = "Elune's Chosen", importCode = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmxsYmZMziZxMmZZZgZzwoJamZWmZmZmlxMMAAAAAgZsZALbzMYMLDgpAAAAbYmHAYxMYALWAYmBwA" },
    { buildName = "Elune’s Chosen (Raid)", heroTree = "Elune's Chosen", importCode = "CgGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgZmhFzYMzmZZGMLLDMbMGNRzMzyMzMzYMjZAAAAAAzYZGwy2MDGz2AYKAAAwGmxAWMDGwiltBYmBwA" },
}

-- https://www.method.gg/guides/restoration-druid/talents
BiSCompanionTalentData["Druid_Resto_Keeper of the Grove"] = {
    { buildName = "Raid: Keeper of the Grove", heroTree = "Keeper of the Grove", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAMjxMbzMjZmxsN8AzYGGbMDAAAAAAAAAAWG0sZGTzMGGzyMzMzwwMAAAAAAAAw2yYDTzMLDAAQALMmZwMDQzAgZGAwA" },
    { buildName = "Mythic+: Keeper of the Grove", heroTree = "Keeper of the Grove", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8AMzsYsYbGAAAAAAAAAAsYoZbGmmBwsYmZmZxwDMAAAAAMAAzA22GLYamZZAAACYhZmZGmZ2ANDAmZAADA" },
}
BiSCompanionTalentData["Druid_Resto_Wildstalker"] = {
    { buildName = "Raid: Wildstalker (Best)", heroTree = "Wildstalker", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAYMmZZmZMzMmthHYYmNjtxMAAAAAAAAAAYZQzmZMNzYYMLzMzMDDzAAAAAAAAAAIAAgZbmlmtZ2sxYmBmBoZAAmZAYA" },
    { buildName = "Mythic+: Wildstalker (Best)", heroTree = "Wildstalker", importCode = "CkGAAAAAAAAAAAAAAAAAAAAAAMMmZZMjZmxsN8ADzsYsZbGAAAAAAAAAAsMoZbGmmZMwsYmZmZZGegBAAAAgBAYGAACAAY2mZrZbmFbMzMwMzCoZAAmZAYA" },
}

-- https://www.method.gg/guides/beast-mastery-hunter/talents
BiSCompanionTalentData["Hunter_BM_Dark Ranger"] = {
    { buildName = "Dark Ranger Single Target / Raid", heroTree = "Dark Ranger", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAYzsNwAGwMsBZsAAgZMjZWMDzYmxMMzYYGzMjZMDzMjZMDGaGAAAAwMAAAMzMzgZGQYYWAbDAD" },
    { buildName = "Dark Ranger AoE / Mythic+", heroTree = "Dark Ranger", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAYzsNwAGwMsBZsAAgZGzMziZYGmxMjZmZYGzMjZmZsNzMMmhlhmBAAAAMDAAAzDMmZYmBEwsA2GAA" },
}
BiSCompanionTalentData["Hunter_BM_Pack Leader"] = {
    { buildName = "Pack Leader Single Target / Raid (Recommended)", heroTree = "Pack Leader", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsAzwQDbAAYGGzsMzwMmZYYmxYmxMzYmZGmxYGzgx0MAAAAgZAAAYMzMDYmNCDzCYbAYA" },
    { buildName = "Pack Leader AoE / Mythic+ (Recommended)", heroTree = "Pack Leader", importCode = "C0PAAAAAAAAAAAAAAAAAAAAAAAMmxwCsBzwQDbAAYGPwMzsMzwMzMjZGMzYmhZGzMzYbmZYMDLDNDAAAAAAAAmHYMzAmZjAmFw2AwA" },
}

-- https://www.method.gg/guides/marksmanship-hunter/talents
BiSCompanionTalentData["Hunter_Marks_Sentinel"] = {
    { buildName = "Sentinel Single Target / Raid (Recommended)", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGzYZAMD2AAAAAAAAAzYGzwMmZGzgx0MGM2WmZmZmZmZmFmZZwMAAg5BmZGDgZajhBYjZ2mxA" },
    { buildName = "Sentinel Cleave / Raid (Recommended)", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwCMwMGzYZAMD2AAAAAAAAAzYGzwMmZGzgx0MGMbbbzMzMzMzMzCzsMMDAAw8AzMDAmpNGGgNmZbGD" },
    { buildName = "Sentinel AoE / Trick Shots (Recommended)", heroTree = "Sentinel", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAwGMwMGNWGAzgNAAAAAAAAwMmZmhZMzMmBjpZMYW22mZmZmZmZmFmZZYGAAg5BGzAgZabDGgNmZbGD" },
}
BiSCompanionTalentData["Hunter_Marks_Dark Ranger"] = {
    { buildName = "Dark Ranger Single Target / Raid", heroTree = "Dark Ranger", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAmgZYbAzCAAAAAAAAYGzYGmxMzYGMmmxgx2yMzMzMzMzswMLDGAAg5BmZGzMzACDDwGzsNjB" },
    { buildName = "Dark Ranger AoE / Mythic+", heroTree = "Dark Ranger", importCode = "C4PAAAAAAAAAAAAAAAAAAAAAAYzsMwAmgZYLwsAAAAAAAAAmxMzMMjZmxMYMNjBzymZMzMzMzMLMzywMAAAzDMmxMzMgsBDwGzsNjB" },
}

-- https://www.method.gg/guides/survival-hunter/talents
BiSCompanionTalentData["Hunter_Survival_Sentinel"] = {
    { buildName = "Sentinel Single Target", heroTree = "Sentinel", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWgNYGGawyMmZGzMLDAAAAAAzYGzssNjxMmBPgpZAAAAGAMjllZmZxYmxYmZAmZDYYMM2MAA" },
    { buildName = "Sentinel AoE", heroTree = "Sentinel", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMWgBmxYGLDgZC2mZmZmZMbzDAAAAAAYGzMzYbGjZMDGTzAAAAMAwYZZmxCmZmxYmBgZsBGjZmNDA" },
}
BiSCompanionTalentData["Hunter_Survival_Pack Leader"] = {
    { buildName = "Pack Leader Single Target", heroTree = "Pack Leader", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWIbwMM0glZMzMmZWGAAAAAAmxMmZZbGjZMDeATzAAAAMAYGLLzMzixMjxMDgZ2AmFjhxmBA" },
    { buildName = "Pack Leader AoE", heroTree = "Pack Leader", importCode = "C8PAAAAAAAAAAAAAAAAAAAAAAMgxMGWILwMM0gFzMzMzMWGAAAAAAmxMzMLbzYMjZwYaGAAAgBAPwYZZm5BWYmZwYMgZ2AYGjZmNDA" },
}

-- https://www.method.gg/guides/brewmaster-monk/talents
BiSCompanionTalentData["Monk_BM_Master of Harmony"] = {
    { buildName = "Raid Defensive (Master of Harmony)", heroTree = "Master of Harmony", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAgZbzYGGz2M2YmZMAAAAAAALLYEzMwMM2MjxMzMDz2YmxMLYZb22mthZBAAWmlplZbmlBAACghNwMDYaMAAgB" },
    { buildName = "Mythic+ (Master of Harmony)", heroTree = "Master of Harmony", importCode = "CwQAQnG51S19isUJoJoTeJ/IKDAAAgZbzYGGzyMzGzMjBAAAAAAYZBzEzMwMM2MMmZmZY2YmxYZYZ7BW2mNMLAAwysMtMbzsMAAz2s0MzMbMsBmZmZYaMAAgB" },
}
BiSCompanionTalentData["Monk_BM_Shado-Pan"] = {
    { buildName = "Raid Standard / Defensive (Shado-pan) - Recommended", heroTree = "Shado-Pan", importCode = "CwQAAAAAAAAAAAAAAAAAAAAAAAAAAwMbbGzwYWmxGzMjBAAAAAAYZBzEzMwMMzGDmZmZY2GmxMLPALbPwy2sNmBAAshAAAMbzSzMzsxwGAzMMNGAAwA" },
    { buildName = "Raid Advanced / Offensive (Shado-pan)", heroTree = "Shado-Pan", importCode = "CwQAQnG51S19isUJoJoTeJ/IKDAAAwMLbGzYGWmxGmZMAAAAAAALLYEzMwMM2MjxMzMDz2YmxMLYZz22YGzCAAsNLTLz2MLDAwsNLNzMziZYDMzMzw0YAAAD" },
    { buildName = "Mythic+ Standard (Shado-Pan) - Recommended", heroTree = "Shado-Pan", importCode = "CwQAQnG51S19isUJoJoTeJ/IKDAAAgZbzYGGzyMzGzMjBAAAAAAYZBzEzMwMM2MMmZmZY2YmxYZYZ7BW2mNMLAAwGCAAwsNLNzMzGDbAMzw0YAAAD" },
}

-- https://www.method.gg/guides/mistweaver-monk/talents
BiSCompanionTalentData["Monk_MW_Conduit of the Celestials"] = {
    { buildName = "Raid (Conduit of the Celestials) - Preferred", heroTree = "Conduit of the Celestials", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghx2MwmFzYmZbGbYmZYmlttZGLMjmxMgBDGWmZmZYWGMYxEAAAAABYxyMLz2MDAAMgBYGwYYsMZMDA" },
    { buildName = "Raid (Conduit of the Celestials - Sheilun's Gift", heroTree = "Conduit of the Celestials", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAghx2MLDbWMjZmtZstsMjZYmlttZGLMjmxMgBDGWmZmZYWGMMLmAAAAAIALWmZZ2mZAAgBAYGwYYsIjZA" },
    { buildName = "Mythic+ (Conduit of the Celestials) - Preferred", heroTree = "Conduit of the Celestials", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMWmZZYxixMzsZsssND2Mz22yMjFmRzYGwgBjZZmZmhZbYGmlZCAAAAgAsYbmlZbmBAAAGgZADwiMmBA" },
    { buildName = "Mythic+ (Conduit of the Celestials) - Damage Oriented", heroTree = "Conduit of the Celestials", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgxMWGLjZz2MmZsYstsNjZ2Mz2yyMjFmRzYGwgBDLzMzMMbYGmlZCAAAAgAsYbmlZbmBAAAAMDYMwiMmBA" },
}
BiSCompanionTalentData["Monk_MW_Master of Harmony"] = {
    { buildName = "Raid (Master of Harmony)", heroTree = "Master of Harmony", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM2mB2sYGzMbzYDzMDzsstMzYhZ0MmBMYwYWmZmZY2GmhZZmAAAAAz20ysNzysBAAAAwMzAADwiMAA" },
    { buildName = "Mythic+ (Master of Harmony)", heroTree = "Master of Harmony", importCode = "C4QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM2mZZYxixMzsZsssND2Mzy2yMjFmRzYGwgBjZZmZmhZbYGmlZCAAAAMbTLz2MLzGAAAAAzMDAMALyAA" },
}

-- https://www.method.gg/guides/windwalker-monk/talents
BiSCompanionTalentData["Monk_WW_Conduit of the Celestials"] = {
    { buildName = "Conduit Single Target", heroTree = "Conduit of the Celestials", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYM2GmhlZmZbGAAAAAAAAAAAglhRzYGwAmxwMzMDz2wMMLzEAwiZ2mZGzMzMAAWMzysNmgAAwAYGgxyAxMzs5BA" },
    { buildName = "Conduit Mythic+", heroTree = "Conduit of the Celestials", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYMgxYZmx2MAAAAAAAAAAAALDz0MmhhBMMMzMzwsxMDzyDMBAswsNmxMzMDAgFzsMbjJIAgZMAmBYsMQMzMbG" },
}
BiSCompanionTalentData["Monk_WW_Shado-pan"] = {
    { buildName = "Shado-Pan Single Target", heroTree = "Shado-Pan", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYw2MmhlZGbzAAAAAAAAAAAAsMMaGzAGwMGmZmZY2GmhZZmAAWMz2MDzMzMAA2AgZZWamZmFAMwMDAjlBiB8B" },
    { buildName = "Shado-Pan Mythic+", heroTree = "Shado-Pan", importCode = "C0QAAAAAAAAAAAAAAAAAAAAAAMzYAMGbzMz2MAAAAAAAAAAAALDz0MmhhBMMMzMzwsNMDzyDMBAsYmtZmxMzMDAgNAYWmlmZmZBADMzAwYZgYAD" },
}

-- https://www.method.gg/guides/holy-paladin/talents
BiSCompanionTalentData["Paladin_Holy_Lightsmith"] = {
}
BiSCompanionTalentData["Paladin_Holy_Herald"] = {
}

-- https://www.method.gg/guides/protection-paladin/talents
BiSCompanionTalentData["Paladin_Prot_Templar"] = {
}
BiSCompanionTalentData["Paladin_Prot_Lightsmith"] = {
    { buildName = "Lightsmith (Mythic+)", heroTree = "Lightsmith", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsZsNLjZMzMzMLLjxYWmlZMAADAAAAAAaamZZmxMDzMbtBgBGwAbAAAEgZmltlWmZsYbBDAYGGDAmZAwMDyYB" },
    { buildName = "Lightsmith (Raid)", heroTree = "Lightsmith", importCode = "CIEAAAAAAAAAAAAAAAAAAAAAAsNDzyMzYmZmx2yYMLzithBAYAAAAAAQamZZmxMzYMbtBgBMwMYDAAgAMzsst0yMjFbbYAwYGGAwMDAmZQGL" },
}

-- https://www.method.gg/guides/retribution-paladin/talents
BiSCompanionTalentData["Paladin_Ret_Templar"] = {
    { buildName = "Templar Single Target (Raid)", heroTree = "Templar", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUmtZYmx2Y2GmZbGjxMDzYhtBAAkZm2mZ2mBAsBYAwYGGYGjZDbzghxMGMA" },
    { buildName = "Templar (Raid Cleave & Mythic+)", heroTree = "Templar", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAwoZbbmZWGzMzAAAAAAYmyYGmZsNmthZ2mxYMGmxGbAAAZmptZmtZAAbAGAMmhBmxMzGWmBDjZMYA" },
}
BiSCompanionTalentData["Paladin_Ret_Herald"] = {
    { buildName = "Herald of the Sun Single Target (Raid)", heroTree = "Herald", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAANbbzMzywMDAAAAAAzUmtZYmx2Y2GmZbGjxYYGLsNAMLz2Mzs1gAAAWAMAYMDDMjZmNgZmhxMGMA" },
    { buildName = "Herald of the Sun (Raid Cleave & Mythic+)", heroTree = "Herald", importCode = "CYEAAAAAAAAAAAAAAAAAAAAAAAAAAAwoZbbmZWGzMzAAAAAAYmyYGmZsNmthZ2mxYMGmxCbAYWmtZmZrBBAAsAYAwYGGYGzMbAzMDjZMYA" },
}

-- https://www.method.gg/guides/discipline-priest/talents
BiSCompanionTalentData["Priest_Disc_Voidweaver"] = {
    { buildName = "Raid Voidweaver (Recommended)", heroTree = "Voidweaver", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMmxywMYmhZzsNzMzMzMAAAAAAAAAAMDLzgZmZYGmBMNTzMYmBABwsNbbgxmBAgxYmxgZwMDmJYA" },
    { buildName = "Mythic+ Voidweaver", heroTree = "Voidweaver", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAADsYegZ2YMmZmhZDzMzMzMAAAAAAAAAAYGWmBzMzgxMD2MNTMYmBABwsNbbgxmBAgxMzMGMDmZwMNDzA" },
}
BiSCompanionTalentData["Priest_Disc_Oracle"] = {
    { buildName = "Raid Oracle", heroTree = "Oracle", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMGWmZmBDmZbmtZmZmxMDAAAAAAAAAgZYZGMzMDzwMgpZamBYmFMEGzyAMGsAAAjxMjBzAMzMTwA" },
    { buildName = "Mythic+ Oracle (Recommended)", heroTree = "Oracle", importCode = "CAQAAAAAAAAAAAAAAAAAAAAAAADsMDWmZMPwMwMbzYmZmZMzAAAAAAAAAAYGWmBzMzgxMD2MNTMAzsghwYWGgxgFAAYMzMjBzAMzMTwM" },
}

-- https://www.method.gg/guides/holy-priest/talents
BiSCompanionTalentData["Priest_Holy_Archon"] = {
    { buildName = "Raid Archon", heroTree = "Archon", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAgZmlxMjZmZYmZYZGmBAAAwMmlZwMzMMDzAYmaAgZWMTmFDAMGsZmZWA0MGjxwMz2yAMDMA" },
    { buildName = "Mythic+ Archon", heroTree = "Archon", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAgZzwYWGwMzMjZmZsMzMzAAAAYYWmhZmZGmxMD2wMFAYmNzkZzAAjBbGjFANjZGjBzstMADYA" },
}
BiSCompanionTalentData["Priest_Holy_Oracle"] = {
    { buildName = "Raid Oracle (Recommended)", heroTree = "Oracle", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAADAAAAAAYBmZWGzMmZMMDzsMzYGAAAAzYWmBzMzwMMDgZqBwMLYIMmlBYMwiZmZBQzYMGDzMAzMzAD" },
    { buildName = "Mythic+ Oracle (Recommended)", heroTree = "Oracle", importCode = "CEQAAAAAAAAAAAAAAAAAAAAAAwYAAAAAAAMzMmlxMjZGDzALzMzMAAAAGzsMzYmZmhhZGAzUAMzCGCjZbAGDsYMzCgmxMjxgZAmZmBGA" },
}

-- https://www.method.gg/guides/shadow-priest/talents
BiSCompanionTalentData["Priest_Shadow_Archon"] = {
    { buildName = "Archon Raid", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMz2MGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMgxMzMmNmZbZAmBDA" },
    { buildName = "Archon Pure Single Target", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDzAAAAAAAAAAAAwMLmxMbzMGz2MGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMgxMzMmNmZbZAmBDA" },
    { buildName = "Archon Delves", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDzAAAAAAAAAAAAwMLmxMbjxMzyMGzM2mBzMzMbIzYZjGgZAmZzMMbGAyYsAgZGgZmZmZ2YmtlBYGMA" },
    { buildName = "Archon Mythic+", heroTree = "Archon", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDzAAAAAAAAAAAAwMLmxMbjxMzyMGzw2MzYmZGbIzYxMNAzAMzmZY2MAkxYBAzMgxMzMmNmZbZAmBDA" },
}
BiSCompanionTalentData["Priest_Shadow_Voidweaver"] = {
    { buildName = "Voidweaver Raid", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAAMLmxMbzMMz2MzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYwYmZGz2YGMzgZwA" },
    { buildName = "Voidweaver Pure Single Target", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAAegZxMmZbmBz2MzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYwYmZGz2YGMzgZwA" },
    { buildName = "Voidweaver Entombed Sentinels", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMjZGAAAAAAAAAAAgxDMLmxYbmhZ2mZYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYwYmZGz2YGMzgZwA" },
    { buildName = "Voidweaver Delves", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMzyMzYmx2MYmZmZDZGLb0AMzMDAEgZb2WAzGDAMwMzMzMbMDmZwMYA" },
    { buildName = "Voidweaver Mythic+", heroTree = "Voidweaver", importCode = "CIQAAAAAAAAAAAAAAAAAAAAAAMMDDAAAAAAAAAAAAmZxMmZbmxMzyMzYG2mZGzMzYDZGLmpBYmZGAIAz2stAmNGAYwYmZGzGzgZGMDGA" },
}

-- https://www.method.gg/guides/assassination-rogue/talents
BiSCompanionTalentData["Rogue_Assassination_Deathstalker"] = {
}
BiSCompanionTalentData["Rogue_Assassination_Fatebound"] = {
}

-- https://www.method.gg/guides/outlaw-rogue/talents
BiSCompanionTalentData["Rogue_Outlaw_Fatebound"] = {
}
BiSCompanionTalentData["Rogue_Outlaw_Trickster"] = {
    { buildName = "Trickster Single Target", heroTree = "Trickster", importCode = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMmZmtZmZmZMmF4BmZbaZw2MAAAAAAbbzMzwMzMziZmZbAAAAYmBAjZxwQGYWYhWYjBYmBDMA" },
    { buildName = "Trickster Cleave", heroTree = "Trickster", importCode = "CQQAAAAAAAAAAAAAAAAAAAAAAAgx2MMzMjZmtZmZMzMzsAmZbaZw2MAAAAAAbbzMzwMzMziZmZbAAAAYmBAjZxwQGYWYhWYjBYmBDMA" },
}

-- https://www.method.gg/guides/subtlety-rogue/talents
BiSCompanionTalentData["Rogue_Subtlety_Deathstalker"] = {
}
BiSCompanionTalentData["Rogue_Subtlety_Trickster"] = {
    { buildName = "Trickster Single target", heroTree = "Trickster", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbbjxMjZgZmZGzMbzYGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA" },
    { buildName = "Trickster Bursty (Good for Coiled Altar / Ulatek)", heroTree = "Trickster", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbLjxMjZgZmZGzMbzYGbbzMzMzMjBjZ2GAAAAGMGwYWMMwAziWoFbYGwMDmxA" },
    { buildName = "Trickster M+", heroTree = "Trickster", importCode = "CUQAAAAAAAAAAAAAAAAAAAAAAAgx2MAAAAAwsMGLTMbLjxMjZMMzMzwMbzYGbbzMzMzMjBjZ2GAAAAGMGwYWMMwAziWoFbYGwMDmxA" },
}

-- https://www.method.gg/guides/elemental-shaman/talents
BiSCompanionTalentData["Shaman_Ele_Farseer"] = {
    { buildName = "Farseer Single Target", heroTree = "Farseer", importCode = "CYQALMl7AwW51MWzGneuHE3tPCAAAAzMbbzMmZmZZbZMMjBAAAAsYmNYADY2YCZWAgZbmZGjtlZajZmFWmZmZMDWGWMzwMLDAYYAMzYYYA" },
    { buildName = "Farseer Raid/Cleave", heroTree = "Farseer", importCode = "CYQALMl7AwW51MWzGneuHE3tPCAAAAzMbbzMGjZZbZMmhZAAAAgFzsBDYAzGTIzCAMbzMzYstMTbMzglZmZGzglZmlhxMzCAwwAYmxwwA" },
    { buildName = "Farseer Mythic+", heroTree = "Farseer", importCode = "CYQALMl7AwW51MWzGneuHE3tPCAAAAzMbbzMGjZZbZMmhZAAAAgFzsBDYAzGTIzCAMLzMzYstYajZmtxyMzMjhFLzMLDjZmFAgBAmZMMMA" },
}
BiSCompanionTalentData["Shaman_Ele_Stormbringer"] = {
}

-- https://www.method.gg/guides/enhancement-shaman/talents
BiSCompanionTalentData["Shaman_Enh_Stormbringer"] = {
    { buildName = "Single Target Stormbringer", heroTree = "Stormbringer", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAA2AsZGDLkFYGGawCAz2MmxYZZGbMzsNWmZmZYsMGAAzwYmhZCMzgBjB" },
    { buildName = "Mythic+ Stormbringer", heroTree = "Stormbringer", importCode = "CcQAAAAAAAAAAAAAAAAAAAAAAMzMzgZmZmZmhZmZAAAAAAAAA2AsZGDbkFYGGawCAz2MmxYZZGbMzYsMzMzMGLjBAwMMmZYEYmBDGDA" },
}
BiSCompanionTalentData["Shaman_Enh_Totemic"] = {
}

-- https://www.method.gg/guides/restoration-shaman/talents
BiSCompanionTalentData["Shaman_Resto_Farseer"] = {
    { buildName = "Raid Farseer", heroTree = "Farseer", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsssNjZGjxYmhZWMzGMgBMbMBGLmhZYWGzMTz2yMziZMbsMjZGDmlBAAAmZGAMzADmB" },
}
BiSCompanionTalentData["Shaman_Resto_Totemic"] = {
    { buildName = "Raid Totemic (Recommended)", heroTree = "Totemic", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsssNzMzYMzYmBjFYDmxmGbDgZgNzgBLjZmpZbZmZxMmF2m5BmZMYWGAAAYmZwMDAMYG" },
    { buildName = "Mythic+ Totemic (Recommended)", heroTree = "Totemic", importCode = "CgQAAAAAAAAAAAAAAAAAAAAAAAAAAgBAAAAzMzsstMzMzMjZGjZgFYDmxiGbDIzAbMzMY2mZMa2WmZ2MjZhFjZGDLzyAAAAzMDmZAgBzA" },
}

-- https://www.method.gg/guides/devastation-evoker/talents
BiSCompanionTalentData["Evoker_Devastation_Flameshaper"] = {
    { buildName = "Flameshaper ST", heroTree = "Flameshaper", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDmZYGzMgBjZamZmJzM2GmZGmZmZGwMmxYmZZmZwMwMmBWALgZYCsBWGGAzMDD" },
    { buildName = "Flameshaper Mythic+", heroTree = "Flameshaper", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZwMjZGzMgBjZamZmJzM2mxMzwYmZGwMmxYmZZmZwMwMmBWALgZYCsBWGGAzMDD" },
}
BiSCompanionTalentData["Evoker_Devastation_Scalecommander"] = {
    { buildName = "Scalecommander Single Target", heroTree = "Scalecommander", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAzMDMDzwMgBjZaMzMNjx2wMzMzMzMzAmZmxYmZZmZgBGD2glxox2AYGA2wMYmBDD" },
    { buildName = "Scalecommander Mythic+ & Cleave", heroTree = "Scalecommander", importCode = "CsbBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjZAMzwMwMYMTjZmpZmZ2mhZmZmZmZGwMzMGzMLzMDMwYwGsMGN2GAzAwGGYmBDD" },
}

-- https://www.method.gg/guides/preservation-evoker/talents
BiSCompanionTalentData["Evoker_Preservation_Chronowarden"] = {
    { buildName = "Mythic+ Chronowarden Hero Talents (Viable Alternative)", heroTree = "Chronowarden", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAMzMz2yMYYmxsZGjx2wAAAzYGzYMMTMmBAAAMzMTzYmZmZZMDAAjZsxCMwMaohhFYmZGAGA" },
    { buildName = "Raiding Chronowarden Hero Talents (Viable Alternative)", heroTree = "Chronowarden", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZwMjBzY2MMzMbYAAgZMjBzYGZmZAAAAmZmJzYmxsNzMAYgxM2YBGYGN0gxCMmZAGD" },
}
BiSCompanionTalentData["Evoker_Preservation_Flameshaper"] = {
    { buildName = "Mythic+ Flameshaper Hero Talents (Recommended for +11 and Lower)", heroTree = "Flameshaper", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ2WmZGDjxsMDw2wAAAzYGzYMMTMmBAAAMzMTzYmZmZZMDAMmBWAbgZYCZjxmhZAmZYA" },
    { buildName = "Mythic+ Flameshaper Hero Talents (Recommended for +12 and Higher)", heroTree = "Flameshaper", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAmZmZ2WGzYYMPwsZGw2wAAAzYGzYmhZiZmBAAAMzMTGzMjZZMDAMmBWAbgZYCZzM2MMDwMDD" },
    { buildName = "Raiding Flameshaper Hero Talents (Recommended)", heroTree = "Flameshaper", importCode = "CwbBAAAAAAAAAAAAAAAAAAAAAAAAAAAMzMDmZMYGzmhZmZbYAAgZMjZwYGZmZAAAAmZmJzYmxYmZAwMmBWALgZYCZzwmhBwMzYA" },
}

-- https://www.method.gg/guides/augmentation-evoker/talents
BiSCompanionTalentData["Evoker_Augmentation_Chronowarden"] = {
    { buildName = "Raid Single Target (Chronowarden)", heroTree = "Chronowarden", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbzMzgZYmZZGzMjZ2AAAAAAAAYmhxMYM1YmZGAAAAMjZMmZWGzMwMMwYGLsADMDDNwCGjZGAYA" },
    { buildName = "Mythic+ (Chronowarden)", heroTree = "Chronowarden", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbzMzgZYmZZGzMjZ2AAAAAAAAYmhZGYM1YmZGAAAAMjZMmZWGzMwMMwYGLsADMDDNwCGzMzAAD" },
}
BiSCompanionTalentData["Evoker_Augmentation_Scalecommander"] = {
    { buildName = "Raid Single Target (Scalecommander)", heroTree = "Scalecommander", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbjZmxyMYmlZMzMmBAAAAAAAAzMMmBjpGzMzAAAAgZMjxMzyYmBmZzYwCsMGGbDgZQshxAzMAG" },
    { buildName = "Mythic+ (Scalecommander)", heroTree = "Scalecommander", importCode = "CEcBAAAAAAAAAAAAAAAAAAAAAMMzMbjZmxyMYmtZMzMmBAAAAAAAAmhHYGYM1YmZGAAAAMzMjxMz2YmBmZzYwCsMGGbDgZQshxMYmBDG" },
}

