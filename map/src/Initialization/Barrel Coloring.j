function Trig_Barrel_Coloring_Func003A takes nothing returns nothing 
    call SetUnitVertexColorBJ(GetEnumUnit(), GetRandomReal(1.00, 255.00), GetRandomReal(1.00, 255.00), GetRandomReal(1.00, 255.00), 1.00) 
endfunction 

function Trig_Barrel_Coloring_Actions takes nothing returns nothing 
    set udg_TempUnitGroup = GetUnitsOfTypeIdAll('n00J') 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Barrel_Coloring_Func003A) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_Barrel_Coloring takes nothing returns nothing 
    set gg_trg_Barrel_Coloring = CreateTrigger() 
    call TriggerRegisterTimerEventSingle(gg_trg_Barrel_Coloring, 0.00) 
    call TriggerAddAction(gg_trg_Barrel_Coloring, function Trig_Barrel_Coloring_Actions) 
endfunction 

