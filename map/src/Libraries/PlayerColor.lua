if Debug then Debug.beginFile("Players Colours") end
OnInit.module("PlayerColor", function(require)
    require "ReadOnly"
    require "typeof"

    local neutralColor = ReadOnly({ colour = "ff2e2d2e", red = 46, green = 45, blue = 46 }) -- Black/Neutral
    local keyType
    ---@class PlayerColor: {[playercolor|player|number]: {colour: string, red: number, green: number, blue: number}}
    PlayerColor = ReadOnly(setmetatable({
        [PLAYER_COLOR_RED]        = ReadOnly({ colour = "ffff0303", red = 255, green = 3, blue = 3 }),     -- Red
        [PLAYER_COLOR_BLUE]       = ReadOnly({ colour = "ff0042ff", red = 0, green = 66, blue = 255 }),    -- Blue
        [PLAYER_COLOR_TURQUOISE]  = ReadOnly({ colour = "ff1ce6b9", red = 28, green = 230, blue = 185 }),  -- Teal
        [PLAYER_COLOR_PURPLE]     = ReadOnly({ colour = "ff540081", red = 84, green = 0, blue = 129 }),    -- Purple
        [PLAYER_COLOR_YELLOW]     = ReadOnly({ colour = "fffffc00", red = 255, green = 254, blue = 0 }),   -- Yellow
        [PLAYER_COLOR_ORANGE]     = ReadOnly({ colour = "fffe8a0e", red = 254, green = 138, blue = 14 }),  -- Orange
        [PLAYER_COLOR_GREEN]      = ReadOnly({ colour = "ff20c000", red = 32, green = 192, blue = 0 }),    -- Green
        [PLAYER_COLOR_PINK]       = ReadOnly({ colour = "ffe55bb0", red = 229, green = 91, blue = 176 }),  -- Pink
        [PLAYER_COLOR_LIGHT_GRAY] = ReadOnly({ colour = "ff959697", red = 149, green = 150, blue = 151 }), -- Gray
        [PLAYER_COLOR_LIGHT_BLUE] = ReadOnly({ colour = "ff7ebff1", red = 126, green = 191, blue = 241 }), -- Light Blue
        [PLAYER_COLOR_AQUA]       = ReadOnly({ colour = "ff106246", red = 16, green = 98, blue = 70 }),    -- Dark Green
        [PLAYER_COLOR_BROWN]      = ReadOnly({ colour = "ff4e2a04", red = 78, green = 42, blue = 4 }),     -- Brown
        [PLAYER_COLOR_MAROON]     = ReadOnly({ colour = "ff9b0000", red = 155, green = 0, blue = 0 }),     -- Maroon
        [PLAYER_COLOR_NAVY]       = ReadOnly({ colour = "ff0000c3", red = 0, green = 0, blue = 195 }),     -- Navy
        [PLAYER_COLOR_TURQUOISE]  = ReadOnly({ colour = "ff00eaff", red = 155, green = 234, blue = 255 }), -- Turquoise
        [PLAYER_COLOR_VIOLET]     = ReadOnly({ colour = "ffbe00fe", red = 190, green = 0, blue = 254 }),   -- Violet
        [PLAYER_COLOR_WHEAT]      = ReadOnly({ colour = "ffebcd87", red = 235, green = 205, blue = 135 }), -- Wheat
        [PLAYER_COLOR_PEACH]      = ReadOnly({ colour = "fff8a48b", red = 248, green = 164, blue = 139 }), -- Peach
        [PLAYER_COLOR_MINT]       = ReadOnly({ colour = "ffbfff80", red = 191, green = 255, blue = 128 }), -- Mint
        [PLAYER_COLOR_LAVENDER]   = ReadOnly({ colour = "ffdcb9eb", red = 220, green = 185, blue = 235 }), -- Lavender
        [PLAYER_COLOR_COAL]       = ReadOnly({ colour = "ff4f5055", red = 79, green = 80, blue = 85 }),    -- Coal
        [PLAYER_COLOR_SNOW]       = ReadOnly({ colour = "ffebf0ff", red = 235, green = 240, blue = 255 }), -- Snow
        [PLAYER_COLOR_EMERALD]    = ReadOnly({ colour = "ff00781e", red = 0, green = 120, blue = 30 }),    -- Emerald
        [PLAYER_COLOR_PEANUT]     = ReadOnly({ colour = "ffa46f33", red = 164, green = 111, blue = 51 }),  -- Peanut
        [ConvertPlayerColor(24)]  = neutralColor,
        [ConvertPlayerColor(25)]  = neutralColor,
        [ConvertPlayerColor(26)]  = neutralColor,
        [ConvertPlayerColor(27)]  = neutralColor
    }, {
        __index = function(t, k)
            keyType = typeof(k)
            if keyType == 'number' then
                return t[GetPlayerColor(Player(k))]
            elseif keyType == 'player' then
                return t[GetPlayerColor(k)]
            elseif keyType == 'playercolor' then
                return t[k]
            else
                error('Unknown type for key \'' .. k .. '\' must be either number, player or playercolor')
            end
        end
    }))

    --Replaces GetPlayerColorTextColor and GetPlayerTextColor
end)
if Debug then Debug.endFile() end
