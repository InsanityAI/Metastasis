function Trig_Deterministic_Invigoration_Expiration_Actions takes nothing returns nothing 
    local integer i = 0 
    local timer invigorationTimer = GetExpiredTimer() 

    //Find the [i] of the timer 
    loop 
        exitwhen i > 12 
    
        if(invigorationTimer == udg_GuardInvigorationExpiration[i]) then 
            call UnitRemoveAbilityBJ('A0A0', udg_GuardInvigorationSelf[i]) 
            call UnitRemoveAbilityBJ('A09W', udg_GuardInvigorationAlly[i]) 
            call UnitRemoveAbilityBJ('A09V', udg_GuardInvigorationAlly[i]) 
            call UnitRemoveBuffBJ('B01E', udg_GuardInvigorationAlly[i]) 
            set i = 12 //just like writing return! 
        endif 
        set i = i + 1 
    endloop 
    
endfunction 

//=========================================================================== 
function InitTrig_Deterministic_Invigoration_Expiration takes nothing returns nothing 

    local integer i = 0 
    
    set gg_trg_Deterministic_Invigoration_Expiration = CreateTrigger() 
    call TriggerAddAction(gg_trg_Deterministic_Invigoration_Expiration, function Trig_Deterministic_Invigoration_Expiration_Actions) 
    
    loop 
        exitwhen i > 11 
        call TriggerRegisterTimerExpireEventBJ(gg_trg_Deterministic_Invigoration_Expiration, udg_GuardInvigorationExpiration[i]) 
        set i = i + 1 
    endloop 

endfunction 

