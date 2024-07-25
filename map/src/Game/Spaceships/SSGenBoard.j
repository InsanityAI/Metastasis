function Trig_SSGenBoard_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A02J')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SSGenBoard_Actions takes nothing returns nothing 
    local unit a = GetSpellAbilityUnit() 
    local unit b = GetSpellTargetUnit() 
    local lightning d 

    call IssueImmediateOrder(a, "stop") 

    if udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] then 
        return 
    endif 

    if IsUnitExplorer(b) then 
        call PauseUnitBJ(true, a) 
        call PauseUnitBJ(true, b) 

        set udg_SS_BoardingTarget[GetUnitUserData(udg_SS_Landed[GetUnitUserData(a)])] = udg_SS_Landed[GetUnitUserData(b)] 
        set udg_SS_BoardingTarget[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] = udg_SS_Landed[GetUnitUserData(a)] 
        set udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(a)])] = true 
        set udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] = true 
        set udg_TempPoint = GetUnitLoc(a) 
        set udg_TempPoint2 = GetUnitLoc(b) 
        set d = AddLightningEx("MFPB", true, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), -156, GetLocationX(udg_TempPoint2), GetLocationY(udg_TempPoint2), -156) 
        call RemoveLocation(udg_TempPoint) 
        call RemoveLocation(udg_TempPoint2) 
        set udg_CountUpBarColor = "|cff00FFFF" 
        call CountUpBar(a, 20, 1.0, "DoNothing") //Includes a polled wait of 20 seconds here 
        call PauseUnitBJ(false, a) 
        call PauseUnitBJ(false, b) 
        set udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(a)])] = false 
        set udg_SS_IsBoarded[GetUnitUserData(udg_SS_Landed[GetUnitUserData(b)])] = false 
        call DestroyLightning(d) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_SSGenBoard takes nothing returns nothing 
    set gg_trg_SSGenBoard = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SSGenBoard, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_SSGenBoard, Condition(function Trig_SSGenBoard_Conditions)) 
    call TriggerAddAction(gg_trg_SSGenBoard, function Trig_SSGenBoard_Actions) 
endfunction 

