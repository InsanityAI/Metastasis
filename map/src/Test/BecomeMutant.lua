//TESH.scrollpos=12
//TESH.alwaysfold=0
function Trig_BecomeMutant_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_BecomeMutant_Actions takes nothing returns nothing
    set udg_Mutant=GetTriggerPlayer()
    call CreateNUnitsAtLoc( 1, 'e031', GetTriggerPlayer(), udg_HoldZone, bj_UNIT_FACING )//Was GetEnumUnit()
        //if playerhero not in suit, give devour ability
endfunction

//===========================================================================
function InitTrig_BecomeMutant takes nothing returns nothing
    local integer i=0

    set gg_trg_BecomeMutant = CreateTrigger()
    
    loop
    exitwhen i>11
        call TriggerRegisterPlayerChatEvent( gg_trg_BecomeMutant, Player(i), "-mutant", false )
        set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_BecomeMutant, Condition( function Trig_BecomeMutant_Conditions ) )
    call TriggerAddAction( gg_trg_BecomeMutant, function Trig_BecomeMutant_Actions )
endfunction

