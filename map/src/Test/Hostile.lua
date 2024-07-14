//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Hostile_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Hostile_Func002A takes nothing returns nothing
    call SetUnitOwner( GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true )
endfunction

function Trig_Hostile_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsSelectedAll(GetTriggerPlayer()), function Trig_Hostile_Func002A )
endfunction

//===========================================================================
function InitTrig_Hostile takes nothing returns nothing
local integer i=0
    set gg_trg_Hostile = CreateTrigger(  )
    loop
    exitwhen i>11
    call TriggerRegisterPlayerChatEvent( gg_trg_Hostile, Player(0), "-hostile", true )
    set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_Hostile, Condition( function Trig_Hostile_Conditions ) )
    call TriggerAddAction( gg_trg_Hostile, function Trig_Hostile_Actions )
endfunction

