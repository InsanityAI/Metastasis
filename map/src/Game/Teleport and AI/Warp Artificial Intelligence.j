function Trig_Warp_Artificial_Intelligence_Func005A takes nothing returns nothing 
    call IssueTargetOrderBJ(GetEnumUnit(), "attack", GroupPickRandomUnit(udg_TempUnitGroup)) 
endfunction 

function Trig_Warp_Artificial_Intelligence_Actions takes nothing returns nothing 
    set udg_TempUnitGroup2 = GetUnitsInRectOfPlayer(gg_rct_Warp, Player(PLAYER_NEUTRAL_AGGRESSIVE)) 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Warp) 
    call GroupRemoveGroup(udg_TempUnitGroup2, udg_TempUnitGroup) 
    call ForGroupBJ(udg_TempUnitGroup2, function Trig_Warp_Artificial_Intelligence_Func005A) 
    call DestroyGroup(udg_TempUnitGroup2) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_Warp_Artificial_Intelligence takes nothing returns nothing 
    set gg_trg_Warp_Artificial_Intelligence = CreateTrigger() 
    call DisableTrigger(gg_trg_Warp_Artificial_Intelligence) 
    call TriggerRegisterTimerEventPeriodic(gg_trg_Warp_Artificial_Intelligence, 1.20) 
    call TriggerAddAction(gg_trg_Warp_Artificial_Intelligence, function Trig_Warp_Artificial_Intelligence_Actions) 
endfunction 

