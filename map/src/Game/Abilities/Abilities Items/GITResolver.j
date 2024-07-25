function Trig_GITResolver_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetManipulatedItem()) == 'I019')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GITResolver_Actions takes nothing returns nothing 
    local unit a = gg_unit_h011_0100 //GIT 

    //If not within 500 range from GIT 
    if(IsUnitInRange(GetManipulatingUnit(), a, 500) == false) then // Temporary workaround, but saves time so 2.0.-1 will come out in time :) 
        call DisplayTextToPlayer(GetOwningPlayer(GetManipulatingUnit()), 0, 0, "|cffffcc00This process can only be done in the Genetic Integrity Tester(GIT)|r") // Debugging message 
        call SetItemCharges(GetManipulatedItem(), 1) 
        call IssueImmediateOrder(GetManipulatingUnit(), "stop") 
        return 
    endif 

    set udg_TempPoint = GetUnitLoc(GetManipulatingUnit()) 
    call CreateNUnitsAtLoc(1, 'h038', GetOwningPlayer(GetManipulatingUnit()), udg_TempPoint, bj_UNIT_FACING) 
    set a = GetLastCreatedUnit() 
    call NewUnitRegister(GetLastCreatedUnit()) 
    set udg_GIT_TesterGroup[GetUnitUserData(GetLastCreatedUnit())] = udg_GIT_TesterGroup[GetItemUserData(GetManipulatedItem())] 
    set udg_GIT_TesterStatus[GetUnitUserData(GetLastCreatedUnit())] = udg_GIT_TesterStatus[GetItemUserData(GetManipulatedItem())] 
    set udg_GIT_TesterString[GetUnitUserData(GetLastCreatedUnit())] = udg_GIT_TesterString[GetItemUserData(GetManipulatedItem())] 
    call RemoveItem(GetManipulatedItem()) 
    call RemoveLocation(udg_TempPoint) 
    call PauseUnitBJ(true, GetLastCreatedUnit()) 
    set udg_TempUnit = GetLastCreatedUnit() 
    set udg_CountUpBarColor = "|cff8080FF" 
    call CountUpBar(udg_TempUnit, 60, 1 / 6.0, "DoNothing") 
    call PauseUnitBJ(false, a) 
endfunction 

//=========================================================================== 
function InitTrig_GITResolver takes nothing returns nothing 
    set gg_trg_GITResolver = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GITResolver, EVENT_PLAYER_UNIT_USE_ITEM) 
    call TriggerAddCondition(gg_trg_GITResolver, Condition(function Trig_GITResolver_Conditions)) 
    call TriggerAddAction(gg_trg_GITResolver, function Trig_GITResolver_Actions) 
endfunction 

