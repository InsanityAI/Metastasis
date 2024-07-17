if Debug then Debug.beginFile "Game/Abilities/Alien/NightOfTheMasks" end
OnInit.trig("NightOfTheMasks", function(require)
    ---@return boolean
    function Trig_NightOfTheMasks_Func002C()
        if ((true == true)) then
            return true
        end
        if ((udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == GetSpellTargetUnit())) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03K'))) then
            return false
        end
        if (not Trig_NightOfTheMasks_Func002C()) then
            return false
        end
        if (not (udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func016C()
        if (not (udg_TempPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func021C()
        if (not (IsUnitType(udg_TempUnit2, UNIT_TYPE_STRUCTURE) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func024Func002C()
        if (not (GetItemLevel(udg_TempItemArray[GetForLoopIndexA()]) == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func035C()
        if (not (udg_TempPlayer == udg_Parasite)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func036Func002Func002C()
        if (not (IsUnitType(udg_TempUnit2, UNIT_TYPE_STRUCTURE) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func036Func002C()
        if (not (GetUnitMoveSpeed(udg_TempUnit2) <= 120.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func036C()
        if (not (GetUnitTypeId(udg_TempUnit2) == FourCC('h01C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func037C()
        if (not (IsUnitType(udg_TempUnit2, UNIT_TYPE_MECHANICAL) == true)) then
            return false
        end
        if (not (GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit2)) <= 12)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func038Func003C()
        if ((udg_TempUnit2 == gg_unit_h02S_0215)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h02K_0204)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h02K_0203)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h02I_0183)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0041)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0043)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0002)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0016)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0041)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0044)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0163)) then
            return true
        end
        if ((udg_TempUnit2 == gg_unit_h001_0162)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_NightOfTheMasks_Func038C()
        if (not Trig_NightOfTheMasks_Func038Func003C()) then
            return false
        end
        return true
    end

    function Trig_NightOfTheMasks_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempUnit2 = GetSpellTargetUnit()
        udg_TempReal = 60.00
        udg_TempUnitType = FourCC('e015')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
        udg_TempReal = GetUnitFacing(GetSpellAbilityUnit())
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl")
        SFXThreadClean()
        if (Trig_NightOfTheMasks_Func016C()) then
            udg_TempPlayer = udg_Parasite
        else
        end
        udg_Player_Masquerade_Life[GetConvertedPlayerId(udg_TempPlayer)] = GetUnitLifePercent(GetSpellAbilityUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempItemArray[GetForLoopIndexA()] = UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA())
            SaveItemHandle(LS(), GetHandleId(udg_TempPlayer), StringHash("mitem_" .. I2S(bj_forLoopAIndex)),
                udg_TempItemArray[bj_forLoopAIndex])
            SetItemPositionLoc(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), udg_HoldZone)
            UnitRemoveItemFromSlotSwapped(GetForLoopIndexA(), GetSpellAbilityUnit())
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        -- Delete masquerade and copypaste the targeted unit
        RemoveUnit(GetSpellAbilityUnit())
        if (Trig_NightOfTheMasks_Func021C()) then
            SetMasqueradeShop(udg_TempUnit2) --Caches the shop for later ESC usage
            udg_TempPoint = GetUnitLoc(udg_TempUnit2)
            udg_TempReal = GetUnitFacing(udg_TempUnit2)
            ShowUnitHide(udg_TempUnit2)
        else
        end
        udg_TempUnit = CloneUnit(udg_TempUnit2, udg_TempPlayer, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint),
            udg_TempReal)
        ResetUnitAnimation(udg_TempUnit)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempItemArray[GetForLoopIndexA()] = UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA())
            if (Trig_NightOfTheMasks_Func024Func002C()) then
                RemoveItem(udg_TempItemArray[GetForLoopIndexA()])
            else
                SaveItemHandle(LS(), GetHandleId(GetOwningPlayer(udg_TempUnit)),
                    StringHash("kitem_" .. I2S(bj_forLoopAIndex)), udg_TempItemArray[bj_forLoopAIndex])
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveLocation(udg_TempPoint)
        udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerName(udg_TempPlayer)
        SelectUnitForPlayerSingle(udg_TempUnit, udg_TempPlayer)
        udg_TempString = GetPlayerName(GetOwningPlayer(udg_TempUnit2))
        SetPlayerName(udg_TempPlayer, udg_TempString)
        udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = udg_TempUnit
        udg_Player_MasqueradeColor[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerColor(udg_TempPlayer)
        SetPlayerColorBJ(udg_TempPlayer, GetPlayerColor(GetOwningPlayer(udg_TempUnit2)), true)
        udg_Player_IsMasquerading[GetConvertedPlayerId(udg_TempPlayer)] = true
        udg_Player_MasqueradeTarget[GetConvertedPlayerId(udg_TempPlayer)] = GetOwningPlayer(udg_TempUnit2)
        if (Trig_NightOfTheMasks_Func035C()) then
        else
        end
        if (Trig_NightOfTheMasks_Func036C()) then
            CrabTeleport(GetLastCreatedUnit())
        else
            -- Check for barrel, cage, health regen, whatever
            if (Trig_NightOfTheMasks_Func036Func002C()) then
                SetUnitMoveSpeed(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)], 120.00)
                if (Trig_NightOfTheMasks_Func036Func002Func002C()) then
                    SetUnitTimeScalePercent(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)], 0.00)
                else
                end
            else
            end
        end
        if (Trig_NightOfTheMasks_Func037C()) then
            Masquerade_MutantEnd(udg_TempPlayer)
        else
        end
        if (Trig_NightOfTheMasks_Func038C()) then
            SetUnitTimeScalePercent(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)], 0.00)
            Masquerade_MutantEnd(udg_TempPlayer)
        else
        end
    end

    --===========================================================================
    gg_trg_NightOfTheMasks = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NightOfTheMasks, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_NightOfTheMasks, Condition(Trig_NightOfTheMasks_Conditions))
    TriggerAddAction(gg_trg_NightOfTheMasks, Trig_NightOfTheMasks_Actions)
end)
if Debug then Debug.endFile() end
