//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_NoWin_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_NoWin_Actions takes nothing returns nothing
    call DestroyTrigger( gg_trg_WinCheck )
endfunction

//===========================================================================
function InitTrig_NoWin takes nothing returns nothing
local integer i=0
    set gg_trg_NoWin = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_NoWin, Player(i), "-nowin", true )
    set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_NoWin, Condition( function Trig_NoWin_Conditions ) )
    call TriggerAddAction( gg_trg_NoWin, function Trig_NoWin_Actions )
endfunction

