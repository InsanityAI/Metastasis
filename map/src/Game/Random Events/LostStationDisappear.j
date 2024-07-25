function Trig_LostStationDisappear_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ShowUnitHide(gg_unit_h029_0114) 
    call DestroyTimerDialogBJ(udg_LostStation_TimerWindow) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1334") 
    call TriggerExecute(gg_trg_ST6Death) 
endfunction 

//=========================================================================== 
function InitTrig_LostStationDisappear takes nothing returns nothing 
    set gg_trg_LostStationDisappear = CreateTrigger() 
    call DisableTrigger(gg_trg_LostStationDisappear) 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_LostStationDisappear, udg_LostStation_Disappear) 
    call TriggerAddAction(gg_trg_LostStationDisappear, function Trig_LostStationDisappear_Actions) 
endfunction 

