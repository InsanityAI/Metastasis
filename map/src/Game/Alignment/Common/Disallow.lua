if Debug then Debug.beginFile "Game/Allignment/Common/Disallow" end
OnInit.map("Disallow", function(require)
    ---@return boolean
    function Trig_Disallow_Func013C()
        if (not (GetTriggerPlayer() == udg_Mutant)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Disallow_Func014C()
        if (not (GetTriggerPlayer() == udg_Parasite)) then
            return false
        end
        return true
    end

    function Trig_Disallow_Actions()
        if (Trig_Disallow_Func013C()) then
            udg_AllowMutantTK = false
            EnableTrigger(gg_trg_NoMutantTK)
            DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may no longer attack you.")
        else
        end
        if (Trig_Disallow_Func014C()) then
            udg_AllowAlienTK = false
            EnableTrigger(gg_trg_NoAlienTK)
            DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Your spawns may no longer attack you.")
        else
        end
    end

    --===========================================================================
    gg_trg_Disallow = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(0), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(1), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(2), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(3), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(4), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(5), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(6), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(7), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(8), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(9), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(10), "-disallow", true)
    TriggerRegisterPlayerChatEvent(gg_trg_Disallow, Player(11), "-disallow", true)
    TriggerAddAction(gg_trg_Disallow, Trig_Disallow_Actions)
end)
if Debug then Debug.endFile() end
