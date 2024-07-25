function Trig_GITResults_Conditions takes nothing returns boolean 
    if(not(GetItemTypeId(GetSoldItem()) == 'I01A')) then //I01A is the "Test Results" (sold) item  
        return false 
    endif 
    return true 
endfunction 

function Trig_GITResults_Copy_Func015Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) == 'h038')) then //h038 is the GIT resolver unit  
        return false 
    endif 
    if(not(GetEnumUnit() != GetTriggerUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GITResults_Copy_Func015A takes nothing returns nothing 
    if(Trig_GITResults_Copy_Func015Func001C()) then 
        call KillUnit(GetEnumUnit()) 
    endif 
endfunction 

function RemovePickedBloodtestItem takes nothing returns nothing 
    //call DisplayTextToForce( GetPlayersAll(), ".")// Debug msg  
    if(GetItemTypeId(GetEnumItem()) == 'I019' or GetItemTypeId(GetEnumItem()) == 'I00M') then 
        call RemoveItem(GetEnumItem()) 
        //call DisplayTextToForce( GetPlayersAll(), "Removed an bloodtest")// Debug msg  
    endif 
endfunction 


function Trig_GITResults_Actions takes nothing returns nothing 

    //If Central GIT is dead, dont even bother.  
    if(IsUnitDeadBJ(gg_unit_h011_0100) == true) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_3964") 
        return 
    endif 
    
    set udg_TempItem = GetSoldItem() 
    set udg_TempString = "|cffffcc00This sample contains the DNA of:|r" 
    call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, udg_TempString) 
    call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, udg_GIT_TesterString[GetUnitUserData(GetSellingUnit())]) 
    if(udg_GIT_TesterStatus[GetUnitUserData(GetSellingUnit())] == 1) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_2390") 
    else 
        if(udg_GIT_TesterStatus[GetUnitUserData(GetSellingUnit())] == 2) then 
            call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_3125") 
        else 
            call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_3124") 
        endif 
    endif 
    call RemoveItem(udg_TempItem) 
    
    // =============================  
    // =======Blood Testing Wipe Below! =======  
    // =============================  
    call BloodTestingWipe() 
	
    // Below is to destroy any other GIT resolver that may happen within that time. It could be in above function, but lazy2stronk  
    set udg_TempLoc3 = GetUnitLoc(GetTriggerUnit()) 
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(3000.00, udg_TempLoc3)	
    call ForGroupBJ(udg_TempUnitGroup, function Trig_GITResults_Copy_Func015A) 
    
    //memory leak fixes  
    call DestroyGroup(udg_TempUnitGroup) 
    call RemoveLocation(udg_TempLoc3) 
	
    // Below is to delete any blood-testing item on the ground...  
    call EnumItemsInRectBJ(GetPlayableMapRect(), function RemovePickedBloodtestItem) 
endfunction 

//===========================================================================  
function InitTrig_GITResults takes nothing returns nothing 
    set gg_trg_GITResults = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GITResults, EVENT_PLAYER_UNIT_SELL_ITEM) 
    call TriggerAddCondition(gg_trg_GITResults, Condition(function Trig_GITResults_Conditions)) 
    call TriggerAddAction(gg_trg_GITResults, function Trig_GITResults_Actions) 
endfunction 

