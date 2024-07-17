if Debug then Debug.beginFile "Commands/Test/NoWin" end
OnInit.trig("NoWin", function(require)
    ---@return boolean
    function Trig_NoWin_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_NoWin_Actions()
        DestroyTrigger(gg_trg_WinCheck)
    end

    --===========================================================================
    local i      = 0 ---@type integer
    gg_trg_NoWin = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_NoWin, Player(i), "-nowin", true)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_NoWin, Condition(Trig_NoWin_Conditions))
    TriggerAddAction(gg_trg_NoWin, Trig_NoWin_Actions)
end)
if Debug then Debug.endFile() end
