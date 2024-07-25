function Trig_StationPower_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06E')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_StationPower_Func005Func001C takes nothing returns boolean 
    if not(IsUnitStation(GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_StationPower_Func005A takes nothing returns nothing 
    if(Trig_StationPower_Func005Func001C()) then 
        call UnitAddAbilityBJ('A06M', GetEnumUnit()) 
        call UnitAddAbilityBJ('A06L', GetEnumUnit()) 
    else 
    endif 
endfunction 

function Trig_StationPower_Actions takes nothing returns nothing 
    call TriggerExecute(gg_trg_ResetPowerBonus) 
    set udg_Power_Bonus = 3 
    call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), function Trig_StationPower_Func005A) 
    call IncUnitAbilityLevelSwapped('A005', gg_unit_h007_0027) 
    call PlaySoundBJ(gg_snd_LightningShieldTarget) 
endfunction 

//=========================================================================== 
function InitTrig_StationPower takes nothing returns nothing 
    set gg_trg_StationPower = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_StationPower, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_StationPower, Condition(function Trig_StationPower_Conditions)) 
    call TriggerAddAction(gg_trg_StationPower, function Trig_StationPower_Actions) 
endfunction 

