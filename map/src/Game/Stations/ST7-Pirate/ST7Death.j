function Trig_ST7Death_Func008A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_PirateShip) 
endfunction 

function Trig_ST7Death_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1355") 
    call StartTimerBJ(udg_PirateShip_DestructionTimer, false, 40.00) 
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_1354") 
    set udg_PirateShip_CountdownWindow = GetLastCreatedTimerDialogBJ() 
    call PolledWait(5.00) 
    call ForForce(GetPlayersAll(), function Trig_ST7Death_Func008A) 
endfunction 

//=========================================================================== 
function InitTrig_ST7Death takes nothing returns nothing 
    set gg_trg_ST7Death = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_ST7Death, gg_unit_h02A_0115, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_ST7Death, function Trig_ST7Death_Actions) 
endfunction 

