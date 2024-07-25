function Trig_ST10UnInit_Func001A takes nothing returns nothing 
    call RemoveUnit(GetEnumUnit()) 
endfunction 

function Trig_ST10UnInit_Actions takes nothing returns nothing 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_ST10V1), function Trig_ST10UnInit_Func001A) 
    call RemoveUnit(gg_unit_h04V_0253) 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call DestroyTrigger(gg_trg_ST10Abilities) 
    call DestroyTrigger(gg_trg_ST10Death) 
    call DestroyTrigger(gg_trg_ST10Init) 
    call DestroyTrigger(gg_trg_ST10ViewLast) 
    call DestroyTrigger(gg_trg_ST10ViewLast) 
    call DestroyTrigger(gg_trg_ST10Abilities) 
    call DestroyTrigger(gg_trg_ST10Attack) 
    call DestroyTrigger(gg_trg_ST10AttackEnd) 
endfunction 

//=========================================================================== 
function InitTrig_ST10UnInit takes nothing returns nothing 
    set gg_trg_ST10UnInit = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST10UnInit, function Trig_ST10UnInit_Actions) 
endfunction 

