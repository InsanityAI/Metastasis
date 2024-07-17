if Debug then Debug.beginFile "Game/Allignment/Android/Shutdown" end
OnInit.trigg("Shutdown", function(require)
    ---@return boolean
    function Trig_Shutdown_Conditions()
        if (not (GetTriggerPlayer() == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    function Trig_Shutdown_Actions()
        CreateNUnitsAtLoc(1, FourCC('hpea'), udg_HiddenAndroid, udg_HoldZone, bj_UNIT_FACING)
        udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] = GetLastCreatedUnit()
        udg_HiddenAndroid = Player(PLAYER_NEUTRAL_PASSIVE)
        KillUnit(GetLastCreatedUnit())
        RemoveItem(udg_Android_MemoryCard)
    end

    --===========================================================================
    gg_trg_Shutdown = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(0), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(1), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(2), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(3), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(4), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(5), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(6), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(7), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(8), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(9), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(10), "-shutdown", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Shutdown, Player(11), "-shutdown", true)
    TriggerAddCondition(gg_trg_Shutdown, Condition(Trig_Shutdown_Conditions))
    TriggerAddAction(gg_trg_Shutdown, Trig_Shutdown_Actions)
end)
if Debug then Debug.endFile() end
