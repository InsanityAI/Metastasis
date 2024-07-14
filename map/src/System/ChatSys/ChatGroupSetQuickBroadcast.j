//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_ChatGroupSetQuickBroadcast_Conditions takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 1, 8) == "-default" ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChatGroupSetQuickBroadcast_Actions takes nothing returns nothing
call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"Chat group default set.")
    set udg_Player_DefaultChatGroup[GetConvertedPlayerId(GetTriggerPlayer())] = SubStringBJ(GetEventPlayerChatString(), 10, 99)
endfunction

//===========================================================================
function InitTrig_ChatGroupSetQuickBroadcast takes nothing returns nothing
local integer i=0
    set gg_trg_ChatGroupSetQuickBroadcast = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_ChatGroupSetQuickBroadcast, Player(i), "-default", false )
    set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_ChatGroupSetQuickBroadcast, Condition( function Trig_ChatGroupSetQuickBroadcast_Conditions ) )
    call TriggerAddAction( gg_trg_ChatGroupSetQuickBroadcast, function Trig_ChatGroupSetQuickBroadcast_Actions )
endfunction

