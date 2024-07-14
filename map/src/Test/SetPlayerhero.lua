//TESH.scrollpos=1
//TESH.alwaysfold=0
function Trig_SetPlayerhero_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SetPlayerhero_Func002A takes nothing returns nothing
    set udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())] = GetEnumUnit()
endfunction

function Trig_SetPlayerhero_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsSelectedAll(GetTriggerPlayer()), function Trig_SetPlayerhero_Func002A )
endfunction

//===========================================================================
function InitTrig_SetPlayerhero takes nothing returns nothing
local integer i=0
    set gg_trg_SetPlayerhero = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_SetPlayerhero, Player(i), "-playerhero", false )
    set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_SetPlayerhero, Condition( function Trig_SetPlayerhero_Conditions ) )
    call TriggerAddAction( gg_trg_SetPlayerhero, function Trig_SetPlayerhero_Actions )
endfunction

