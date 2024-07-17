if Debug then Debug.beginFile "Game/Abilities/Items/GIT" end
OnInit.trig("GIT", function(require)
    ---@return boolean
    function Trig_GIT_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A018'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_GIT_Func004Func001C()
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h00B'))) then
            return true
        end
        if ((IsPlayerInForce(GetOwningPlayer(GetSpellTargetUnit()), udg_GIT_TesterGroup[GetItemUserData(udg_TempItem)]) == true)) then
            return true
        end
        if ((udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] ~= GetSpellTargetUnit())) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_GIT_Func004Func005Func001Func003C()
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == true)) then
            return true
        end
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == true)) then
            return true
        end
        if ((GetOwningPlayer(GetSpellTargetUnit()) == udg_Parasite)) then
            return true
        end
        if ((GetOwningPlayer(GetSpellTargetUnit()) == udg_Mutant)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_GIT_Func004Func005Func001C()
        if (not Trig_GIT_Func004Func005Func001Func003C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_GIT_Func004C()
        if (not Trig_GIT_Func004Func001C()) then
            return false
        end
        return true
    end

    function Trig_GIT_Actions()
        udg_TempItem = GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I00M'))
        if (GetItemUserData(udg_TempItem) == 0) then
            udg_GIT_TesterOn = (udg_GIT_TesterOn + 1)
            SetItemUserData(udg_TempItem, udg_GIT_TesterOn)
            udg_GIT_TesterGroup[GetItemUserData(udg_TempItem)] = CreateForce()
            udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] = 1
        end
        if (Trig_GIT_Func004C()) then
            DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 5.00, "TRIGSTR_3178")
            SetItemCharges(udg_TempItem, (GetItemCharges(udg_TempItem) + 1))
        else
            ForceAddPlayerSimple(GetOwningPlayer(GetSpellTargetUnit()),
                udg_GIT_TesterGroup[GetItemUserData(udg_TempItem)])
            DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 5.00, "TRIGSTR_3177")
            udg_GIT_TesterString[GetItemUserData(udg_TempItem)] = (udg_GIT_TesterString[GetItemUserData(udg_TempItem)] + (GetPlayerName(GetOwningPlayer(GetSpellTargetUnit())) .. "\n"))
            if (udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] ~= 3) then
                if (Trig_GIT_Func004Func005Func001C()) then
                    udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] = 2
                else
                    if (GetOwningPlayer(GetSpellTargetUnit()) == udg_HiddenAndroid) then
                        udg_GIT_TesterStatus[GetItemUserData(udg_TempItem)] = 3
                    end
                end
            end
        end
        if (GetItemCharges(udg_TempItem) <= 1) then
            udg_TempInt = GetItemUserData(udg_TempItem)
            RemoveItem(udg_TempItem)
            CreateItemLoc(FourCC('I019'), udg_HoldZone)
            UnitAddItemByIdSwapped(FourCC('I019'), GetTriggerUnit())
            SetItemUserData(GetLastCreatedItem(), udg_TempInt)
        end
    end

    --===========================================================================
    gg_trg_GIT = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GIT, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_GIT, Condition(Trig_GIT_Conditions))
    TriggerAddAction(gg_trg_GIT, Trig_GIT_Actions)
end)
if Debug then Debug.endFile() end
