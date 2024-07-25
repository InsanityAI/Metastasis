function Trig_AmbientPower_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06G')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AmbientPower_Func005A takes nothing returns nothing 
    call CreateNUnitsAtLoc(1, 'e01U', GetEnumPlayer(), udg_HoldZone, bj_UNIT_FACING) 
endfunction 

function Trig_AmbientPower_Actions takes nothing returns nothing 
    call TriggerExecute(gg_trg_ResetPowerBonus) 
    set udg_Power_Bonus = 1 
    call ForForce(GetPlayersAll(), function Trig_AmbientPower_Func005A) 
    call CreateNUnitsAtLoc(1, 'e01U', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING) 
    call PlaySoundBJ(gg_snd_LightningShieldTarget) 
endfunction 

//=========================================================================== 
function InitTrig_AmbientPower takes nothing returns nothing 
    set gg_trg_AmbientPower = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_AmbientPower, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_AmbientPower, Condition(function Trig_AmbientPower_Conditions)) 
    call TriggerAddAction(gg_trg_AmbientPower, function Trig_AmbientPower_Actions) 
endfunction 

