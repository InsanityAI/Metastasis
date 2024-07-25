//TESH.scrollpos=12 
//TESH.alwaysfold=0 
function Trig_RepositioningDriveGo_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A074')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RepositioningDriveGo_Func002C takes nothing returns boolean 
    if(not(RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RepositioningDriveGo_Actions takes nothing returns nothing 
    local location a 
    local location b 
    set udg_TempPoint = GetSpellTargetLoc() 
    set a = udg_TempPoint 
    if(Trig_RepositioningDriveGo_Func002C()) then 
        call IssueImmediateOrderBJ(gg_unit_h009_0029, "stop") 
        call RemoveLocation(udg_TempPoint) 
        return 
    else 
    endif 
    call PauseUnit(gg_unit_h009_0029, true) 
    set b = GetUnitLoc(gg_unit_h009_0029) 
    call CreateNUnitsAtLoc(1, 'e021', Player(PLAYER_NEUTRAL_PASSIVE), b, bj_UNIT_FACING) 
    call SizeUnitOverTime(GetLastCreatedUnit(), 20.0, 0.1, 8, true) 
    call TintUnitOverTime(gg_unit_h009_0029, 20.2, 0, 100, 10) 
    call PolledWait(16.50) 
    call SetSoundPositionLocBJ(gg_snd_Poweringup, b, 0) 
    call PlaySoundBJ(gg_snd_Poweringup) 
    call PolledWait(3.5) 
    call PauseUnit(gg_unit_h009_0029, false) 
    call CreateNUnitsAtLoc(1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), a, bj_UNIT_FACING) 
    call SetUnitScale(GetLastCreatedUnit(), 6, 6, 6) 
    call SetUnitTimeScale(GetLastCreatedUnit(), 2.0) 
    call CreateNUnitsAtLoc(1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), b, bj_UNIT_FACING) 
    call SetUnitScale(GetLastCreatedUnit(), 6, 6, 6) 
    call SetUnitTimeScale(GetLastCreatedUnit(), 2.0) 
    call SetUnitPositionLoc(gg_unit_h009_0029, a) 
    call SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, a, 0) 
    call PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1) 
    call SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, b, 0) 
    call PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1) 
    call RemoveLocation(a) 
    call RemoveLocation(b) 
    call PolledWait(2.0) 
    call SetUnitVertexColor(gg_unit_h009_0029, 256, 256, 256, 256) 
endfunction 

//=========================================================================== 
function InitTrig_RepositioningDriveGo takes nothing returns nothing 
    set gg_trg_RepositioningDriveGo = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_RepositioningDriveGo, gg_unit_h009_0029, EVENT_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_RepositioningDriveGo, Condition(function Trig_RepositioningDriveGo_Conditions)) 
    call TriggerAddAction(gg_trg_RepositioningDriveGo, function Trig_RepositioningDriveGo_Actions) 
endfunction 

