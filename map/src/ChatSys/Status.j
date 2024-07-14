function Trig_Status_Func013Func001Func001C takes nothing returns boolean
    if ( ( IsPlayerInForce(udg_Parasite, udg_DeadGroup) == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Status_Func013Func001Func002C takes nothing returns boolean
    if ( not ( IsPlayerInForce(udg_Mutant, udg_DeadGroup) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Status_Func013Func001C takes nothing returns boolean
    if ( not Trig_Status_Func013Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Status_Func013C takes nothing returns boolean
    if ( not ( IsPlayerInForce(udg_Parasite, udg_DeadGroup) == true ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(udg_Mutant, udg_DeadGroup) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Status_Actions takes nothing returns nothing
    if ( Trig_Status_Func013C() ) then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|cff00FF40Both the alien and the mutant are dead, but spawns may remain...|r")
    else
        if ( Trig_Status_Func013Func001C() ) then
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|cff00FF40The alien is dead, but more evil remains...|r")
        else
            if ( Trig_Status_Func013Func001Func002C() ) then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|cff00FF40The mutant is dead, but more evil remains...|r")
            else
                call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|cff00FF40Both the alien and the mutant live on...|r")
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Status takes nothing returns nothing
    set gg_trg_Status = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(0), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(1), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(2), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(3), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(4), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(5), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(6), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(7), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(8), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(9), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(10), "-status", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Status, Player(11), "-status", true )
    call TriggerAddAction( gg_trg_Status, function Trig_Status_Actions )
endfunction

