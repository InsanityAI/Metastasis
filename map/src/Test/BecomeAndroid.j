//TESH.scrollpos=5
//TESH.alwaysfold=0
function Trig_BecomeAndroid_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_BecomeAndroid_Actions takes nothing returns nothing
    set udg_HiddenAndroid=GetTriggerPlayer()
endfunction

//===========================================================================
function InitTrig_BecomeAndroid takes nothing returns nothing
    local integer i=0

    set gg_trg_BecomeAndroid = CreateTrigger()
    
    loop
    exitwhen i>11
        call TriggerRegisterPlayerChatEvent( gg_trg_BecomeAndroid, Player(i), "-android", false )
        set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_BecomeAndroid, Condition( function Trig_BecomeAndroid_Conditions ) )
    call TriggerAddAction( gg_trg_BecomeAndroid, function Trig_BecomeAndroid_Actions )
endfunction