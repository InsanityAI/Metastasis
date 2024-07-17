if Debug then Debug.beginFile "Game/RandomEvents/FakeEvent" end
OnInit.map("FakeEvent", function(require)
    ---@return boolean
    function Trig_FakeEvent_Func002C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func003C()
        if (not (udg_TempInt == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func004C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func005C()
        if (not (udg_TempInt == 4)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func006C()
        if (not (udg_TempInt == 5)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func007C()
        if (not (udg_TempInt == 6)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func008C()
        if (not (udg_TempInt == 7)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func009C()
        if (not (udg_TempInt == 8)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func010C()
        if (not (udg_TempInt == 9)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func011C()
        if (not (udg_TempInt == 10)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func012C()
        if (not (udg_TempInt == 11)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func013C()
        if (not (udg_TempInt == 12)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func014C()
        if (not (udg_TempInt == 13)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func015C()
        if (not (udg_TempInt == 14)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func016C()
        if (not (udg_TempInt == 15)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FakeEvent_Func017C()
        if (not (udg_TempInt == 16)) then
            return false
        end
        return true
    end

    function Trig_FakeEvent_Actions()
        udg_TempInt = GetRandomInt(1, 16)
        if (Trig_FakeEvent_Func002C()) then
            DisplayTextToForce(GetPlayersAll(),
                (GetPlayerName(udg_TempPlayer) + " |cff00FF40has received a promotion!|r"))
        else
        end
        if (Trig_FakeEvent_Func003C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4167")
        else
        end
        if (Trig_FakeEvent_Func004C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4169")
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4170")
        else
        end
        if (Trig_FakeEvent_Func005C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4171")
        else
        end
        if (Trig_FakeEvent_Func006C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4172")
        else
        end
        if (Trig_FakeEvent_Func007C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4173")
        else
        end
        if (Trig_FakeEvent_Func008C()) then
        else
        end
        if (Trig_FakeEvent_Func009C()) then
        else
        end
        if (Trig_FakeEvent_Func010C()) then
        else
        end
        if (Trig_FakeEvent_Func011C()) then
        else
        end
        if (Trig_FakeEvent_Func012C()) then
        else
        end
        if (Trig_FakeEvent_Func013C()) then
        else
        end
        if (Trig_FakeEvent_Func014C()) then
        else
        end
        if (Trig_FakeEvent_Func015C()) then
        else
        end
        if (Trig_FakeEvent_Func016C()) then
        else
        end
        if (Trig_FakeEvent_Func017C()) then
        else
        end
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(120.00, 600.00))
    end

    --===========================================================================
    gg_trg_FakeEvent = CreateTrigger()
    DisableTrigger(gg_trg_FakeEvent)
    TriggerAddAction(gg_trg_FakeEvent, Trig_FakeEvent_Actions)
end)
if Debug then Debug.endFile() end
