function Trig_Stalker_Range_Restriction_Activation_Actions takes nothing returns nothing 
    //If less than 400 range, stop attacking. 
    if(DistanceBetweenPoints(udg_StalkerAttackLocation, udg_StalkerUnitLocation) <= 400.00) then 
        call IssueImmediateOrderBJ(udg_StalkerUnit, "stop") 
        
        //Explain to mutant the range mechanic, and color-code it plz. 
        call DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 1.00, "|cffF4A460Distance from Prey: |r|cffFF0000" + R2S(DistanceBetweenPoints(udg_StalkerAttackLocation, udg_StalkerUnitLocation))) 
    else 
        call DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 1.00, "|cffF4A460Distance from Prey: |r|cff8AB600" + R2S(DistanceBetweenPoints(udg_StalkerAttackLocation, udg_StalkerUnitLocation))) 
    endif 
    
    
    //Memory Leak Cleaning 
    call RemoveLocation(udg_StalkerAttackLocation) 
    call RemoveLocation(udg_StalkerUnitLocation) 
endfunction 

//=========================================================================== 
function InitTrig_Stalker_Range_Restriction_Activation takes nothing returns nothing 
    set gg_trg_Stalker_Range_Restriction_Activation = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Stalker_Range_Restriction_Activation, udg_StalkerAttackTimer) 
    call TriggerAddAction(gg_trg_Stalker_Range_Restriction_Activation, function Trig_Stalker_Range_Restriction_Activation_Actions) 
endfunction 

