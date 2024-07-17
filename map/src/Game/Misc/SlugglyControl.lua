if Debug then Debug.beginFile "Game/Misc/SlugglyControl" end
OnInit.trig("SlugglyControl", function(require)
    ---@return boolean
    function Trig_SlugglyControl_Conditions()
        if (not (udg_Player_Slugglied[GetConvertedPlayerId(GetTriggerPlayer())] ~= true)) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SlugglyControl_Func017Func002C()
        if ((udg_TempUnit == nil)) then
            return true
        end
        if ((IsUnitDeadBJ(udg_TempUnit) == true)) then
            return true
        end
        if ((RectContainsUnit(gg_rct_Cage4, udg_TempUnit) == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_SlugglyControl_Func017C()
        if (not Trig_SlugglyControl_Func017Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SlugglyControl_Func018Func001C()
        if (not (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    function Trig_SlugglyControl_Func018A()
        if (Trig_SlugglyControl_Func018Func001C()) then
            SetPlayerAllianceStateBJ(GetEnumPlayer(), GetTriggerPlayer(), bj_ALLIANCE_ALLIED)
            SetPlayerAllianceStateBJ(GetTriggerPlayer(), GetEnumPlayer(), bj_ALLIANCE_ALLIED)
        else
        end
    end

    function Trig_SlugglyControl_Actions()
        udg_Player_Slugglied[GetConvertedPlayerId(GetTriggerPlayer())] = true
        udg_TempUnit = GroupPickRandomUnit(GetUnitsOfPlayerAndTypeId(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('n003')))
        if (Trig_SlugglyControl_Func017C()) then
            DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, "Oops! Try again.")
            return
        else
        end
        ForForce(GetPlayersAll(), Trig_SlugglyControl_Func018A)
        SetUnitOwner(udg_TempUnit, GetTriggerPlayer(), true)
        PanCameraToTimedLocForPlayer(GetTriggerPlayer(), GetUnitLoc(udg_TempUnit), 0)
        SelectUnitForPlayerSingle(udg_TempUnit, GetTriggerPlayer())
        SetUnitMoveSpeed(udg_TempUnit, 330.00)
        UnitAddAbilityBJ(FourCC('A02I'), udg_TempUnit)
        UnitAddAbilityBJ(FourCC('AIl2'), udg_TempUnit)
    end

    --===========================================================================
    gg_trg_SlugglyControl = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(0), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(1), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(2), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(3), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(4), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(5), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(6), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(7), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(8), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(9), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(10), "-iamthesluggly", true)
    TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(11), "-iamthesluggly", true)
    TriggerAddCondition(gg_trg_SlugglyControl, Condition(Trig_SlugglyControl_Conditions))
    TriggerAddAction(gg_trg_SlugglyControl, Trig_SlugglyControl_Actions)
end)
if Debug then Debug.endFile() end
