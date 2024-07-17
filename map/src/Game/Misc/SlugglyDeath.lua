if Debug then Debug.beginFile "Game/Misc/SlugglyDeath" end
OnInit.triggggg("SlugglyDeath", function(require)
    ---@return boolean
    function Trig_SlugglyDeath_Conditions()
        if (not (FourCC('n003') == GetUnitTypeId(GetDyingUnit()))) then
            return false
        end
        if (not (udg_Player_Slugglied[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SlugglyDeath_Func004Func001C()
        if (not (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    function Trig_SlugglyDeath_Func004A()
        if (Trig_SlugglyDeath_Func004Func001C()) then
            SetPlayerAllianceStateBJ(GetEnumPlayer(), GetTriggerPlayer(), bj_ALLIANCE_ALLIED_VISION)
            SetPlayerAllianceStateBJ(GetTriggerPlayer(), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
            udg_Player_Slugglied[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false
        else
        end
    end

    function Trig_SlugglyDeath_Actions()
        ForForce(GetPlayersAll(), Trig_SlugglyDeath_Func004A)
    end

    --===========================================================================
    gg_trg_SlugglyDeath = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SlugglyDeath, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_SlugglyDeath, Condition(Trig_SlugglyDeath_Conditions))
    TriggerAddAction(gg_trg_SlugglyDeath, Trig_SlugglyDeath_Actions)
end)
if Debug then Debug.endFile() end
