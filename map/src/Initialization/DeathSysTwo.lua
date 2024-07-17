if Debug then Debug.beginFile "Initialization/DeathSysTwo" end
OnInit.trig("DeathSysTwo", function(require)
    function Trig_DeathSysTwo_Func022A()
        DialogDisplayBJ(true, udg_DeathVoteDialog, GetEnumPlayer())
    end

    function Trig_DeathSysTwo_Actions()
        -- Votes for the death mode type.
        DestroyTrigger(GetTriggeringTrigger())
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3434")
        PlaySoundBJ(gg_snd_ArrangedTeamInvitation)
        PolledWait(5.00)
        DialogAddButtonBJ(udg_DeathVoteDialog, "TRIGSTR_2353")
        udg_DeathVoteDialog_Buttons[1] = GetLastCreatedButtonBJ()
        DialogAddButtonBJ(udg_DeathVoteDialog, "TRIGSTR_2354")
        udg_DeathVoteDialog_Buttons[2] = GetLastCreatedButtonBJ()
        ForForce(GetPlayersAll(), Trig_DeathSysTwo_Func022A)
    end

    --===========================================================================
    gg_trg_DeathSysTwo = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(0), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(1), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(2), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(3), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(4), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(5), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(6), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(7), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(8), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(9), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(10), "-vote death", true)
    TriggerRegisterPlayerChatEvent(gg_trg_DeathSysTwo, Player(11), "-vote death", true)
    TriggerAddAction(gg_trg_DeathSysTwo, Trig_DeathSysTwo_Actions)
end)
if Debug then Debug.endFile() end
