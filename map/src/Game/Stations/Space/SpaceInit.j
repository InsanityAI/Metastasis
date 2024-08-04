function Trig_SpaceInit_InitForPlayer takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Space )
    set udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())] = GetLastCreatedFogModifier()
endfunction

function Trig_SpaceInit_Actions takes nothing returns nothing
    // So pirates and drones can see all of space
    call CreateFogModifierRectBJ( true, Player(PLAYER_NEUTRAL_AGGRESSIVE), FOG_OF_WAR_VISIBLE, gg_rct_Space )
    call ForForce(GetPlayersAll(), function Trig_SpaceInit_InitForPlayer)
endfunction

//===========================================================================
function InitTrig_SpaceInit takes nothing returns nothing
    set gg_trg_SpaceInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_SpaceInit, function Trig_SpaceInit_Actions )
endfunction

