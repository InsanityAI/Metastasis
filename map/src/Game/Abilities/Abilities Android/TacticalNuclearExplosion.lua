if Debug then Debug.beginFile "Game/Abilities/Android/TacticalNuclearExplosion" end
OnInit.map("TacticalNuclearExplosion", function(require)
    ---@return boolean
    function Trig_TacticalNuclearExplosion_Func006Func002C()
        if (not (udg_TempBool == true)) then
            return false
        end
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h03A'))) then
            return false
        end
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h03B'))) then
            return false
        end
        return true
    end

    function Trig_TacticalNuclearExplosion_Func006A()
        udg_TempBool = UnitInSector(GetEnumUnit(), udg_TempInt)
        if (Trig_TacticalNuclearExplosion_Func006Func002C()) then
            UnitDamageTargetBJ(udg_TempUnit4, GetEnumUnit(), 7000.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
        else
        end
    end

    ---@return boolean
    function Trig_TacticalNuclearExplosion_Func007Func001Func001C()
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('DTrx'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT40'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT16'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT06'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT30'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TacticalNuclearExplosion_Func007Func001C()
        if (not Trig_TacticalNuclearExplosion_Func007Func001Func001C()) then
            return false
        end
        return true
    end

    function Trig_TacticalNuclearExplosion_Func007A()
        if (Trig_TacticalNuclearExplosion_Func007Func001C()) then
            KillDestructable(GetEnumDestructable())
        else
        end
    end

    function Trig_TacticalNuclearExplosion_Actions()
        local a = udg_CountupBarTemp ---@type unit
        if udg_Android_Deactivated == true and udg_HiddenAndroid == GetOwningPlayer(a) then
            return
        end
        udg_TempUnit4 = udg_CountupBarTemp
        udg_TempPoint = GetUnitLoc(udg_TempUnit4)
        CreateNUnitsAtLoc(1, FourCC('e00E'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        SetUnitTimeScalePercent(GetLastCreatedUnit(), 50.00)
        udg_TempInt = GetSector(udg_TempPoint)
        ForGroupBJ(GetUnitsInRangeOfLocAll(850.00, udg_TempPoint), Trig_TacticalNuclearExplosion_Func006A)
        EnumDestructablesInCircleBJ(900.00, udg_TempPoint, Trig_TacticalNuclearExplosion_Func007A)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_TacticalNuclearExplosion = CreateTrigger()
    TriggerAddAction(gg_trg_TacticalNuclearExplosion, Trig_TacticalNuclearExplosion_Actions)
end)
if Debug then Debug.endFile() end
