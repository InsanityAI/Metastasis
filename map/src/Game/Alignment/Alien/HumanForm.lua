if Debug then Debug.beginFile "Game/Allignment/Alien/HumanForm" end
OnInit.trig("HumanForm", function(require)
    ---@return boolean
    function Trig_HumanForm_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02S'))) then
            return false
        end
        if (not (udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then
            return false
        end
        return true
    end

    function Trig_HumanForm_Actions()
        local c ---@type unit
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        CreateNUnitsAtLoc(1, FourCC('e00H'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        udg_TempUnit = GetLastCreatedUnit()
        Remove2()
        CreateNUnitsAtLoc(1, FourCC('h00H'), udg_Parasite, udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        c = udg_TempUnit
        SetUnitLifePercentBJ(udg_TempUnit, GetUnitLifePercent(GetSpellAbilityUnit()))
        SetUnitManaPercentBJ(udg_TempUnit, GetUnitManaPercent(GetSpellAbilityUnit()))
        SetUnitPositionLoc(GetSpellAbilityUnit(), udg_HoldZone)
        udg_TempUnit = c
        ShowUnitShow(udg_TempUnit)
        udg_TempUnit = c
        PauseUnitBJ(false, udg_TempUnit)
        udg_TempUnit = c
        UnitRemoveAbilityBJ(FourCC('Avul'), udg_TempUnit)
        udg_TempUnit = c
        SetUnitPositionLoc(udg_TempUnit, udg_TempPoint)
        UnitAddAbilityBJ(FourCC('A02O'), GetLastCreatedUnit())
        -- Will screw up the Dr.'s tooltip. Fix later!
        UnitAddAbilityBJ(udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(udg_Parasite)]], GetLastCreatedUnit())
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit()))
        udg_TempUnit = c
        SelectUnitForPlayerSingle(udg_TempUnit, udg_Parasite)
        udg_AlienForm_Alien = nil
        udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
        udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
        DisableTrigger(gg_trg_AlienAdjustShop)
        RemoveUnit(udg_Alien_ShopWorkaround)
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
    gg_trg_HumanForm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HumanForm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_HumanForm, Condition(Trig_HumanForm_Conditions))
    TriggerAddAction(gg_trg_HumanForm, Trig_HumanForm_Actions)
end)
if Debug then Debug.endFile() end
