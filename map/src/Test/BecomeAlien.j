//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_BecomeAlien_Conditions takes nothing returns boolean
    if ( not ( udg_TESTING == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_BecomeAlien_Actions takes nothing returns nothing
    set udg_Parasite=GetTriggerPlayer()
    call StateGrid_SetPlayerRole(udg_Parasite, StateGrid_ROLE_ALIEN)
    call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), GetTriggerPlayer(), bj_ALLIANCE_ALLIED_ADVUNITS)
    //if playerhero not in suit, give alien form ability
endfunction

//===========================================================================
function InitTrig_BecomeAlien takes nothing returns nothing
    local integer i=0

    set gg_trg_BecomeAlien = CreateTrigger()
    
    loop
    exitwhen i>11
        call TriggerRegisterPlayerChatEvent( gg_trg_BecomeAlien, Player(i), "-alien", false )
        set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_BecomeAlien, Condition( function Trig_BecomeAlien_Conditions ) )
    call TriggerAddAction( gg_trg_BecomeAlien, function Trig_BecomeAlien_Actions )
endfunction

