if Debug then Debug.beginFile "Game/Allignment/Alien/HumanFormSpawn" end
OnInit.map("HumanFormSpawn", function(require)
    ---@return boolean
    function Trig_HumanFormSpawn_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02X'))) then
            return false
        end
        if (not (udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then
            return false
        end
        return true
    end

    function Trig_HumanFormSpawn_Actions()
        local c ---@type unit
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        CreateNUnitsAtLoc(1, FourCC('e00H'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        udg_TempUnit = GetLastCreatedUnit()
        Remove2()
        CreateNUnitsAtLoc(1, FourCC('h00H'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetLastCreatedUnit()))] = GetLastCreatedUnit()
        udg_TempUnit = GetLastCreatedUnit()
        c = udg_TempUnit
        SetUnitPositionLoc(GetSpellAbilityUnit(), udg_HoldZone)
        SetUnitLifePercentBJ(udg_TempUnit, GetUnitLifePercent(GetSpellAbilityUnit()))
        SetUnitManaPercentBJ(udg_TempUnit, GetUnitManaPercent(GetSpellAbilityUnit()))
        udg_TempUnit = c
        SetUnitPositionLoc(udg_TempUnit, udg_TempPoint)
        udg_TempUnit = c
        SelectUnitForPlayerSingle(udg_TempUnit, udg_TempPlayer)
        UnitAddAbilityBJ(udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))]],
            GetLastCreatedUnit())
        UnitAddAbilityBJ(FourCC('A02W'), GetLastCreatedUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempUnit = c
            UnitAddItemSwapped(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), udg_TempUnit)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveUnit(GetSpellAbilityUnit())
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_HumanFormSpawn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HumanFormSpawn, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_HumanFormSpawn, Condition(Trig_HumanFormSpawn_Conditions))
    TriggerAddAction(gg_trg_HumanFormSpawn, Trig_HumanFormSpawn_Actions)
end)
if Debug then Debug.endFile() end
