if Debug then Debug.beginFile "Game/Misc/PlayerDeathText" end
OnInit.map("PlayerDeathText", function(require)
    ---@return boolean
    function Trig_PlayerDeathText_Conditions()
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == true)) then
            return false
        end
        if (not (GetTriggerPlayer() ~= udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_PlayerDeathText_Func015Func001C()
        if (not (GetEnumPlayer() ~= udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    function Trig_PlayerDeathText_Func015A()
        if (Trig_PlayerDeathText_Func015Func001C()) then
            udg_TempString = "|cffffcc00" + udg_OriginalName[GetConvertedPlayerId(GetTriggerPlayer())] + "|r: " +
                GetEventPlayerChatString()
            DisplayTextToPlayer(GetEnumPlayer(), 0, 0, udg_TempString)
        else
        end
    end

    function Trig_PlayerDeathText_Actions()
        ForForce(udg_DeadGroup, Trig_PlayerDeathText_Func015A)
    end

    --===========================================================================
    gg_trg_PlayerDeathText = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(0), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(1), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(2), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(3), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(4), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(5), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(6), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(7), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(8), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(9), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(10), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_PlayerDeathText, Player(11), "", false)
    TriggerAddCondition(gg_trg_PlayerDeathText, Condition(Trig_PlayerDeathText_Conditions))
    TriggerAddAction(gg_trg_PlayerDeathText, Trig_PlayerDeathText_Actions)
end)
if Debug then Debug.endFile() end
