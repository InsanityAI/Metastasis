if Debug then Debug.beginFile "System/Anonymity" end
OnInit.map("System/Anonymity", function(require)
    require "SetUtils"

    ---@class Anonymity
    Anonymity = {}
    Anonymity.shuffledPlayers = Set.create()

    local colorSet = Set.create(
        { color = PLAYER_COLOR_RED, name = "Red" },
        { color = PLAYER_COLOR_BLUE, name = "Blue" },
        { color = PLAYER_COLOR_TURQUOISE, name = "Teal" },
        { color = PLAYER_COLOR_PURPLE, name = "Purple" },
        { color = PLAYER_COLOR_YELLOW, name = "Yellow" },
        { color = PLAYER_COLOR_ORANGE, name = "Orange" },
        { color = PLAYER_COLOR_GREEN, name = "Green" },
        { color = PLAYER_COLOR_PINK, name = "Pink" },
        { color = PLAYER_COLOR_LIGHT_GRAY, name = "Gray" },
        { color = PLAYER_COLOR_LIGHT_BLUE, name = "Light blue" },
        { color = PLAYER_COLOR_AQUA, name = "Dark green" },
        { color = PLAYER_COLOR_BROWN, name = "Brown" },
        { color = PLAYER_COLOR_MAROON, name = "Maroon" },
        { color = PLAYER_COLOR_NAVY, name = "Navy" },
        { color = PLAYER_COLOR_TURQUOISE, name = "Turquoise" },
        { color = PLAYER_COLOR_VIOLET, name = "Violet" },
        { color = PLAYER_COLOR_WHEAT, name = "Wheat" },
        { color = PLAYER_COLOR_PEACH, name = "Peach" },
        { color = PLAYER_COLOR_MINT, name = "Mint" },
        { color = PLAYER_COLOR_LAVENDER, name = "Lavander" },
        { color = PLAYER_COLOR_COAL, name = "Coal" },
        { color = PLAYER_COLOR_SNOW, name = "Snow" },
        { color = PLAYER_COLOR_EMERALD, name = "Emerald" },
        { color = PLAYER_COLOR_PEANUT, name = "Peanut" }
    )

    local allPlayers = SetUtils:getPlayersAll()
    local size = allPlayers.n
    for i = 1, size do
        local randomPlayer = allPlayers:random()
        allPlayers:removeSingle(randomPlayer)
        Anonymity.shuffledPlayers:add(randomPlayer)

        local randomColor = colorSet:random()
        colorSet:removeSingle(randomColor)
        SetPlayerColor(randomPlayer, randomColor.color)
        SetPlayerName(randomPlayer, randomColor.name)
    end
end)
if Debug then Debug.endFile() end
