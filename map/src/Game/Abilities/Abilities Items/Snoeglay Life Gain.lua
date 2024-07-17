if Debug then Debug.beginFile "Game/Abilities/Items/SnoeglayLifeGain" end
OnInit.map("SnoeglayLifeGain", function(require)
    ---@return boolean
    function Trig_Snoeglay_Life_Gain_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I024'))) then
            return false
        end
        if (not (GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])) then
            return false
        end
        if (not (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false)) then
            return false
        end
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false)) then
            return false
        end
        if (not (udg_HiddenAndroid ~= GetOwningPlayer(GetTriggerUnit()))) then
            return false
        end
        if (not (udg_Mutant ~= GetOwningPlayer(GetTriggerUnit()))) then
            return false
        end
        if (not (udg_Parasite ~= GetOwningPlayer(GetTriggerUnit()))) then
            return false
        end

        udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] = udg_SnoeglayBonus
            [GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] + 1
        if udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 3 then
            udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] = 0
            return true
        else
            return false
        end
    end

    function Trig_Snoeglay_Life_Gain_Actions()
        SetPlayerTechResearchedSwap(FourCC('R00C'),
            (GetPlayerTechCountSimple(FourCC('R00C'), GetOwningPlayer(GetTriggerUnit())) + 1),
            GetOwningPlayer(GetTriggerUnit()))
    end

    --===========================================================================
    gg_trg_Snoeglay_Life_Gain = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Snoeglay_Life_Gain, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Snoeglay_Life_Gain, Condition(Trig_Snoeglay_Life_Gain_Conditions))
    TriggerAddAction(gg_trg_Snoeglay_Life_Gain, Trig_Snoeglay_Life_Gain_Actions)
end)
if Debug then Debug.endFile() end
