function Trig_ST8mInit_Func005A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST8 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_ST8mInit_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_TempUnit = gg_unit_h04F_0260
    set udg_TempUnit2 = gg_unit_h04E_0259
    call GenConsole(udg_TempUnit,udg_TempUnit2,gg_rct_ST8Control)
    call ForForce( GetPlayersAll(), function Trig_ST8mInit_Func005A )
endfunction

//===========================================================================
function InitTrig_ST8mInit takes nothing returns nothing
    set gg_trg_ST8mInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ST8mInit, function Trig_ST8mInit_Actions )
endfunction

