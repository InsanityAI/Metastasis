function Trig_TeleportBomb_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A01A')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_TeleportBomb_Actions takes nothing returns nothing 
    local location a = GetSpellTargetLoc() 
    set udg_TempPoint = GetSpellTargetLoc() 
    call SetSoundPositionLocBJ(gg_snd_Poweringup, udg_TempPoint, 0) 
    call PlaySoundBJ(gg_snd_Poweringup) 
    call CreateNUnitsAtLoc(1, 'h015', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING) 
    call RemoveLocation(udg_TempPoint) 
    set udg_TempUnit = GetLastCreatedUnit() 
    set udg_CountUpBarColor = "|cff0000FF" 
    call BasicAI_IssueDangerArea(a, 800.0, 3.1) 
    call CountUpBar(udg_TempUnit, 60, 0.05, "TeleportBombExplosion") 
    set udg_TempPoint = a 
    call RemoveLocation(a) 
endfunction 

//=========================================================================== 
function InitTrig_TeleportBomb takes nothing returns nothing 
    set gg_trg_TeleportBomb = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_TeleportBomb, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_TeleportBomb, Condition(function Trig_TeleportBomb_Conditions)) 
    call TriggerAddAction(gg_trg_TeleportBomb, function Trig_TeleportBomb_Actions) 
endfunction 

