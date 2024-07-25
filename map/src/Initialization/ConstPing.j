function ConstPing_Callback takes nothing returns nothing 
    local unit a = GetPlayerhero(GetEnumPlayer()) 
    call SetCameraQuickPositionForPlayer(GetEnumPlayer(), GetUnitX(a), GetUnitY(a)) 
endfunction 

function Trig_ConstPing_Actions takes nothing returns nothing 
    call ForForce(GetPlayersAll(), function ConstPing_Callback) 
endfunction 

//=========================================================================== 
function InitTrig_ConstPing takes nothing returns nothing 
    set gg_trg_ConstPing = CreateTrigger() 
    call TriggerRegisterTimerEventPeriodic(gg_trg_ConstPing, 0.10) 
    call TriggerAddAction(gg_trg_ConstPing, function Trig_ConstPing_Actions) 
endfunction 

