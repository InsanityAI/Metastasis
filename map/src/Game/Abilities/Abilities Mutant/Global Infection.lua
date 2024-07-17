if Debug then Debug.beginFile "Game/Abilities/Mutant/GlobalInfection" end
OnInit.trig("GlobalInfection", function(require)
    ---@return boolean
    function Trig_Global_Infection_Func002C()
        if ((udg_Mutant == GetOwningPlayer(GetTriggerUnit()))) then
            return true
        end
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Global_Infection_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A067'))) then
            return false
        end
        if (not Trig_Global_Infection_Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Global_Infection_Func005Func001Func001Func005C()
        if ((udg_Mutant == GetOwningPlayer(GetEnumUnit()))) then
            return true
        end
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Global_Infection_Func005Func001Func001C()
        if (not Trig_Global_Infection_Func005Func001Func001Func005C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Global_Infection_Func005Func001Func002C()
        if ((GetUnitRace(GetEnumUnit()) == RACE_ORC)) then
            return true
        end
        if ((GetUnitRace(GetEnumUnit()) == RACE_UNDEAD)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Global_Infection_Func005Func001C()
        if (not Trig_Global_Infection_Func005Func001Func002C()) then
            return false
        end
        return true
    end

    function Trig_Global_Infection_Func005A()
        if (Trig_Global_Infection_Func005Func001C()) then
            if (Trig_Global_Infection_Func005Func001Func001C()) then
            else
                udg_TempLoc3 = GetUnitLoc(GetEnumUnit())
                CreateNUnitsAtLoc(1, FourCC('e03H'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempLoc3,
                    bj_CAMERA_DEFAULT_ROLL)
                UnitApplyTimedLifeBJ(2.00, FourCC('BTLF'), GetLastCreatedUnit())
                IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", GetEnumUnit())
            end
        else
        end
    end

    function Trig_Global_Infection_Actions()
        udg_Global_Infection_group = GetUnitsInRectAll(GetPlayableMapRect())
        ForGroupBJ(udg_Global_Infection_group, Trig_Global_Infection_Func005A)
        GroupRemoveGroup(udg_Global_Infection_group, udg_Global_Infection_group)
        DestroyGroup(udg_Global_Infection_group)
        RemoveLocation(udg_TempLoc3)
    end

    --===========================================================================
    gg_trg_Global_Infection = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Global_Infection, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Global_Infection, Condition(Trig_Global_Infection_Conditions))
    TriggerAddAction(gg_trg_Global_Infection, Trig_Global_Infection_Actions)
end)
if Debug then Debug.endFile() end
