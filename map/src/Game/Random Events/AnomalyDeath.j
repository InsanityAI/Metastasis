function Trig_AnomalyDeath_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'n00K')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AnomalyDeath_Func001C takes nothing returns boolean 
    if(not(udg_AnomalyWarpalHasSpawned == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AnomalyDeath_Func003Func001C takes nothing returns boolean 
    if(not(IsUnitGroupDeadBJ(udg_AnomalyUnitGroup) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AnomalyDeath_Func003C takes nothing returns boolean 
    if(not(udg_TempInt == 12)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AnomalyDeath_Actions takes nothing returns nothing 
    if(Trig_AnomalyDeath_Func001C()) then 
        return 
    else 
    endif 
    set udg_TempInt = GetRandomInt(1, 12) 
    if(Trig_AnomalyDeath_Func003C()) then 
        set udg_AnomalyWarpalHasSpawned = true 
        set udg_TempPoint = GetUnitLoc(GetTriggerUnit()) 
        call CreateItemLoc('I02X', udg_TempPoint) 
        call RemoveLocation(udg_TempPoint) 
    else 
        if(Trig_AnomalyDeath_Func003Func001C()) then 
            set udg_AnomalyWarpalHasSpawned = true 
            set udg_TempPoint = GetUnitLoc(GetTriggerUnit()) 
            call CreateItemLoc('I02X', udg_TempPoint) 
            call RemoveLocation(udg_TempPoint) 
        else 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_AnomalyDeath takes nothing returns nothing 
    set gg_trg_AnomalyDeath = CreateTrigger() 
    call DisableTrigger(gg_trg_AnomalyDeath) 
    call TriggerRegisterPlayerUnitEventSimple(gg_trg_AnomalyDeath, Player(PLAYER_NEUTRAL_PASSIVE), EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_AnomalyDeath, Condition(function Trig_AnomalyDeath_Conditions)) 
    call TriggerAddAction(gg_trg_AnomalyDeath, function Trig_AnomalyDeath_Actions) 
endfunction 

