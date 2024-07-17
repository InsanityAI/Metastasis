if Debug then Debug.beginFile "Game/RandomEvents/FakeGameEnd" end
OnInit.trig("FakeGameEnd", function(require)
    function Trig_FakeGameEnd_Func001Func007A()
        SetUnitAnimation(GetEnumUnit(), "victory")
    end

    ---@return boolean
    function Trig_FakeGameEnd_Func001C()
        if (not (GetRandomInt(1, 6) == 1)) then
            return false
        end
        return true
    end

    function Trig_FakeGameEnd_Actions()
        if (Trig_FakeGameEnd_Func001C()) then
            DestroyTrigger(GetTriggeringTrigger())
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4183")
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4184")
            PlaySoundBJ(gg_snd_HumanVictory)
            udg_RandomEvent_On[15] = true
            PolledWait(2.00)
            ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), Trig_FakeGameEnd_Func001Func007A)
            PolledWait(4.00)
            StopSoundBJ(gg_snd_HumanVictory, false)
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4185")
        else
        end
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(10.00, 300.00))
    end

    --===========================================================================
    gg_trg_FakeGameEnd = CreateTrigger()
    DisableTrigger(gg_trg_FakeGameEnd)
    TriggerAddAction(gg_trg_FakeGameEnd, Trig_FakeGameEnd_Actions)
end)
if Debug then Debug.endFile() end
