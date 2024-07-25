function Trig_Mirror_A_I_Func005Func002Func001Func003C takes nothing returns boolean 
    if(not(GetItemTypeId(udg_TempItem) == 'I01D')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005Func002Func001C takes nothing returns boolean 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005Func002Func002Func003C takes nothing returns boolean 
    if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()), GetOrderPointLoc()) >= 300.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005Func002Func002Func004Func003C takes nothing returns boolean 
    if(not(UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt2) == null)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005Func002Func002Func004C takes nothing returns boolean 
    if(not(udg_TempInt2 == 3)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005Func002Func002C takes nothing returns boolean 
    if(not(udg_TempInt2 == 2)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005Func002C takes nothing returns boolean 
    if(not(udg_TempInt2 == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_A_I_Func005A takes nothing returns nothing 
    set udg_TempInt2 = GetRandomInt(1, 5) 
    if(Trig_Mirror_A_I_Func005Func002C()) then 
        if(Trig_Mirror_A_I_Func005Func002Func001C()) then 
            call IssueImmediateOrderBJ(GetEnumUnit(), "stop") 
            call IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit) 
        else 
            set udg_TempInt = GetRandomInt(1, 6) 
            set udg_TempItem = UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt) 
            if(Trig_Mirror_A_I_Func005Func002Func001Func003C()) then 
                call IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit) 
            else 
                call UnitUseItemTarget(GetEnumUnit(), udg_TempItem, udg_TempUnit) 
            endif 
        endif 
    else 
        if(Trig_Mirror_A_I_Func005Func002Func002C()) then 
            set udg_TempInt2 = GetRandomInt(1, 6) 
            call UnitUseItemPointLoc(GetEnumUnit(), UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt2), GetUnitLoc(udg_TempUnit)) 
            if(Trig_Mirror_A_I_Func005Func002Func002Func003C()) then 
                call IssueImmediateOrderBJ(GetEnumUnit(), "stop") 
                call IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit) 
            else 
            endif 
        else 
            if(Trig_Mirror_A_I_Func005Func002Func002Func004C()) then 
                set udg_TempInt2 = GetRandomInt(1, 6) 
                if(Trig_Mirror_A_I_Func005Func002Func002Func004Func003C()) then 
                    call IssueImmediateOrderBJ(GetEnumUnit(), "stop") 
                    call IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit) 
                else 
                    call UnitUseItem(GetEnumUnit(), UnitItemInSlotBJ(GetEnumUnit(), udg_TempInt2)) 
                endif 
            else 
                call IssueTargetOrderBJ(GetEnumUnit(), "attack", udg_TempUnit) 
            endif 
        endif 
    endif 
endfunction 

function Trig_Mirror_A_I_Actions takes nothing returns nothing 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena) 
    call GroupRemoveGroup(GetUnitsInRectOfPlayer(gg_rct_Mirror_Arena, Player(PLAYER_NEUTRAL_PASSIVE)), udg_TempUnitGroup) 
    set udg_TempUnit = GroupPickRandomUnit(udg_TempUnitGroup) 
    call ForGroupBJ(udg_Mirror_Hostilegroup, function Trig_Mirror_A_I_Func005A) 
    call DestroyGroup(udg_TempUnitGroup) 
endfunction 

//=========================================================================== 
function InitTrig_Mirror_A_I takes nothing returns nothing 
    set gg_trg_Mirror_A_I = CreateTrigger() 
    call DisableTrigger(gg_trg_Mirror_A_I) 
    call TriggerRegisterTimerEventPeriodic(gg_trg_Mirror_A_I, 1.10) 
    call TriggerAddAction(gg_trg_Mirror_A_I, function Trig_Mirror_A_I_Actions) 
endfunction 

