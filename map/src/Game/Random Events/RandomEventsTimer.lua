if Debug then Debug.beginFile "Game/RandomEvents/RandomEventsTimer" end
OnInit.map("RandomEventsTimer", function(require)
    ---@return boolean
    function Trig_RandomEventsTimer_Func002Func002C()
        if (not (udg_RandomEvent_On[udg_TempInt] ~= true)) then
            return false
        end
        return true
    end

    function Trig_RandomEventsTimer_Actions()
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 100
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempInt = GetRandomInt(1, 15)
            if (Trig_RandomEventsTimer_Func002Func002C()) then
                bj_forLoopAIndex = 1000
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        TriggerExecute(udg_RandomEvent_Trigger[udg_TempInt])
    end

    --===========================================================================
    gg_trg_RandomEventsTimer = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_RandomEventsTimer, udg_RandomEvent)
    TriggerAddAction(gg_trg_RandomEventsTimer, Trig_RandomEventsTimer_Actions)
end)
if Debug then Debug.endFile() end
