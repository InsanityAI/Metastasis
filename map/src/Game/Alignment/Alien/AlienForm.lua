if Debug then Debug.beginFile "Game/Allignment/Alien/AlienForm" end
OnInit.trigg("AlienForm", function(require)
    ---@return boolean
    function Trig_AlienForm_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02O'))) then
            return false
        end
        if (not (udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then
            return false
        end
        return true
    end

    function Trig_AlienForm_Actions()
        local c ---@type unit
        -- Hide the personnel!
        ShowUnitHide(GetSpellAbilityUnit())
        -- Set temp point to the position of the caster.
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        -- Dummy explosion 9 is an egg. Create it, make sure it plays its death animation, and execute Remove2 which will remove it in 2 seconds.
        CreateNUnitsAtLoc(1, FourCC('e00H'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        udg_TempUnit = GetLastCreatedUnit()
        Remove2()
        -- Create the alien current form at temppoint!
        CreateNUnitsAtLoc(1, udg_AlienCurrentForm, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint,
            GetUnitFacing(GetSpellAbilityUnit()))
        -- Adjust relative life and mana percentages.
        SetUnitLifePercentBJ(GetLastCreatedUnit(), GetUnitLifePercent(GetSpellAbilityUnit()))
        SetUnitManaPercentBJ(GetLastCreatedUnit(), GetUnitManaPercent(GetSpellAbilityUnit()))
        -- Select it for the owner of the casting unit, who will always be the parasite.
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetOwningPlayer(GetSpellAbilityUnit()))
        -- Set AlienForm_Alien, playerhero for neutral extra, playerhero for parasite player to the alien.
        udg_AlienForm_Alien = GetLastCreatedUnit()
        udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
        udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
        -- Transfer items and remove caster.
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            UnitAddItemSwapped(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), GetLastCreatedUnit())
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        SetUnitPositionLoc(GetSpellAbilityUnit(), udg_HoldZone)
        RemoveUnit(GetSpellAbilityUnit())
        -- Create the ALIEN SHOP WORKAROUND!
        CreateNUnitsAtLoc(1, FourCC('e00L'), udg_Parasite, udg_HoldZone, bj_UNIT_FACING)
        udg_Alien_ShopWorkaround = GetLastCreatedUnit()
        EnableTrigger(gg_trg_AlienAdjustShop)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_AlienForm = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AlienForm, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_AlienForm, Condition(Trig_AlienForm_Conditions))
    TriggerAddAction(gg_trg_AlienForm, Trig_AlienForm_Actions)
end)
if Debug then Debug.endFile() end
