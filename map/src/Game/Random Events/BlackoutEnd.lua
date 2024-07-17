if Debug then Debug.beginFile "Game/RandomEvents/BlackoutEnd" end
OnInit.trig("BlackoutEnd", function(require)
    function Trig_BlackoutEnd_Func015A()
        FogModifierStart(udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())])
    end

    function Trig_BlackoutEnd_Func016A()
        SetUnitMoveSpeed(GetEnumUnit(), GetUnitDefaultMoveSpeed(GetTriggerUnit()))
        SetUnitOwner(GetEnumUnit(), udg_EscapePod_Owner[GetUnitUserData(GetEnumUnit())], true)
    end

    ---@return boolean
    function Trig_BlackoutEnd_Func017Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_BlackoutEnd_Func017A()
        if (Trig_BlackoutEnd_Func017Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
    end

    ---@return boolean
    function Trig_BlackoutEnd_Func018Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_BlackoutEnd_Func018A()
        if (Trig_BlackoutEnd_Func018Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
    end

    ---@return boolean
    function Trig_BlackoutEnd_Func019Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_BlackoutEnd_Func019A()
        if (Trig_BlackoutEnd_Func019Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
    end

    ---@return boolean
    function Trig_BlackoutEnd_Func020Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_BlackoutEnd_Func020A()
        if (Trig_BlackoutEnd_Func020Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
    end

    ---@return boolean
    function Trig_BlackoutEnd_Func021Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_BlackoutEnd_Func021A()
        if (Trig_BlackoutEnd_Func021Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
    end

    ---@return boolean
    function Trig_BlackoutEnd_Func022Func001C()
        if (not (RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_BlackoutEnd_Func022A()
        if (Trig_BlackoutEnd_Func022Func001C()) then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
    end

    function Trig_BlackoutEnd_Actions()
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4613")
        PolledWait(2.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4614")
        PolledWait(2.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4615")
        PolledWait(2.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4616")
        PolledWait(2.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4617")
        udg_Blackout = false
        PolledWait(2.00)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2571")
        DestroyTimerDialogBJ(udg_BlackoutTimerWindow)
        ForForce(GetPlayersAll(), Trig_BlackoutEnd_Func015A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h02P')), Trig_BlackoutEnd_Func016A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h02B')), Trig_BlackoutEnd_Func017A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h043')), Trig_BlackoutEnd_Func018A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h040')), Trig_BlackoutEnd_Func019A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h041')), Trig_BlackoutEnd_Func020A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h042')), Trig_BlackoutEnd_Func021A)
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('h02T')), Trig_BlackoutEnd_Func022A)
    end

    --===========================================================================
    gg_trg_BlackoutEnd = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_BlackoutEnd, udg_BlackoutTimer)
    TriggerAddAction(gg_trg_BlackoutEnd, Trig_BlackoutEnd_Actions)
end)
if Debug then Debug.endFile() end
