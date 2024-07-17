if Debug then Debug.beginFile "Game/Allignment/Alien/NoAlienTK" end
OnInit.map("NoAlienTK", function(require)
    ---@return boolean
    function Trig_NoAlienTK_Func002Func002C()
        if ((GetOwningPlayer(GetAttackedUnitBJ()) == udg_Parasite)) then
            return true
        end
        if ((GetOwningPlayer(GetAttackedUnitBJ()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_NoAlienTK_Func002Func003Func002C()
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())])] == true)) then
            return true
        end
        if ((udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())] == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        if ((udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())] == udg_Parasite)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_NoAlienTK_Func002Func003C()
        if (not (GetUnitTypeId(GetAttackedUnitBJ()) == FourCC('h02P'))) then
            return false
        end
        if (not Trig_NoAlienTK_Func002Func003Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NoAlienTK_Func002C()
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == true)) then
            return true
        end
        if (Trig_NoAlienTK_Func002Func002C()) then
            return true
        end
        if (Trig_NoAlienTK_Func002Func003C()) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_NoAlienTK_Conditions()
        if (not (udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))] == true)) then
            return false
        end
        if (not Trig_NoAlienTK_Func002C()) then
            return false
        end
        return true
    end

    function Trig_NoAlienTK_Actions()
        IssueImmediateOrderBJ(GetAttacker(), "stop")
        DisplayTimedTextToPlayer(GetOwningPlayer(GetAttacker()), 0, 0, 30,
            "|cffFF0000You cannot attack your fellow alien!|r")
    end

    --===========================================================================
    gg_trg_NoAlienTK = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NoAlienTK, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_NoAlienTK, Condition(Trig_NoAlienTK_Conditions))
    TriggerAddAction(gg_trg_NoAlienTK, Trig_NoAlienTK_Actions)
end)
if Debug then Debug.endFile() end
