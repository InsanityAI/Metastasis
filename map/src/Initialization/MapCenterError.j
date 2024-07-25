function Trig_MapCenterError_Func004C takes nothing returns boolean 
    if not(GetPlayerheroU(GetTriggerUnit()) == GetTriggerUnit()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MapCenterError_Func006C takes nothing returns boolean 
    if(not(udg_MapCenterErrors > 16)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MapCenterError_Actions takes nothing returns nothing 
    call DisplayTextToForce(GetPlayersAll(), ("MAP ERROR: " + GetUnitName(GetTriggerUnit()))) 
    call SetUnitPositionLoc(GetEnteringUnit(), GetRectCenter(gg_rct_Planet)) 
    if(Trig_MapCenterError_Func004C()) then 
        call UnitAddItemByIdSwapped('I00O', GetEnteringUnit()) 
    else 
    endif 
    set udg_MapCenterErrors = (udg_MapCenterErrors + 1) 
    if(Trig_MapCenterError_Func006C()) then 
        call DestroyTrigger(GetTriggeringTrigger()) 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4248") 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_MapCenterError takes nothing returns nothing 
    set gg_trg_MapCenterError = CreateTrigger() 
    call TriggerRegisterEnterRectSimple(gg_trg_MapCenterError, gg_rct_MapCenter) 
    call TriggerAddAction(gg_trg_MapCenterError, function Trig_MapCenterError_Actions) 
endfunction 

