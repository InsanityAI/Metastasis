//TESH.scrollpos=9
//TESH.alwaysfold=0
function Trig_GlobalVision_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_GlobalVision_Actions takes nothing returns nothing

    call FogEnableOff()
    call FogMaskEnableOff()
    call CreateFogModifierRectBJ( true, GetTriggerPlayer(), FOG_OF_WAR_VISIBLE, GetPlayableMapRect() )
    
endfunction

//===========================================================================
function InitTrig_GlobalVision takes nothing returns nothing
local integer i=0
    set gg_trg_GlobalVision = CreateTrigger()
    
    loop
    exitwhen i>11
        call TriggerRegisterPlayerChatEvent( gg_trg_GlobalVision, Player(i), "-vision", false )
        set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_GlobalVision, Condition( function Trig_GlobalVision_Conditions ) )
    call TriggerAddAction( gg_trg_GlobalVision, function Trig_GlobalVision_Actions )
endfunction

