if Debug then Debug.beginFile "Game/Allignment/Alien/AlienFormSpawn" end
OnInit.trig("AlienFormSpawn", function(require)
    ---@return boolean
    function Trig_AlienFormSpawn_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02W'))) then
            return false
        end
        if (not (udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then
            return false
        end
        return true
    end

    function Trig_AlienFormSpawn_Actions()
        -- Pretty much the same as AlienForm trigger.
        udg_TempUnit3 = GetSpellAbilityUnit()
        ShowUnitHide(udg_TempUnit3)
        udg_TempPoint = GetUnitLoc(udg_TempUnit3)
        CreateNUnitsAtLoc(1, udg_ParasiteChildInfectee, GetOwningPlayer(udg_TempUnit3), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))] = GetLastCreatedUnit()
        SetUnitLifePercentBJ(GetLastCreatedUnit(), GetUnitLifePercent(GetSpellAbilityUnit()))
        SetUnitManaPercentBJ(GetLastCreatedUnit(), GetUnitManaPercent(GetSpellAbilityUnit()))
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit()))
        SetUnitPositionLoc(GetLastCreatedUnit(), udg_TempPoint)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            UnitAddItemSwapped(UnitItemInSlotBJ(udg_TempUnit3, GetForLoopIndexA()), GetLastCreatedUnit())
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        SetUnitPositionLoc(udg_TempUnit3, udg_HoldZone)
        RemoveUnit(udg_TempUnit3)
        CreateNUnitsAtLoc(1, FourCC('e00H'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        udg_TempUnit = GetLastCreatedUnit()
        Remove2()
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_AlienFormSpawn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AlienFormSpawn, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_AlienFormSpawn, Condition(Trig_AlienFormSpawn_Conditions))
    TriggerAddAction(gg_trg_AlienFormSpawn, Trig_AlienFormSpawn_Actions)
end)
if Debug then Debug.endFile() end
