function Trig_Shutdown_Conditions takes nothing returns boolean
    if ( not ( GetTriggerPlayer() == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_Shutdown_Actions takes nothing returns nothing
    call CreateNUnitsAtLoc( 1, 'hpea', udg_HiddenAndroid, udg_HoldZone, bj_UNIT_FACING )
    set udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] = GetLastCreatedUnit()
    set udg_HiddenAndroid = Player(PLAYER_NEUTRAL_PASSIVE)
    call KillUnit( GetLastCreatedUnit() )
    call RemoveItem( udg_Android_MemoryCard )
endfunction

//===========================================================================
function InitTrig_Shutdown takes nothing returns nothing
    set gg_trg_Shutdown = CreateTrigger(  )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(0), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(1), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(2), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(3), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(4), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(5), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(6), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(7), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(8), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(9), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(10), "-shutdown", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_Shutdown, Player(11), "-shutdown", true )
    call TriggerAddCondition( gg_trg_Shutdown, Condition( function Trig_Shutdown_Conditions ) )
    call TriggerAddAction( gg_trg_Shutdown, function Trig_Shutdown_Actions )
endfunction

