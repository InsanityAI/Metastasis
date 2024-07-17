if Debug then Debug.beginFile "Game/Allignment/Common/Allow" end
OnInit.trig("Allow", function(require)
    ---@return boolean
    function Trig_Allow_Func013C()
        if (not (GetTriggerPlayer() == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Allow_Func014C()
        if (not (GetTriggerPlayer() == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_Allow_Actions()
        if (Trig_Allow_Func013C()) then
            udg_AllowMutantTK = true
            DisableTrigger(gg_trg_NoMutantTK)
            DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may now attack you.")
        else
        end
        if (Trig_Allow_Func014C()) then
            udg_AllowAlienTK = true
            DisableTrigger(gg_trg_NoAlienTK)
            DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may now attack you.")
        else
        end
    end

    --===========================================================================
    gg_trg_Allow = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(0), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(1), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(2), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(3), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(4), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(5), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(6), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(7), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(8), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(9), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(10), "-allow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Allow, Player(11), "-allow", true)
    TriggerAddAction(gg_trg_Allow, Trig_Allow_Actions)
end)
if Debug then Debug.endFile() end
