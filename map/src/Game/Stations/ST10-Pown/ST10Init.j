function Trig_ST10Init_Func002A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST10V1) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_ST10Init_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForForce(GetPlayersAll(), function Trig_ST10Init_Func002A) 
    set udg_TempUnit = gg_unit_h04U_0252 
    set udg_TempUnit2 = gg_unit_h04V_0253 
    call GenConsole(udg_TempUnit, udg_TempUnit2, gg_rct_ST10Control) 
endfunction 

//=========================================================================== 
function InitTrig_ST10Init takes nothing returns nothing 
    set gg_trg_ST10Init = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST10Init, function Trig_ST10Init_Actions) 
endfunction 

