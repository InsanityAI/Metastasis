//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Kill_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function KillPickedUnit takes nothing returns nothing
        call KillUnit( GetEnumUnit() )
endfunction

function Trig_Kill_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsSelectedAll(GetTriggerPlayer()), function KillPickedUnit )
endfunction

//===========================================================================
function InitTrig_Kill takes nothing returns nothing
    local integer i=0

    set gg_trg_Kill = CreateTrigger()
    
    loop
    exitwhen i>11
        call TriggerRegisterPlayerChatEvent( gg_trg_Kill, Player(i), "-kill", false )
        set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_Kill, Condition( function Trig_Kill_Conditions ) )
    call TriggerAddAction( gg_trg_Kill, function Trig_Kill_Actions )
endfunction

