function Trig_AMTFire_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06U')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AMTFire_Func004Func004C takes nothing returns boolean 
    if((RectContainsUnit(gg_rct_Space, GetSpellTargetUnit()) != true)) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h002')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h02H')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h02L')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h02Q')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h02T')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h02P')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h031')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h032')) then 
        return true 
    endif 
    if((GetUnitTypeId(GetSpellTargetUnit()) == 'h03J')) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_AMTFire_Func004C takes nothing returns boolean 
    if(not Trig_AMTFire_Func004Func004C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AMTFire_Actions takes nothing returns nothing 
    local unit b = GetSpellTargetUnit() 
    if(Trig_AMTFire_Func004C()) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "TRIGSTR_5335") 
        call IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop") 
        return 
    else 
    endif 
    call DisplayTextToForce(GetPlayersAll(), ("|cffFF0000Antimatter Teleportation Matrix now has a targetting lock on " + (GetUnitName(GetSpellTargetUnit()) + "!|r"))) 
    call UnitRemoveAbilityBJ('A06U', gg_unit_h007_0027) 
    call PlaySoundBJ(gg_snd_Warning) 
    set udg_TempUnit = gg_unit_h007_0027 
    call TintUnitOverTime(udg_TempUnit, 45.0, 120, 255, 120) 
    call StartTimerBJ(udg_Kyo_ATM_WarningTimer, false, 60.00) 
    call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), ("|cffFF0000ATM- " + GetUnitName(GetSpellTargetUnit()))) 
    set udg_Kyo_ATM_CountdownWindow = GetLastCreatedTimerDialogBJ() 
    call PolledWait(59.50) 
    call PlaySoundBJ(gg_snd_FlashBack1Second) 
    call PolledWait(0.50) 
    call DestroyTimerDialogBJ(udg_Kyo_ATM_CountdownWindow) 
    call DestroyLightningRing(udg_Kyo_ATM_LightningRing) 
    set udg_TempUnit2 = b 
    call PlaySoundBJ(gg_snd_BlueFireBurst01) 
    call PlaySoundBJ(gg_snd_MarkOfChaos01) 
    call PlaySoundBJ(gg_snd_HumanDissipate1) 
    set udg_TempUnit = gg_unit_h007_0027 
    call AddLightningStormEx("DRAL", GetUnitX(udg_TempUnit), GetUnitY(udg_TempUnit), 650.0, GetUnitX(udg_TempUnit2), GetUnitY(udg_TempUnit2), 125.0, 26, 90.0) 
    call UnitDamageTargetBJ(gg_unit_h007_0027, udg_TempUnit2, 900000.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL) 
    call PolledWait(0.50) 
    call SetUnitVertexColorBJ(gg_unit_h007_0027, 100, 100, 100, 0) 
    set udg_Kyo_ATM_Armed = false 
endfunction 

//=========================================================================== 
function InitTrig_AMTFire takes nothing returns nothing 
    set gg_trg_AMTFire = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_AMTFire, gg_unit_h007_0027, EVENT_UNIT_SPELL_CAST) 
    call TriggerAddCondition(gg_trg_AMTFire, Condition(function Trig_AMTFire_Conditions)) 
    call TriggerAddAction(gg_trg_AMTFire, function Trig_AMTFire_Actions) 
endfunction 

