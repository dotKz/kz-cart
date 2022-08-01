Config = {}

AutoRespawn = true

Config.CartInvWeight = 480000
Config.CartInvSlots = 24
Config.MenuImg = "https://media.discordapp.net/attachments/643013669369937941/993545606633111632/CHARIOTS.png"

Config.SetInv = true -- Use individual setting / type of wargon (look Config.Inv)


-- ////////////////////// Stable Cart Localisation //////////////////////
StableCart = {
    ["blackwater"] = {
		name = 'BlackWater',
        takeCart = vector3(-867.02, -1380.0, 43.64),
        spawnPoint = vector4(-879.08, -1386.59, 43.7, 189.96),
        putCart = vector3(-868.24, -1382.81, 43.59),
    },
	["valentine"] = {
		name = 'Valentine',
        takeCart = vector3(-363.76, 796.06, 116.21),
        spawnPoint = vector4(-358.8, 797.48, 116.26, 265.82),
        putCart = vector3(-358.8, 797.48, 116.26),
    },
	["tumbleweed"] = {
		name = 'Tumbleweed',
        takeCart = vector3(-5509.75, -3049.56, -2.36),
        spawnPoint = vector4(-5509.91, -3060.02, -2.54, 178.82),
        putCart = vector3(-5509.91, -3060.02, -2.54),
    },
	["rhodes"] = {
		name = 'Rhodes',
        takeCart = vector3(1317.13, -1364.42, 78.3),
        spawnPoint = vector4(1322.2, -1368.61, 79.37, 343.84),
        putCart = vector3(1322.2, -1368.61, 79.37),
    },
	["stdenis"] = {
		name = 'St Denis',
        takeCart = vector3(2510.42, -1457.01, 46.31),
        spawnPoint = vector4(2503.59, -1431.2, 46.23, 87.17),
        putCart = vector3(2503.59, -1431.2, 46.23),
    },
	["annesburg"] = {
		name = 'Annesburg',
        takeCart = vector3(2976.62, 1429.85, 44.72),
        spawnPoint = vector4(2980.48, 1416.78, 44.7, 120.21),
        putCart = vector3(2980.48, 1416.78, 44.7),
    },
}



-- ////////////////////// cart Buyable //////////////////////
Config.CartList = {
    [1] = {
        ['label'] = "Chariot du chasseur",
        ['image'] = "https://i.imgur.com/N3TJNhd.png",
        ['model'] = "HUNTERCART01", 
        ['price'] = 650, 
    }, 
    [2] = {
        ['label'] = "Chariot du chasseur de primes",
        ['image'] = "https://i.imgur.com/CmIUSzM.png",
        ['model'] = "BOUNTYWAGON01X", 
        ['price'] = 400, 
    },
    [3] = {
        ['label'] = "Diligence",
        ['image'] = "https://i.imgur.com/52Dust3.png", 
        ['model'] = "COACH2", 
        ['price'] = 1500, 
    },
}

-- ////////////////////// Inventory (set true to Config.SetInv) //////////////////////
Config.Inv = {
    [1761016051] = {---COACH2
        ["maxweight"] = 1000,
        ["slots"] = 3,
    },
    [-2044900246] = {---BOUNTYWAGON01X
        ["maxweight"] = 2000,
        ["slots"] = 4,
    },
    [-1698498246] = {---HUNTERCART01
        ["maxweight"] = 3000,
        ["slots"] = 5,
    },

}