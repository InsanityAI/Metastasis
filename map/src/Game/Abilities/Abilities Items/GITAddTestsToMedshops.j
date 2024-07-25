function Trig_GITAddTestsToMedshops_Func003A takes nothing returns nothing 
    call AddItemToStockBJ('I00M', GetEnumUnit(), 0, 1) 
endfunction 

function Trig_GITAddTestsToMedshops_Actions takes nothing returns nothing 
    set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h00G') 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_GITAddTestsToMedshops_Func003A) 
    call AddItemToStockBJ('I00M', gg_unit_h011_0100, 0, 99) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_GITAddTestsToMedshops takes nothing returns nothing 
    set gg_trg_GITAddTestsToMedshops = CreateTrigger() 
    call TriggerAddAction(gg_trg_GITAddTestsToMedshops, function Trig_GITAddTestsToMedshops_Actions) 
endfunction 

