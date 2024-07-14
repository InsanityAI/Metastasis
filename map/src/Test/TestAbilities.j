//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_TestAbilities_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TestAbilities_Func001A takes nothing returns nothing
    call UnitAddAbilityBJ( 'A087', GetEnumUnit() )
endfunction

function Trig_TestAbilities_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsSelectedAll(GetTriggerPlayer()), function Trig_TestAbilities_Func001A )
endfunction

//===========================================================================
function InitTrig_TestAbilities takes nothing returns nothing
local integer i=0
    set gg_trg_TestAbilities = CreateTrigger(  )
    
    loop
        exitwhen i>11
            call TriggerRegisterPlayerChatEvent( gg_trg_TestAbilities, Player(i), "-test_abilities", true )
            call TriggerRegisterPlayerChatEvent( gg_trg_TestAbilities, Player(i), "--", true )
            set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_TestAbilities, Condition( function Trig_TestAbilities_Conditions ) )
    call TriggerAddAction( gg_trg_TestAbilities, function Trig_TestAbilities_Actions )
endfunction

