if Debug then Debug.beginFile "Game/Spaceships/SSThorlarFunctions" end
OnInit.map("SSThorlarFunctions", function(require)
    LIBRARY_ThorlarSpaceships = true
    local SCOPE_PREFIX = "ThorlarSpaceships_" ---@type string

    ---@param spaceshipInteriorRect rect
    ---@return integer
    function GetSpaceshipIndexFromRect(spaceshipInteriorRect)
        local i = 0 ---@type integer

        while i <= 12 do
            if (spaceshipInteriorRect == udg_SpaceshipRect[i]) then
                return i
            end
            i = i + 1
        end

        i = -1
        return i
    end

    ---@param spaceshipUnit unit
    ---@return integer
    function GetSpaceshipIndexFromSpaceshipUnit(spaceshipUnit)
        local i = 0 ---@type integer

        while i <= 12 do
            if (spaceshipUnit == udg_SpaceshipGround[i] or spaceshipUnit == udg_SpaceshipSpace[i]) then
                return i
            end
            i = i + 1
        end

        i = -1
        return i
    end

    ---@param spaceshipInteriorX real
    ---@param spaceshipInteriorY real
    ---@return integer
    function GetSpaceshipIndexFromCoords(spaceshipInteriorX, spaceshipInteriorY)
        local i = 0 ---@type integer

        while i <= 12 do
            if (RectContainsCoords(udg_SpaceshipRect[i], spaceshipInteriorX, spaceshipInteriorY)) then
                return i
            end
            i = i + 1
        end

        i = -1
        return i
    end

    ---@param spaceshipInterior location
    ---@return integer
    function GetSpaceshipIndexFromPosition(spaceshipInterior)
        return GetSpaceshipIndexFromCoords(GetLocationX(spaceshipInterior), GetLocationY(spaceshipInterior))
    end
end)
if Debug then Debug.endFile() end
