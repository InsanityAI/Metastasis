if Debug then Debug.beginFile "Game/Abilities/Space/LifeformScan" end
OnInit.trigg("LifeformScan", function(require)
    ---@return boolean
    function Trig_LifeformScan_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04X'))) then
            return false
        end
        return true
    end

    function DeterminePlayerheroIncrease()
        if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit() then
            udg_TempInt = udg_TempInt + 1
        end
    end

    function DetermineExplorerIncrease()
        if IsUnitExplorer(GetEnumUnit()) then
            udg_TempInt = udg_TempInt + 1
        end
    end

    --Could "optimize" the above, by having only one group, since first function takes only ships and units
    --and so, i could enumerate them together. But it will be a bit harder to read, and also should take time to bugfix -_-


    function Trig_LifeformScan_Actions()
        local a           = GetSpellTargetUnit() ---@type unit
        local b           = GetOwningPlayer(GetSpellAbilityUnit()) ---@type player
        local stationRect = udg_SpaceObject_Rect[GetUnitAN(GetSpellTargetUnit())] ---@type rect
        local scanDelay   = ((GetRectWidthBJ(stationRect) * GetRectHeightBJ(stationRect)) / 15000000.00) ---@type real
        local unitsWithinRect ---@type group
        local lifeformCount ---@type integer
        local explorerCount ---@type integer

        if b == Player(bj_PLAYER_NEUTRAL_EXTRA) then
            b = udg_Parasite
        end

        if stationRect ~= nil then
            --Players inside
            DisplayTextToPlayer(b, 0, 0, "|cff00FFFFScanning...Estimated time " .. R2S(scanDelay) .. " seconds.")
            udg_TempInt = 0
            unitsWithinRect = GetUnitsInRectAndShips(stationRect)
            ForGroupBJ(unitsWithinRect, DeterminePlayerheroIncrease)
            DestroyGroup(unitsWithinRect)
            lifeformCount = udg_TempInt

            --Ships inside
            udg_TempInt = 0
            unitsWithinRect = GetUnitsInRectAll(stationRect)
            ForGroupBJ(unitsWithinRect, DetermineExplorerIncrease)
            DestroyGroup(unitsWithinRect)
            explorerCount = udg_TempInt

            PolledWait(scanDelay)
            DisplayTextToPlayer(b, 0, 0,
                "|cff00FFFFSensors have detected |r|cffFF0000" .. I2S(lifeformCount) ..
                " |r|cff00FFFFlifeforms, and |r|cffF4A460" .. I2S(explorerCount) ..
                " |r|cff00FFFFexplorers within target.")
        else
            DisplayTextToPlayer(b, 0, 0, "An error has occurred.")
        end
    end

    --===========================================================================
    gg_trg_LifeformScan = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_LifeformScan, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_LifeformScan, Condition(Trig_LifeformScan_Conditions))
    TriggerAddAction(gg_trg_LifeformScan, Trig_LifeformScan_Actions)
end)
if Debug then Debug.endFile() end
