if Debug then Debug.beginFile "Systems/ChatSys/ChatGroupSetQuickBroadcast" end
OnInit.map("ChatGroupSetQuickBroadcast", function(require)
    ---@return boolean
    function Trig_ChatGroupSetQuickBroadcast_Conditions()
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 8) == "-default")) then
            return false
        end
        return true
    end

    function Trig_ChatGroupSetQuickBroadcast_Actions()
        DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Chat group default set.")
        udg_Player_DefaultChatGroup[GetConvertedPlayerId(GetTriggerPlayer())] = SubStringBJ(GetEventPlayerChatString(),
            10, 99)
    end

    --===========================================================================
    local i = 0 ---@type integer
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupSetQuickBroadcast, Player(i), "-default", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupSetQuickBroadcast, Condition(Trig_ChatGroupSetQuickBroadcast_Conditions))
    TriggerAddAction(gg_trg_ChatGroupSetQuickBroadcast, Trig_ChatGroupSetQuickBroadcast_Actions)
end)
if Debug then Debug.endFile() end
