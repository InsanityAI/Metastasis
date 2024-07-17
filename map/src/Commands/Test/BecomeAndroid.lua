if Debug then Debug.beginFile "Commands/Test/BecomeAndroid" end
OnInit.map("BecomeAndroid", function(require)
    ---@return boolean
    function Trig_BecomeAndroid_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_BecomeAndroid_Actions()
        udg_HiddenAndroid = GetTriggerPlayer()
        StateGrid_SetPlayerRole(udg_HiddenAndroid, StateGrid_ROLE_ANDROID)
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
