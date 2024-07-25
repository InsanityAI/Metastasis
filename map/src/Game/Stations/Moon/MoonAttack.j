function Trig_MoonAttack_Conditions takes nothing returns boolean 
    if(not(GetEventDamage() >= 1.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MoonAttack_Func004C takes nothing returns boolean 
    if(not(udg_Moon_TakingDamage == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MoonAttack_Func008Func001C takes nothing returns boolean 
    if(not(GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])) then 
        return false 
    endif 
    if(not(udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MoonAttack_Func008A takes nothing returns nothing 
    if(Trig_MoonAttack_Func008Func001C()) then 
        call ForceAddPlayerSimple(GetOwningPlayer(GetEnumUnit()), udg_Moon_PGroup) 
        call CameraSetEQNoiseForPlayer(GetOwningPlayer(GetEnumUnit()), 3) 
    else 
    endif 
endfunction 

function Trig_MoonAttack_Func010A takes nothing returns nothing 
    call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 5.00, "|cffFF0000Errun under attack!|r") 
endfunction 

function Trig_MoonAttack_Func012Func001C takes nothing returns boolean 
    if(not(udg_Player_TetrabinLevel[GetConvertedPlayerId(GetEnumPlayer())] == 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MoonAttack_Func012A takes nothing returns nothing 
    if(Trig_MoonAttack_Func012Func001C()) then 
        call CameraClearNoiseForPlayer(GetEnumPlayer()) 
    else 
    endif 
endfunction 

function Trig_MoonAttack_Actions takes nothing returns nothing 
    call DisableTrigger(GetTriggeringTrigger()) 
    if(Trig_MoonAttack_Func004C()) then 
        call SetStackedSoundBJ(true, gg_snd_WWII_submarine_dive_klaxon, gg_rct_MoonRect) 
        set udg_Moon_TakingDamage = true 
    else 
    endif 
    call StartTimerBJ(udg_Moon_ResetAlarm, false, 10.00) 
    call ForceClear(udg_Moon_PGroup) 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_MoonRect) 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_MoonRect), function Trig_MoonAttack_Func008A) 
    call DestroyGroup(udg_TempUnitGroup) 
    call ForForce(udg_Moon_PGroup, function Trig_MoonAttack_Func010A) 
    call PolledWait(5.00) 
    call ForForce(udg_Moon_PGroup, function Trig_MoonAttack_Func012A) 
    call EnableTrigger(gg_trg_MoonAttack) 
endfunction 

//=========================================================================== 
function InitTrig_MoonAttack takes nothing returns nothing 
    set gg_trg_MoonAttack = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_MoonAttack, gg_unit_h03T_0209, EVENT_UNIT_DAMAGED) 
    call TriggerAddCondition(gg_trg_MoonAttack, Condition(function Trig_MoonAttack_Conditions)) 
    call TriggerAddAction(gg_trg_MoonAttack, function Trig_MoonAttack_Actions) 
endfunction 

