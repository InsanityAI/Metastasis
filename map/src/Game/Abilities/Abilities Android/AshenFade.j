function Trig_AshenFade_Func002Func001C takes nothing returns boolean 
    if(not(IsUnitAliveBJ(GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AshenFade_Func002A takes nothing returns nothing 
    if(Trig_AshenFade_Func002Func001C()) then 
        // Damage it for 1 dmg 
        call UnitDamageTarget(GetEnumUnit(), GetEnumUnit(), 1, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
    else 
    endif 
endfunction 

function Trig_AshenFade_Actions takes nothing returns nothing 
    call ForGroupBJ(udg_AshenMarineGroup, function Trig_AshenFade_Func002A) 
endfunction 

//=========================================================================== 
function InitTrig_AshenFade takes nothing returns nothing 
    set gg_trg_AshenFade = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_AshenFade, udg_AshenMarineFadeTimer) 
    call TriggerAddAction(gg_trg_AshenFade, function Trig_AshenFade_Actions) 
endfunction 

