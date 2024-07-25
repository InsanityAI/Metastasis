function Trig_Niffy_Lockdown_Func002C takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Niffy_Lockdown_Func003Func013A takes nothing returns nothing 
    call SetUnitPositionLoc(GetEnumUnit(), GetRectCenter(gg_rct_ST10)) 
endfunction 

function Trig_Niffy_Lockdown_Func003Func017A takes nothing returns nothing 
    call SetUnitPositionLoc(GetEnumUnit(), GetRectCenter(gg_rct_ST10)) 
endfunction 

function Trig_Niffy_Lockdown_Func003Func021A takes nothing returns nothing 
    call SetUnitPositionLoc(GetEnumUnit(), GetRectCenter(gg_rct_ST10)) 
endfunction 

function Trig_Niffy_Lockdown_Func003Func035A takes nothing returns nothing 
    call SetUnitPositionLoc(GetEnumUnit(), GetRandomLocInRect(gg_rct_Niffy_Lockdown_Start)) 
    call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()), GetUnitLoc(GetEnumUnit()), 0) 
endfunction 

function Trig_Niffy_Lockdown_Func003Func039A takes nothing returns nothing 
    call SetPlayerTechMaxAllowedSwap('h031', 0, GetEnumPlayer()) 
    call SetPlayerTechMaxAllowedSwap('h04G', 0, GetEnumPlayer()) 
    call FogModifierStop(udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())]) 
endfunction 

function Trig_Niffy_Lockdown_Func003C takes nothing returns boolean 
    if(not(CountPlayersInForceBJ(GetPlayersAll()) <= 5)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Niffy_Lockdown_Actions takes nothing returns nothing 
    if(Trig_Niffy_Lockdown_Func002C()) then 
        return 
    else 
    endif 
    if(Trig_Niffy_Lockdown_Func003C()) then 
        // Niffy Lockdown! 
        set udg_IsNiffyLockdownActive = true 
        // --- 
        // Max Evil EP 
        set udg_UpgradePointsAlien = 4000.00 
        set udg_UpgradePointsMutant = 4000.00 
        // Create Solace Shop 
        set udg_TempPoint = Location(-14550.00, -7510.00) 
        call CreateNUnitsAtLoc(1, 'h017', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING) 
        call RemoveLocation(udg_TempPoint) 
        // Move all space pods away 
        set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h02O') 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_Niffy_Lockdown_Func003Func013A) 
        call DestroyGroup(udg_TempUnitGroup) 
        // Move all raptors away 
        set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h001') 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_Niffy_Lockdown_Func003Func017A) 
        call DestroyGroup(udg_TempUnitGroup) 
        // Move all obdas away 
        set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h02K') 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_Niffy_Lockdown_Func003Func021A) 
        call DestroyGroup(udg_TempUnitGroup) 
        // Random Events not triggering 
        set udg_RandomEvent_On[2] = true 
        set udg_RandomEvent_On[4] = true 
        set udg_RandomEvent_On[5] = true 
        set udg_RandomEvent_On[9] = true 
        set udg_RandomEvent_On[10] = true 
        set udg_RandomEvent_On[12] = true 
        set udg_RandomEvent_On[13] = true 
        // Wipe blood tests 
        call BloodTestingWipe() 
        // Move players to starting location (and move camera there) 
        set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h00H') 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_Niffy_Lockdown_Func003Func035A) 
        call DestroyGroup(udg_TempUnitGroup) 
        // Disable Space Alien and Space Overlord 
        // Credits to tal for this 
        call ForForce(GetPlayersAll(), function Trig_Niffy_Lockdown_Func003Func039A) 
        // Say to players that its niffy lockdown 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5194") 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Niffy_Lockdown takes nothing returns nothing 
    set gg_trg_Niffy_Lockdown = CreateTrigger() 
    call TriggerRegisterTimerEventSingle(gg_trg_Niffy_Lockdown, 2.00) 
    call TriggerAddAction(gg_trg_Niffy_Lockdown, function Trig_Niffy_Lockdown_Actions) 
endfunction 

