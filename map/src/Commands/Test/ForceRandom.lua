if Debug then Debug.beginFile "Commands/Test/ForceRandom" end
OnInit.trig("ForceRandom", function(require)
    ---@return boolean
    function Trig_ForceRandom_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_ForceRandom_Actions()
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1290")
        TriggerExecute(udg_RandomEvent_Trigger[S2I(SubStringBJ(GetEventPlayerChatString(), 13, 999))])
    end

    --===========================================================================
    local i            = 0 ---@type integer
    gg_trg_ForceRandom = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ForceRandom, Player(i), "-forcerandom ", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ForceRandom, Condition(Trig_ForceRandom_Conditions))
    TriggerAddAction(gg_trg_ForceRandom, Trig_ForceRandom_Actions)
end)
if Debug then Debug.endFile() end
