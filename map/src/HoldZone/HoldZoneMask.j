function Trig_HoldZoneMask_Func002A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Timeout) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_HoldZoneMask_Actions takes nothing returns nothing 
    call ForForce(GetPlayersAll(), function Trig_HoldZoneMask_Func002A) 
endfunction 

//=========================================================================== 
function InitTrig_HoldZoneMask takes nothing returns nothing 
    set gg_trg_HoldZoneMask = CreateTrigger() 
    call TriggerRegisterTimerEventPeriodic(gg_trg_HoldZoneMask, 5.00) 
    call TriggerAddAction(gg_trg_HoldZoneMask, function Trig_HoldZoneMask_Actions) 
endfunction 

