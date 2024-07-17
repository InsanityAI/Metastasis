if Debug then Debug.beginFile "Game/Stations/Planet/PlanetDamagePerSecond" end
OnInit.trig("PlanetDamagePerSecond", function(require)
    ---@return boolean
    function Trig_PlanetDamagePerSecond_Conditions()
        if (not (udg_MinerthaDamagePerSecond > 0.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlanetDamagePerSecond_Func005Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('n003'))) then
            return false
        end
        return true
    end

    function Trig_PlanetDamagePerSecond_Func005A()
        if (Trig_PlanetDamagePerSecond_Func005Func001C()) then
            UnitDamageTargetBJ(GetEnumUnit(), GetEnumUnit(), udg_MinerthaDamagePerSecond, ATTACK_TYPE_NORMAL,
                DAMAGE_TYPE_NORMAL)
        else
        end
    end

    function Trig_PlanetDamagePerSecond_Actions()
        udg_MinerthaDamagePerSecond = (udg_MinerthaDamagePerSecond * 0.99)
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Planet)
        ForGroupBJ(udg_TempUnitGroup, Trig_PlanetDamagePerSecond_Func005A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_PlanetDamagePerSecond = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_PlanetDamagePerSecond, 1.00)
    TriggerAddCondition(gg_trg_PlanetDamagePerSecond, Condition(Trig_PlanetDamagePerSecond_Conditions))
    TriggerAddAction(gg_trg_PlanetDamagePerSecond, Trig_PlanetDamagePerSecond_Actions)
end)
if Debug then Debug.endFile() end
