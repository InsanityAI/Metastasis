if Debug then Debug.beginFile "Game/Abilities/Suits/CoreOverload" end
OnInit.trig("CoreOverload", function(require)
    ---@return boolean
    function Trig_Coreoverload_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Coreoverload_Func008Func001Func001C()
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
    function Trig_Coreoverload_Func008Func001C()
        if (not Trig_Coreoverload_Func008Func001Func001C()) then
            return false
        end
        return true
    end

    function Trig_Coreoverload_Func008A()
        if (Trig_Coreoverload_Func008Func001C()) then
            --call KillDestructable( GetEnumDestructable() )
            UnitDamageTarget(GetSpellAbilityUnit(), GetEnumDestructable(), 2550.0, false, false, ATTACK_TYPE_NORMAL,
                DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        else
        end
    end

    function Coreoverload_Explosion()
        udg_TempBool = UnitInSector(GetEnumUnit(), udg_TempInt)
        if udg_TempBool then
            UnitDamageTargetBJ(udg_TempUnit, GetEnumUnit(), 700.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
        else
        end
    end

    function Trig_Coreoverload_Actions()
        local g ---@type group
        local r       = GetSpellAbilityUnit() ---@type unit
        udg_TempUnit  = GetSpellAbilityUnit()
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        CreateNUnitsAtLoc(1, FourCC('e00E'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        SetUnitScalePercent(GetLastCreatedUnit(), 75.00, 75.00, 75.00)
        UnitDamageTargetBJ(r, r, 150.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
        udg_TempInt = GetSector(udg_TempPoint)
        EnumDestructablesInCircleBJ(500.00, udg_TempPoint, Trig_Coreoverload_Func008A)
        udg_TempReal = GetLocationZ(udg_TempPoint)
        if udg_TempReal >= -600.00 then
            TerrainDeformationCraterBJ(0.5, true, udg_TempPoint, 512, 40.00)
        else
        end
        SetUnitTimeScalePercent(
            CreateUnitAtLoc(GetOwningPlayer(udg_TempUnit), FourCC('e01T'), udg_TempPoint, GetRandomDirectionDeg()), 0.0)
        g = GetUnitsInRangeOfLocAll(425.0, udg_TempPoint)
        udg_TempUnit = r
        GroupRemoveUnit(g, udg_TempUnit)
        ForGroup(g, Coreoverload_Explosion)
        DestroyGroup(g)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_Coreoverload = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Coreoverload, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Coreoverload, Condition(Trig_Coreoverload_Conditions))
    TriggerAddAction(gg_trg_Coreoverload, Trig_Coreoverload_Actions)
end)
if Debug then Debug.endFile() end
