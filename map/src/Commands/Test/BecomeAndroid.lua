if Debug then Debug.beginFile "Commands/Test/BecomeAndroid" end
OnInit.map("BecomeAndroid", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_BecomeAndroid_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_BecomeAndroid_Actions()
        udg_HiddenAndroid = GetTriggerPlayer()
        StateTable.SetPlayerRole(udg_HiddenAndroid, Role.Android)
    end

    --===========================================================================
    local i              = 0 ---@type integer

    gg_trg_BecomeAndroid = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_BecomeAndroid, Player(i), "-android", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_BecomeAndroid, Condition(Trig_BecomeAndroid_Conditions))
    TriggerAddAction(gg_trg_BecomeAndroid, Trig_BecomeAndroid_Actions)
end)
if Debug then Debug.endFile() end
