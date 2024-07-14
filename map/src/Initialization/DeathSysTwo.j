function Trig_DeathSysTwo_Func022A takes nothing returns nothing
    call DialogDisplayBJ( true, udg_DeathVoteDialog, GetEnumPlayer() )
endfunction

function Trig_DeathSysTwo_Actions takes nothing returns nothing
    // Votes for the death mode type.
       call DestroyTrigger( GetTriggeringTrigger() )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_3434" )
    call PlaySoundBJ( gg_snd_ArrangedTeamInvitation )
    call PolledWait( 5.00 )
    call DialogAddButtonBJ( udg_DeathVoteDialog, "TRIGSTR_2353" )
    set udg_DeathVoteDialog_Buttons[1] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_DeathVoteDialog, "TRIGSTR_2354" )
    set udg_DeathVoteDialog_Buttons[2] = GetLastCreatedButtonBJ()
    call ForForce( GetPlayersAll(), function Trig_DeathSysTwo_Func022A )
endfunction

//===========================================================================
function InitTrig_DeathSysTwo takes nothing returns nothing
    set gg_trg_DeathSysTwo = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(0), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(1), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(2), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(3), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(4), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(5), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(6), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(7), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(8), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(9), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(10), "-vote death", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_DeathSysTwo, Player(11), "-vote death", true )
    call TriggerAddAction( gg_trg_DeathSysTwo, function Trig_DeathSysTwo_Actions )
endfunction

