//TESH.scrollpos=8
//TESH.alwaysfold=0
function Trig_Mine_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function ChangeOwner takes nothing returns nothing
    call SetUnitOwner( GetEnumUnit(), GetTriggerPlayer(), true )
endfunction

function Trig_Mine_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsSelectedAll(GetTriggerPlayer()), function ChangeOwner )
endfunction

//===========================================================================
function InitTrig_Mine takes nothing returns nothing
local integer i=0
    set gg_trg_Mine = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_Mine, Player(i), "-mine", true )
    set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_Mine, Condition( function Trig_Mine_Conditions ) )
    call TriggerAddAction( gg_trg_Mine, function Trig_Mine_Actions )
endfunction

