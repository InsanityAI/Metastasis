if Debug then Debug.beginFile "Game/PureBugfixes/TetrabinBugfix" end
OnInit.trig("TetrabinBugfix", function(require)
    ---@return boolean
    function Trig_Tetrabin_Bugfix_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01K'))) then
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
        if (not (GetPlayerTechCountSimple(FourCC('R00A'), GetOwningPlayer(GetTriggerUnit())) >= 15)) then
            return false
        end
        return true
    end

    function Trig_Tetrabin_Bugfix_Actions()
        ExplodeUnitBJ(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))])
    end

    --===========================================================================
    gg_trg_Tetrabin_Bugfix = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Tetrabin_Bugfix, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Tetrabin_Bugfix, Condition(Trig_Tetrabin_Bugfix_Conditions))
    TriggerAddAction(gg_trg_Tetrabin_Bugfix, Trig_Tetrabin_Bugfix_Actions)
end)
if Debug then Debug.endFile() end
