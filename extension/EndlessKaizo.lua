-- EndlessKaizo.lua
local function EndlessKaizo()
    local self = {}
    self.name = "Endless Kaizo"
    self.author = "Selipnir"
    self.description = "Simple options popup for Endless Kaizo"
    self.version = "0.1"

    ------------------------------------------------------------
    -- Settings
    ------------------------------------------------------------

    self.Settings = {
        baseRNQS = "",
        lastGeneratedJar = "",
        currentMonIndex = 1,
        showOverlay = true,
        javaChecked = false,
    }
    -- Persistent extension state
    ExtensionState = ExtensionState or {
        championWinProcessed = false,
    }


    function handleAfterBattleEnds()
        -- Prevent double execution
        if ExtensionState.championWinProcessed then
            return
        end
    
        -- Ensure tracker knows this was a win
        local outcome = TrackerAPI.getBattleOutcome()
        -- Convention: 1 = win, 2 = loss, 0 = unknown
        if outcome ~= 1 then
            return
        end
    
        -- Identify opponent trainer
        local opponentTrainerId = TrackerAPI.getOpponentTrainerId()
        if opponentTrainerId == nil then
            return
        end
    
        -- FireRed Champion (Blue)
        local CHAMPION_TRAINER_ID = 0x0202 -- this is correct for FR/LG
    
        if opponentTrainerId ~= CHAMPION_TRAINER_ID then
            return
        end
    
        -- Mark processed BEFORE running logic (important!)
        ExtensionState.championWinProcessed = true
    
        --  YOU WON 
        print("[Ironmon Extension] Champion defeated!")
    
        onChampionDefeated()

        ExtensionState.championWinProcessed = false -- reset for the next seed
    end

    ------------------------------------------------------------
    -- Pokémon table
    ------------------------------------------------------------

    self.MonsList = {
        { number = 249, name = "Lugia", mon_id = 250 },
        { number = 250, name = "Ho-oh", mon_id = 251 },
        { number = 150, name = "Mewtwo", mon_id = 151 },
        { number = 384, name = "Rayquaza", mon_id = 385 },
        { number = 289, name = "Slaking", mon_id = 290 },
        { number = 382, name = "Kyogre", mon_id = 383 },
        { number = 383, name = "Groudon", mon_id = 384 },
        { number = 248, name = "Tyranitar", mon_id = 249 },
        { number = 251, name = "Celebi", mon_id = 252 },
        { number = 149, name = "Dragonite", mon_id = 150 },
        { number = 151, name = "Mew", mon_id = 152 },
        { number = 373, name = "Salamence", mon_id = 374 },
        { number = 376, name = "Metagross", mon_id = 377 },
        { number = 380, name = "Latias", mon_id = 381 },
        { number = 381, name = "Latios", mon_id = 382 },
        { number = 385, name = "Jirachi", mon_id = 386 },
        { number = 386, name = "Deoxys", mon_id = 387 },
        { number = 243, name = "Raikou", mon_id = 244 },
        { number = 244, name = "Entei", mon_id = 245 },
        { number = 245, name = "Suicune", mon_id = 246 },
        { number = 144, name = "Articuno", mon_id = 145 },
        { number = 145, name = "Zapdos", mon_id = 146 },
        { number = 146, name = "Moltres", mon_id = 147 },
        { number = 377, name = "Regirock", mon_id = 378 },
        { number = 378, name = "Regice", mon_id = 379 },
        { number = 379, name = "Registeel", mon_id = 380 },
        { number = 59, name = "Arcanine", mon_id = 60 },
        { number = 230, name = "Kingdra", mon_id = 231 },
        { number = 242, name = "Blissey", mon_id = 243 },
        { number = 130, name = "Gyarados", mon_id = 131 },
        { number = 143, name = "Snorlax", mon_id = 144 },
        { number = 350, name = "Milotic", mon_id = 351 },
        { number = 169, name = "Crobat", mon_id = 170 },
        { number = 131, name = "Lapras", mon_id = 132 },
        { number = 260, name = "Swampert", mon_id = 261 },
        { number = 157, name = "Typhlosion", mon_id = 158 },
        { number = 6, name = "Charizard", mon_id = 7 },
        { number = 160, name = "Feraligatr", mon_id = 161 },
        { number = 9, name = "Blastoise", mon_id = 10 },
        { number = 103, name = "Exeggutor", mon_id = 104 },
        { number = 254, name = "Sceptile", mon_id = 255 },
        { number = 257, name = "Blaziken", mon_id = 258 },
        { number = 306, name = "Aggron", mon_id = 307 },
        { number = 365, name = "Walrein", mon_id = 366 },
        { number = 154, name = "Meganium", mon_id = 155 },
        { number = 196, name = "Espeon", mon_id = 197 },
        { number = 197, name = "Umbreon", mon_id = 198 },
        { number = 3, name = "Venusaur", mon_id = 4 },
        { number = 91, name = "Cloyster", mon_id = 92 },
        { number = 134, name = "Vaporeon", mon_id = 135 },
        { number = 135, name = "Jolteon", mon_id = 136 },
        { number = 136, name = "Flareon", mon_id = 137 },
        { number = 121, name = "Starmie", mon_id = 122 },
        { number = 330, name = "Flygon", mon_id = 331 },
        { number = 282, name = "Gardevoir", mon_id = 283 },
        { number = 233, name = "Porygon2", mon_id = 234 },
        { number = 73, name = "Tentacruel", mon_id = 74 },
        { number = 142, name = "Aerodactyl", mon_id = 143 },
        { number = 181, name = "Ampharos", mon_id = 182 },
        { number = 208, name = "Steelix", mon_id = 209 },
        { number = 62, name = "Poliwrath", mon_id = 63 },
        { number = 213, name = "Shuckle", mon_id = 214 },
        { number = 31, name = "Nidoqueen", mon_id = 32 },
        { number = 34, name = "Nidoking", mon_id = 35 },
        { number = 38, name = "Ninetales", mon_id = 39 },
        { number = 68, name = "Machamp", mon_id = 69 },
        { number = 186, name = "Politoed", mon_id = 187 },
        { number = 212, name = "Scizor", mon_id = 213 },
        { number = 214, name = "Heracross", mon_id = 215 },
        { number = 217, name = "Ursaring", mon_id = 218 },
        { number = 229, name = "Houndoom", mon_id = 230 },
        { number = 232, name = "Donphan", mon_id = 233 },
        { number = 55, name = "Golduck", mon_id = 56 },
        { number = 65, name = "Alakazam", mon_id = 66 },
        { number = 78, name = "Rapidash", mon_id = 79 },
        { number = 89, name = "Muk", mon_id = 90 },
        { number = 94, name = "Gengar", mon_id = 95 },
        { number = 123, name = "Scyther", mon_id = 124 },
        { number = 127, name = "Pinsir", mon_id = 128 },
        { number = 321, name = "Wailord", mon_id = 322 },
        { number = 344, name = "Claydol", mon_id = 345 },
        { number = 76, name = "Golem", mon_id = 77 },
        { number = 126, name = "Magmar", mon_id = 127 },
        { number = 139, name = "Omastar", mon_id = 140 },
        { number = 141, name = "Kabutops", mon_id = 142 },
        { number = 346, name = "Cradily", mon_id = 347 },
        { number = 348, name = "Armaldo", mon_id = 349 },
        { number = 182, name = "Bellossom", mon_id = 183 },
        { number = 199, name = "Slowking", mon_id = 200 },
        { number = 241, name = "Miltank", mon_id = 242 },
        { number = 45, name = "Vileplume", mon_id = 46 },
        { number = 71, name = "Victreebel", mon_id = 72 },
        { number = 80, name = "Slowbro", mon_id = 81 },
        { number = 101, name = "Electrode", mon_id = 102 },
        { number = 110, name = "Weezing", mon_id = 111 },
        { number = 115, name = "Kangaskhan", mon_id = 116 },
        { number = 125, name = "Electabuzz", mon_id = 126 },
        { number = 128, name = "Tauros", mon_id = 129 },
        { number = 295, name = "Exploud", mon_id = 296 },
        { number = 334, name = "Altaria", mon_id = 335 },
        { number = 226, name = "Mantine", mon_id = 227 },
        { number = 26, name = "Raichu", mon_id = 27 },
        { number = 112, name = "Rhydon", mon_id = 113 },
        { number = 367, name = "Huntail", mon_id = 368 },
        { number = 368, name = "Gorebyss", mon_id = 369 },
        { number = 369, name = "Relicanth", mon_id = 370 },
        { number = 36, name = "Clefable", mon_id = 37 },
        { number = 97, name = "Hypno", mon_id = 98 },
        { number = 224, name = "Octillery", mon_id = 225 },
        { number = 272, name = "Ludicolo", mon_id = 273 },
        { number = 275, name = "Shiftry", mon_id = 276 },
        { number = 362, name = "Glalie", mon_id = 363 },
        { number = 18, name = "Pidgeot", mon_id = 19 },
        { number = 87, name = "Dewgong", mon_id = 88 },
        { number = 99, name = "Kingler", mon_id = 100 },
        { number = 310, name = "Manectric", mon_id = 311 },
        { number = 332, name = "Cacturne", mon_id = 333 },
        { number = 297, name = "Hariyama", mon_id = 298 },
        { number = 178, name = "Xatu", mon_id = 179 },
        { number = 85, name = "Dodrio", mon_id = 86 },
        { number = 324, name = "Torkoal", mon_id = 325 },
        { number = 326, name = "Grumpig", mon_id = 327 },
        { number = 340, name = "Whiscash", mon_id = 341 },
        { number = 342, name = "Crawdaunt", mon_id = 343 },
        { number = 317, name = "Swalot", mon_id = 318 },
        { number = 205, name = "Forretress", mon_id = 206 },
        { number = 227, name = "Skarmory", mon_id = 228 },
        { number = 234, name = "Stantler", mon_id = 235 },
        { number = 82, name = "Magneton", mon_id = 83 },
        { number = 359, name = "Absol", mon_id = 360 },
        { number = 171, name = "Lanturn", mon_id = 172 },
        { number = 189, name = "Jumpluff", mon_id = 190 },
        { number = 122, name = "Mr. Mime", mon_id = 123 },
        { number = 286, name = "Breloom", mon_id = 287 },
        { number = 319, name = "Sharpedo", mon_id = 320 },
        { number = 323, name = "Camerupt", mon_id = 324 },
        { number = 337, name = "Lunatone", mon_id = 338 },
        { number = 338, name = "Solrock", mon_id = 339 },
        { number = 357, name = "Tropius", mon_id = 358 },
        { number = 335, name = "Zangoose", mon_id = 336 },
        { number = 336, name = "Seviper", mon_id = 337 },
        { number = 291, name = "Ninjask", mon_id = 292 },
        { number = 203, name = "Girafarig", mon_id = 204 },
        { number = 237, name = "Hitmontop", mon_id = 238 },
        { number = 42, name = "Golbat", mon_id = 43 },
        { number = 57, name = "Primeape", mon_id = 58 },
        { number = 106, name = "Hitmonlee", mon_id = 107 },
        { number = 107, name = "Hitmonchan", mon_id = 108 },
        { number = 124, name = "Jynx", mon_id = 125 },
        { number = 277, name = "Swellow", mon_id = 278 },
        { number = 354, name = "Banette", mon_id = 355 },
        { number = 356, name = "Dusclops", mon_id = 357 },
        { number = 358, name = "Chimecho", mon_id = 359 },
        { number = 284, name = "Masquerain", mon_id = 285 },
        { number = 164, name = "Noctowl", mon_id = 165 },
        { number = 210, name = "Granbull", mon_id = 211 },
        { number = 221, name = "Piloswine", mon_id = 222 },
        { number = 28, name = "Sandslash", mon_id = 29 },
        { number = 49, name = "Venomoth", mon_id = 50 },
        { number = 113, name = "Chansey", mon_id = 114 },
        { number = 119, name = "Seaking", mon_id = 120 },
        { number = 24, name = "Arbok", mon_id = 25 },
        { number = 22, name = "Fearow", mon_id = 23 },
        { number = 211, name = "Qwilfish", mon_id = 212 },
        { number = 53, name = "Persian", mon_id = 54 },
        { number = 117, name = "Seadra", mon_id = 118 },
        { number = 279, name = "Pelipper", mon_id = 280 },
        { number = 288, name = "Vigoroth", mon_id = 289 },
        { number = 352, name = "Kecleon", mon_id = 353 },
        { number = 200, name = "Misdreavus", mon_id = 201 },
        { number = 40, name = "Wigglytuff", mon_id = 41 },
        { number = 114, name = "Tangela", mon_id = 115 },
        { number = 195, name = "Quagsire", mon_id = 196 },
        { number = 207, name = "Gligar", mon_id = 208 },
        { number = 215, name = "Sneasel", mon_id = 216 },
        { number = 219, name = "Magcargo", mon_id = 220 },
        { number = 305, name = "Lairon", mon_id = 306 },
        { number = 313, name = "Volbeat", mon_id = 314 },
        { number = 314, name = "Illumise", mon_id = 315 },
        { number = 192, name = "Sunflora", mon_id = 193 },
        { number = 51, name = "Dugtrio", mon_id = 52 },
        { number = 105, name = "Marowak", mon_id = 106 },
        { number = 184, name = "Azumarill", mon_id = 185 },
        { number = 148, name = "Dragonair", mon_id = 149 },
        { number = 262, name = "Mightyena", mon_id = 263 },
        { number = 264, name = "Linoone", mon_id = 265 },
        { number = 351, name = "Castform", mon_id = 352 },
        { number = 372, name = "Shelgon", mon_id = 373 },
        { number = 375, name = "Metang", mon_id = 376 },
        { number = 162, name = "Furret", mon_id = 163 },
        { number = 206, name = "Dunsparce", mon_id = 207 },
        { number = 20, name = "Raticate", mon_id = 21 },
        { number = 185, name = "Sudowoodo", mon_id = 186 },
        { number = 222, name = "Corsola", mon_id = 223 },
        { number = 247, name = "Pupitar", mon_id = 248 },
        { number = 77, name = "Ponyta", mon_id = 78 },
        { number = 308, name = "Medicham", mon_id = 309 },
        { number = 364, name = "Sealeo", mon_id = 365 },
        { number = 153, name = "Bayleef", mon_id = 154 },
        { number = 156, name = "Quilava", mon_id = 157 },
        { number = 159, name = "Croconaw", mon_id = 160 },
        { number = 176, name = "Togetic", mon_id = 177 },
        { number = 198, name = "Murkrow", mon_id = 199 },
        { number = 202, name = "Wobbuffet", mon_id = 203 },
        { number = 2, name = "Ivysaur", mon_id = 3 },
        { number = 5, name = "Charmeleon", mon_id = 6 },
        { number = 8, name = "Wartortle", mon_id = 9 },
        { number = 47, name = "Parasect", mon_id = 48 },
        { number = 67, name = "Machoke", mon_id = 68 },
        { number = 93, name = "Haunter", mon_id = 94 },
        { number = 253, name = "Grovyle", mon_id = 254 },
        { number = 256, name = "Combusken", mon_id = 257 },
        { number = 259, name = "Marshtomp", mon_id = 260 },
        { number = 311, name = "Plusle", mon_id = 312 },
        { number = 312, name = "Minun", mon_id = 313 },
        { number = 168, name = "Ariados", mon_id = 169 },
        { number = 64, name = "Kadabra", mon_id = 65 },
        { number = 301, name = "Delcatty", mon_id = 302 },
        { number = 315, name = "Roselia", mon_id = 316 },
        { number = 320, name = "Wailmer", mon_id = 321 },
        { number = 12, name = "Butterfree", mon_id = 13 },
        { number = 15, name = "Beedrill", mon_id = 16 },
        { number = 44, name = "Gloom", mon_id = 45 },
        { number = 137, name = "Porygon", mon_id = 138 },
        { number = 267, name = "Beautifly", mon_id = 268 },
        { number = 166, name = "Ledian", mon_id = 167 },
        { number = 193, name = "Yanma", mon_id = 194 },
        { number = 70, name = "Weepinbell", mon_id = 71 },
        { number = 75, name = "Graveler", mon_id = 76 },
        { number = 61, name = "Poliwhirl", mon_id = 62 },
        { number = 95, name = "Onix", mon_id = 96 },
        { number = 108, name = "Lickitung", mon_id = 109 },
        { number = 269, name = "Dustox", mon_id = 270 },
        { number = 302, name = "Sableye", mon_id = 303 },
        { number = 303, name = "Mawile", mon_id = 304 },
        { number = 83, name = "Farfetch'd", mon_id = 84 },
        { number = 299, name = "Nosepass", mon_id = 300 },
        { number = 180, name = "Flaaffy", mon_id = 181 },
        { number = 240, name = "Magby", mon_id = 241 },
        { number = 30, name = "Nidorina", mon_id = 31 },
        { number = 33, name = "Nidorino", mon_id = 34 },
        { number = 190, name = "Aipom", mon_id = 191 },
        { number = 239, name = "Elekid", mon_id = 240 },
        { number = 294, name = "Loudred", mon_id = 295 },
        { number = 327, name = "Spinda", mon_id = 328 },
        { number = 138, name = "Omanyte", mon_id = 139 },
        { number = 140, name = "Kabuto", mon_id = 141 },
        { number = 345, name = "Lileep", mon_id = 346 },
        { number = 347, name = "Anorith", mon_id = 348 },
        { number = 58, name = "Growlithe", mon_id = 59 },
        { number = 17, name = "Pidgeotto", mon_id = 18 },
        { number = 111, name = "Rhyhorn", mon_id = 112 },
        { number = 366, name = "Clamperl", mon_id = 367 },
        { number = 188, name = "Skiploom", mon_id = 189 },
        { number = 109, name = "Koffing", mon_id = 110 },
        { number = 120, name = "Staryu", mon_id = 121 },
        { number = 271, name = "Lombre", mon_id = 272 },
        { number = 274, name = "Nuzleaf", mon_id = 275 },
        { number = 329, name = "Vibrava", mon_id = 330 },
        { number = 201, name = "Unown", mon_id = 202 },
        { number = 72, name = "Tentacool", mon_id = 73 },
        { number = 331, name = "Cacnea", mon_id = 332 },
        { number = 170, name = "Chinchou", mon_id = 171 },
        { number = 216, name = "Teddiursa", mon_id = 217 },
        { number = 225, name = "Delibird", mon_id = 226 },
        { number = 228, name = "Houndour", mon_id = 229 },
        { number = 231, name = "Phanpy", mon_id = 232 },
        { number = 100, name = "Voltorb", mon_id = 101 },
        { number = 304, name = "Aron", mon_id = 305 },
        { number = 325, name = "Spoink", mon_id = 326 },
        { number = 370, name = "Luvdisc", mon_id = 371 },
        { number = 96, name = "Drowzee", mon_id = 97 },
        { number = 81, name = "Magnemite", mon_id = 82 },
        { number = 86, name = "Seel", mon_id = 87 },
        { number = 88, name = "Grimer", mon_id = 89 },
        { number = 98, name = "Krabby", mon_id = 99 },
        { number = 102, name = "Exeggcute", mon_id = 103 },
        { number = 133, name = "Eevee", mon_id = 134 },
        { number = 35, name = "Clefairy", mon_id = 36 },
        { number = 177, name = "Natu", mon_id = 178 },
        { number = 25, name = "Pikachu", mon_id = 26 },
        { number = 43, name = "Oddish", mon_id = 44 },
        { number = 54, name = "Psyduck", mon_id = 55 },
        { number = 104, name = "Cubone", mon_id = 105 },
        { number = 118, name = "Goldeen", mon_id = 119 },
        { number = 152, name = "Chikorita", mon_id = 153 },
        { number = 1, name = "Bulbasaur", mon_id = 2 },
        { number = 79, name = "Slowpoke", mon_id = 80 },
        { number = 158, name = "Totodile", mon_id = 159 },
        { number = 7, name = "Squirtle", mon_id = 8 },
        { number = 63, name = "Abra", mon_id = 64 },
        { number = 84, name = "Doduo", mon_id = 85 },
        { number = 92, name = "Gastly", mon_id = 93 },
        { number = 252, name = "Treecko", mon_id = 253 },
        { number = 255, name = "Torchic", mon_id = 256 },
        { number = 258, name = "Mudkip", mon_id = 259 },
        { number = 333, name = "Swablu", mon_id = 334 },
        { number = 155, name = "Cyndaquil", mon_id = 156 },
        { number = 4, name = "Charmander", mon_id = 5 },
        { number = 341, name = "Corphish", mon_id = 342 },
        { number = 238, name = "Smoochum", mon_id = 239 },
        { number = 48, name = "Venonat", mon_id = 49 },
        { number = 56, name = "Mankey", mon_id = 57 },
        { number = 66, name = "Machop", mon_id = 67 },
        { number = 90, name = "Shellder", mon_id = 91 },
        { number = 318, name = "Carvanha", mon_id = 319 },
        { number = 322, name = "Numel", mon_id = 323 },
        { number = 316, name = "Gulpin", mon_id = 317 },
        { number = 209, name = "Snubbull", mon_id = 210 },
        { number = 223, name = "Remoraid", mon_id = 224 },
        { number = 246, name = "Larvitar", mon_id = 247 },
        { number = 27, name = "Sandshrew", mon_id = 28 },
        { number = 60, name = "Poliwag", mon_id = 61 },
        { number = 69, name = "Bellsprout", mon_id = 70 },
        { number = 74, name = "Geodude", mon_id = 75 },
        { number = 147, name = "Dratini", mon_id = 148 },
        { number = 343, name = "Baltoy", mon_id = 344 },
        { number = 361, name = "Snorunt", mon_id = 362 },
        { number = 371, name = "Bagon", mon_id = 372 },
        { number = 374, name = "Beldum", mon_id = 375 },
        { number = 37, name = "Vulpix", mon_id = 38 },
        { number = 116, name = "Horsea", mon_id = 117 },
        { number = 285, name = "Shroomish", mon_id = 286 },
        { number = 309, name = "Electrike", mon_id = 310 },
        { number = 353, name = "Shuppet", mon_id = 354 },
        { number = 355, name = "Duskull", mon_id = 356 },
        { number = 204, name = "Pineco", mon_id = 205 },
        { number = 52, name = "Meowth", mon_id = 53 },
        { number = 328, name = "Trapinch", mon_id = 329 },
        { number = 363, name = "Spheal", mon_id = 364 },
        { number = 23, name = "Ekans", mon_id = 24 },
        { number = 132, name = "Ditto", mon_id = 133 },
        { number = 339, name = "Barboach", mon_id = 340 },
        { number = 46, name = "Paras", mon_id = 47 },
        { number = 179, name = "Mareep", mon_id = 180 },
        { number = 287, name = "Slakoth", mon_id = 288 },
        { number = 307, name = "Meditite", mon_id = 308 },
        { number = 281, name = "Kirlia", mon_id = 282 },
        { number = 29, name = "Nidoran♀", mon_id = 30 },
        { number = 32, name = "Nidoran♂", mon_id = 33 },
        { number = 39, name = "Jigglypuff", mon_id = 40 },
        { number = 276, name = "Taillow", mon_id = 277 },
        { number = 278, name = "Wingull", mon_id = 279 },
        { number = 283, name = "Surskit", mon_id = 284 },
        { number = 290, name = "Nincada", mon_id = 291 },
        { number = 165, name = "Ledyba", mon_id = 166 },
        { number = 50, name = "Diglett", mon_id = 51 },
        { number = 163, name = "Hoothoot", mon_id = 164 },
        { number = 21, name = "Spearow", mon_id = 22 },
        { number = 300, name = "Skitty", mon_id = 301 },
        { number = 360, name = "Wynaut", mon_id = 361 },
        { number = 19, name = "Rattata", mon_id = 20 },
        { number = 16, name = "Pidgey", mon_id = 17 },
        { number = 167, name = "Spinarak", mon_id = 168 },
        { number = 183, name = "Marill", mon_id = 184 },
        { number = 187, name = "Hoppip", mon_id = 188 },
        { number = 218, name = "Slugma", mon_id = 219 },
        { number = 220, name = "Swinub", mon_id = 221 },
        { number = 235, name = "Smeargle", mon_id = 236 },
        { number = 175, name = "Togepi", mon_id = 176 },
        { number = 41, name = "Zubat", mon_id = 42 },
        { number = 263, name = "Zigzagoon", mon_id = 264 },
        { number = 293, name = "Whismur", mon_id = 294 },
        { number = 296, name = "Makuhita", mon_id = 297 },
        { number = 292, name = "Shedinja", mon_id = 293 },
        { number = 261, name = "Poochyena", mon_id = 262 },
        { number = 270, name = "Lotad", mon_id = 271 },
        { number = 273, name = "Seedot", mon_id = 274 },
        { number = 173, name = "Cleffa", mon_id = 174 },
        { number = 161, name = "Sentret", mon_id = 162 },
        { number = 174, name = "Igglybuff", mon_id = 175 },
        { number = 194, name = "Wooper", mon_id = 195 },
        { number = 236, name = "Tyrogue", mon_id = 237 },
        { number = 172, name = "Pichu", mon_id = 173 },
        { number = 11, name = "Metapod", mon_id = 12 },
        { number = 14, name = "Kakuna", mon_id = 15 },
        { number = 266, name = "Silcoon", mon_id = 267 },
        { number = 268, name = "Cascoon", mon_id = 269 },
        { number = 129, name = "Magikarp", mon_id = 130 },
        { number = 349, name = "Feebas", mon_id = 350 },
        { number = 280, name = "Ralts", mon_id = 281 },
        { number = 10, name = "Caterpie", mon_id = 11 },
        { number = 13, name = "Weedle", mon_id = 14 },
        { number = 265, name = "Wurmple", mon_id = 266 },
        { number = 298, name = "Azurill", mon_id = 299 },
        { number = 191, name = "Sunkern", mon_id = 192 },

    }

    ------------------------------------------------------------
    -- Helpers
    ------------------------------------------------------------

    local function normalizePath(path)
        if not path then return nil end
        return path:gsub("\\", "/")
    end

    local function quote(path)
        return '"' .. path .. '"'
    end

    local function makeOutputPath(inputPath)
        if not inputPath then
            return nil, "No input path"
        end
    
        local dir, filename = inputPath:match("^(.-)([^/]+)$")
        if not filename then
            return nil, "Invalid input path"
        end
    
        local base, ext = filename:match("^(.*)%.([^%.]+)$")
        if not base then
            return nil, "Input file has no extension"
        end
    
        -- Only append _EK if it doesn't already end with it
        if not base:match("_EK$") then
            base = base .. "_EK"
        end
    
        return dir .. base .. "." .. ext
    end

    local function getDirectoryFromPath(path)
        if not path then return nil end
        path = normalizePath(path)
        return path:match("(.*/)")
    end

    local function getJarPath()
        local base = normalizePath(debug.getinfo(1, "S").source:sub(2))
        local dir = base:match("(.*/)")
        return dir .. "EndlessKaizo/EndlessKaizo.jar"
    end

    ------------------------------------------------------------
    -- Java detection (Java 8+)
    ------------------------------------------------------------

    local MIN_JAVA_VERSION = 8

    local function getJarFolder()
        local base = normalizePath(debug.getinfo(1, "S").source:sub(2))
        return base:match("(.*/)")
    end
    

    function findBestJava()
        return { javaPath = "java" }
    end

    ------------------------------------------------------------
    -- Core logic
    ------------------------------------------------------------

    -- Cycle to next Pokémon and auto-save
    local function cycleMon()
        -- Increment index
        self.Settings.currentMonIndex = self.Settings.currentMonIndex + 1
        if self.Settings.currentMonIndex > #self.MonsList then
            self.Settings.currentMonIndex = 1
        end

        -- Update current mon label
        local current = self.MonsList[self.Settings.currentMonIndex]
        if self.currentMonLabel then
            forms.settext(self.currentMonLabel, "Current Table Mon: " .. current.number .. " - " .. current.name)
        end

        -- Auto-save
        self:saveSettings()
        print("[EndlessKaizo] Cycled to next Pokémon:", current.name)
    end
    
    function generateJar()
        if not self.Settings.baseRNQS or self.Settings.baseRNQS == "" then
            print("[EndlessKaizo] No Base RNQS selected")
            return
        end
    
        local javaCandidate = findBestJava()
        if not javaCandidate then
            print("[EndlessKaizo] ERROR: No usable Java found!")
            if Program.activeFormId and self.lastGeneratedLabel then
                forms.settext(self.lastGeneratedLabel, "ERROR: No usable Java!")
            end
            return
        end
        local javaExe = javaCandidate.javaPath
    
        local inputPath = normalizePath(self.Settings.baseRNQS)
        local inputFileName = inputPath:match("([^/\\]+)$")  -- just filename
        local tempDir = os.getenv("TEMP") .. "\\ek_gen_temp"
    
        -- Clean temp folder
        os.execute('rmdir /s /q "' .. tempDir .. '" >nul 2>&1')
        os.execute('mkdir "' .. tempDir .. '" >nul 2>&1')
    
        local tempInput = tempDir .. "\\" .. inputFileName
        local tempOutput = tempInput:gsub("%.rnqs$", "_EK.rnqs")
    
        -- --- Lua file copy (replaces CMD copy) ---
        local function copyFile(src, dest)
            local fSrc = io.open(src, "rb")
            if not fSrc then return false, "Source file not found" end
            local fDest = io.open(dest, "wb")
            if not fDest then fSrc:close() return false, "Cannot write to destination" end
            local data = fSrc:read("*all")
            fDest:write(data)
            fSrc:close()
            fDest:close()
            return true
        end
    
        local success, err = copyFile(inputPath, tempInput)
        if not success then
            print("[EndlessKaizo] ERROR: Failed to copy RNQS to temp folder:", err)
            if Program.activeFormId and self.lastGeneratedLabel then
                forms.settext(self.lastGeneratedLabel, "ERROR: Copy failed!")
            end
            return
        end
        print("[EndlessKaizo] Copied RNQS to temp folder:", tempInput)
    
        -- Build Java command inside temp folder
        local cmd = string.format(
            'cd /d "%s" && "%s" -jar "%s" -i "%s" -o "%s" -c %d',
            tempDir,
            javaExe,
            normalizePath(getJarPath()),
            tempInput,
            tempOutput,
            self.MonsList[self.Settings.currentMonIndex].mon_id
        )
    
        print("[EndlessKaizo] Generating file in temp folder...")
        print("[EndlessKaizo] Running command:", cmd)
    
        local pipe = io.popen(cmd .. " 2>&1")
        if not pipe then
            print("[EndlessKaizo] Failed to launch Java process")
            if Program.activeFormId and self.lastGeneratedLabel then
                forms.settext(self.lastGeneratedLabel, "Failed to launch Java")
            end
            return
        end
    
        local output = pipe:read("*a") or ""
        local successClose, exit_type, exit_code = pipe:close()
        print("[EndlessKaizo] Java output:")
        print(output)
    
        if output:find("UnsupportedClassVersionError", 1, true) then
            print("[EndlessKaizo] ERROR: Your Java version is too old for this jar!")
            if Program.activeFormId and self.lastGeneratedLabel then
                forms.settext(self.lastGeneratedLabel, "ERROR: Java version too old!")
            end
            return
        end
    
        -- Success check: consider RNQS generated if output file exists
        local f = io.open(tempOutput, "rb")
        if f then
            f:close()
            -- Copy back to original folder
            local finalOutput, err = makeOutputPath(inputPath)
            if finalOutput then
                local copyBackSuccess, copyBackErr = copyFile(tempOutput, finalOutput)
                if copyBackSuccess then
                    -- Save last generated RNQS
                    self.Settings.lastGeneratedJar = finalOutput
                    self:saveSettings()  -- <-- Auto-save
                    if Program.activeFormId and self.lastGeneratedLabel then
                        forms.settext(self.lastGeneratedLabel, finalOutput)
                    end
                    print("[EndlessKaizo] RNQS generated successfully:", finalOutput)
                else
                    print("[EndlessKaizo] ERROR copying generated RNQS back:", copyBackErr)
                end
            else
                print("[EndlessKaizo] Error computing output path:", err)
            end
        else
            print("[EndlessKaizo] RNQS generation failed (output not created)")
            if Program.activeFormId and self.lastGeneratedLabel then
                forms.settext(self.lastGeneratedLabel, "Generation failed! See log.")
            end
        end
    end
    

    ------------------------------------------------------------
    -- UI
    ------------------------------------------------------------

    local function openOptionsPopup()
        Program.destroyActiveForm()

        local form = forms.newform(420, 330, "Endless Kaizo Options")
        Program.activeFormId = form

        local y = 10
        local spacing = 35
        local labelX = 10
        local inputX = 160
        local inputWidth = 220
        local inputHeight = 25

        -- Base RNQS file
        forms.label(form, "Base RNQS File:", labelX, y)
        local textboxBase = forms.textbox(form, self.Settings.baseRNQS or "", inputWidth - 80, inputHeight, nil, inputX, y)
        forms.button(form, "Browse", function()
            local initialDir = getDirectoryFromPath(self.Settings.baseRNQS)
        
            local filename = forms.openfile(
                nil,
                initialDir,
                "RNQS files (*.rnqs)|*.rnqs"
            )
        
            if filename then
                filename = normalizePath(filename)
                forms.settext(textboxBase, filename)
                self.Settings.baseRNQS = filename
            end
        end, inputX + inputWidth - 70, y, 70, inputHeight)
        y = y + spacing

        -- Last Generated file (label)
        forms.label(form, "Last Generated File:", labelX, y)
        self.lastGeneratedLabel = forms.textbox(form, self.Settings.lastGeneratedJar or "<none>", inputWidth, inputHeight, nil, inputX, y)
        y = y + spacing

        -- Generate button
        forms.button(form, "Generate", generateJar, labelX, y, 100, 25)

        -- Cycle Mon button
        forms.button(form, "Cycle Mon", cycleMon, 120, y, 100, 25)
        y = y + spacing

        -- Current Table Mon label
        local current = self.MonsList[self.Settings.currentMonIndex]
        self.currentMonLabel = forms.label(form, "Current Table Mon: " .. current.number .. " - " .. current.name, labelX, y, 300, 25)
        y = y + spacing

        -- Buttons on the same Y, evenly spaced
        local buttonY = y
        local formWidth = 420  -- your form width
        local buttonWidth = 80
        local buttonHeight = 25
        local gap = (formWidth - (buttonWidth * 3)) / 4  -- 3 buttons, 4 gaps

        -- Save button (left)
        forms.button(form, "Save", function()
            self.Settings.baseRNQS = forms.gettext(textboxBase)
            self:saveSettings()
            forms.destroy(form)
            print("[EndlessKaizo] Settings saved")
        end, gap, buttonY, buttonWidth, buttonHeight)

        -- Cancel button (middle)
        forms.button(form, "Cancel", function()
            forms.destroy(form)
            print("[EndlessKaizo] Cancelled")
        end, gap * 2 + buttonWidth, buttonY, buttonWidth, buttonHeight)

        -- Help button (right)
        forms.button(form, "Help", openHelp, gap * 3 + buttonWidth * 2, buttonY, buttonWidth, buttonHeight)

        y = y + spacing  -- increment y only after placing all buttons

        -- Status Label
        self.statusLabel = forms.label(form, "", labelX, y, 300, 25)
        y = y + spacing

    end

    ------------------------------------------------------------
    -- Settings
    ------------------------------------------------------------

    function self.saveSettings()
        TrackerAPI.saveExtensionSetting(self.name, "baseRNQS", self.Settings.baseRNQS)
        TrackerAPI.saveExtensionSetting(self.name, "lastGeneratedJar", self.Settings.lastGeneratedJar)
        TrackerAPI.saveExtensionSetting(self.name, "currentMonIndex", self.Settings.currentMonIndex)
    end

    local function loadSettings()
        self.Settings.baseRNQS =
            TrackerAPI.getExtensionSetting(self.name, "baseRNQS") or ""
        self.Settings.lastGeneratedJar =
            TrackerAPI.getExtensionSetting(self.name, "lastGeneratedJar") or ""
        self.Settings.currentMonIndex =
            TrackerAPI.getExtensionSetting(self.name, "currentMonIndex") or 1
    end

    ------------------------------------------------------------
    -- Lifecycle
    ------------------------------------------------------------

    function self.startup()
        loadSettings()
        findBestJava()
    end

    function self.configureOptions()
        openOptionsPopup()
    end

    return self
end

return EndlessKaizo