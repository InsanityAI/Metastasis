if Debug then Debug.beginFile "Game/Abilities/Mutant/SpatialBurst" end
OnInit.trig("SpatialBurst", function(require)
    ---@return boolean
    function Trig_SpatialBurst_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02M'))) then
            return false
        end
        return true
    end

    function Trig_SpatialBurst_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        local b = GetSpellTargetUnit() ---@type unit
        PolledWait(0.1)

        udg_TempPoint = GetUnitLoc(b)
        udg_TempPoint2 = GetUnitLoc(a)
        if TerrainLineCheck(udg_TempPoint, udg_TempPoint2, 30) then
            if RectContainsLoc(gg_rct_Timeout, udg_TempPoint) == false then
                SetUnitPositionLoc(a, udg_TempPoint)
            end
        end
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_SpatialBurst = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SpatialBurst, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SpatialBurst, Condition(Trig_SpatialBurst_Conditions))
    TriggerAddAction(gg_trg_SpatialBurst, Trig_SpatialBurst_Actions)
end)
if Debug then Debug.endFile() end
