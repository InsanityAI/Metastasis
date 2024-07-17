if Debug then Debug.beginFile "IsTerrainWalkable" end -- Replaces IsPointPathable
OnInit.module("IsTerrainWalkable", function()
    --[[**
    * IsTerrainWalkable snippet for estimating the walkability status of a co-ordinate pair, credits
    * to Anitarf and Vexorian.
    *
    * API:
    *     boolean IsTerrainWalkable(real x, real y) - returns the walkability of (x,y)
    *]]

    local MAX_RANGE = 10. -- constant

    local hidden = {} ---@type item[]
    local r ---@type rect
    local check ---@type item
    CHECKER_UNIT_PEASANT = nil ---@type unit

    ---@param x number
    ---@param y number
    ---@param checkerUnit unit?
    ---@return boolean
    function IsTerrainWalkable(x, y, checkerUnit)
        -- before doing stuff, check if terrain is walk pathable
        if IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) then -- if not pathable return false.
            return false
        end

        -- first, hide any items in the area so they don't get in the way of our item
        MoveRectTo(r, x, y)
        EnumItemsInRect(r, nil, function()
            if IsItemVisible(GetEnumItem()) then
                table.insert(hidden, GetEnumItem())
                SetItemVisible(GetEnumItem(), false)
            end
        end)

        -- try to move the check item and get its coordinates
        local X, Y
        if checkerUnit then
            -- this unhides the unit
            SetUnitPosition(checkerUnit, x, y)
            X, Y = GetUnitX(checkerUnit), GetUnitY(checkerUnit)
            -- ... so we must hide it again
            ShowUnit(checkerUnit, false)
        else
            -- this unhides the item...
            SetItemPosition(check, x, y)
            X, Y = GetItemX(check), GetItemY(check)
            -- ...so we must hide it again
            SetItemVisible(check, false)
        end

        -- before returning, unhide any items that got hidden at the start
        for i, hiddenItem in ipairs(hidden) do
            SetItemVisible(hiddenItem, true)
            hidden[i] = nil
        end

        -- return pathability status
        return (x - X) * (x - X) + (y - Y) * (y - Y) < MAX_RANGE * MAX_RANGE
    end

    local function initialize()
        check = CreateItem(FourCC('ciri'), 0., 0.)
        SetItemVisible(check, false)
        r = Rect(0.0, 0.0, 128.0, 128.0)
        CHECKER_UNIT_PEASANT = CreateUnit(Player(bj_PLAYER_NEUTRAL_EXTRA), FourCC('hpea'), 0.00, 0.00, bj_UNIT_FACING)
        ShowUnit(CHECKER_UNIT_PEASANT, false)
    end

    if OnInit then OnInit.main("IsTerrainWalkable", initialize) end
end)
if Debug then Debug.endFile() end
