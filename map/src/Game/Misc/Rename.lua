if Debug then Debug.beginFile "Game/Misc/Rename" end
OnInit.trig("Rename", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_Rename_Conditions()
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-rename")) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == false)) then
            return false
        end
        return true
    end

    function Trig_Rename_Actions()
        local name = udg_NamePrepension[GetConvertedPlayerId(GetTriggerPlayer())] ..
            SubStringBJ(GetEventPlayerChatString(), 9, 99) ---@type string
        SetPlayerName(GetTriggerPlayer(), name)
        StateTable.UpdatePlayerName(GetTriggerPlayer())
    end

    --===========================================================================
    gg_trg_Rename = CreateTrigger()
    DisableTrigger(gg_trg_Rename)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(0), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(1), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(2), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(3), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(4), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(5), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(6), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(7), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(8), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(9), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(10), "-rename", false)
    TriggerRegisterPlayerChatEvent(gg_trg_Rename, Player(11), "-rename", false)
    TriggerAddCondition(gg_trg_Rename, Condition(Trig_Rename_Conditions))
    TriggerAddAction(gg_trg_Rename, Trig_Rename_Actions)
end)
if Debug then Debug.endFile() end
