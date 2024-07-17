if Debug then Debug.beginFile "Game/Stations/ST4/ResetPowerBonus" end
OnInit.trig("ResetPowerBonus", function(require)
    function Trig_ResetPowerBonus_Func001Func002A()
        RemoveUnit(GetEnumUnit())
    end

    ---@return boolean
    function Trig_ResetPowerBonus_Func001C()
        if (not (udg_Power_Bonus == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ResetPowerBonus_Func002Func001Func001C()
        if not (IsUnitExplorer(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_ResetPowerBonus_Func002Func001A()
        if (Trig_ResetPowerBonus_Func002Func001Func001C()) then
            UnitRemoveAbilityBJ(FourCC('A06K'), GetEnumUnit())
            UnitRemoveAbilityBJ(FourCC('A06J'), GetEnumUnit())
            UnitRemoveAbilityBJ(FourCC('A06I'), GetEnumUnit())
        else
        end
    end

    ---@return boolean
    function Trig_ResetPowerBonus_Func002C()
        if (not (udg_Power_Bonus == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ResetPowerBonus_Func003Func002Func001C()
        if not (IsUnitStation(GetEnumUnit())) then
            return false
        end
        return true
    end

    function Trig_ResetPowerBonus_Func003Func002A()
        if (Trig_ResetPowerBonus_Func003Func002Func001C()) then
            UnitRemoveAbilityBJ(FourCC('A06L'), GetEnumUnit())
            UnitRemoveAbilityBJ(FourCC('A06M'), GetEnumUnit())
        else
        end
    end

    ---@return boolean
    function Trig_ResetPowerBonus_Func003C()
        if (not (udg_Power_Bonus == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ResetPowerBonus_Func004C()
        if (not (udg_Power_Bonus == 4)) then
            return false
        end
        return true
    end

    function Trig_ResetPowerBonus_Actions()
        if (Trig_ResetPowerBonus_Func001C()) then
            udg_TempUnitGroup = GetUnitsOfTypeIdAll(FourCC('e01U'))
            ForGroupBJ(udg_TempUnitGroup, Trig_ResetPowerBonus_Func001Func002A)
            DestroyGroup(udg_TempUnitGroup)
        else
        end
        if (Trig_ResetPowerBonus_Func002C()) then
            ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_ResetPowerBonus_Func002Func001A)
        else
        end
        if (Trig_ResetPowerBonus_Func003C()) then
            DecUnitAbilityLevelSwapped(FourCC('A005'), gg_unit_h007_0027)
            ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_ResetPowerBonus_Func003Func002A)
        else
        end
        if (Trig_ResetPowerBonus_Func004C()) then
            DisableTrigger(gg_trg_LaboratorySpawnExperiments)
            ResetUnitAnimation(gg_unit_h049_0139)
            udg_TempUnit = gg_unit_h049_0139
            PauseUnitForPeriod(udg_TempUnit, 99999999.0)
            PacificationBotDisable()
        else
        end
    end

    --===========================================================================
    gg_trg_ResetPowerBonus = CreateTrigger()
    TriggerAddAction(gg_trg_ResetPowerBonus, Trig_ResetPowerBonus_Actions)
end)
if Debug then Debug.endFile() end
