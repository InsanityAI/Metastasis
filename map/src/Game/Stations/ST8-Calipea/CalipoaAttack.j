function Trig_CalipoaAttack_Conditions takes nothing returns boolean 
    if(not(gg_unit_h04E_0259 == GetAttacker())) then 
        return false 
    endif 
    return true 
endfunction 

function CalipoaResetAttack takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local lightning b = LoadLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackLightning")) 
    call DestroyLightning(b) 
    call DestroyTimer(k) 
    call SaveBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt"), false) 
    call StopSound(gg_snd_MagicLariatLoop1, false, true) 
endfunction 

function Trig_CalipoaAttack_Actions takes nothing returns nothing 
    local timer k 
    local lightning b 
    local unit m = GetTriggerUnit() 
    local real vb = GetUnitFacing(gg_unit_h04E_0259) * bj_DEGTORAD 
    if HaveSavedBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt")) and LoadBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt")) == true then 
        set k = LoadTimerHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackResetTimer")) 
        set b = LoadLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackLightning")) 
        call TimerStart(k, 0.1, false, function CalipoaResetAttack) 
        call MoveLightningEx(b, false, GetUnitX(gg_unit_h04E_0259) + 90.0 * Cos(vb), GetUnitY(gg_unit_h04E_0259) + 90.0 * Sin(vb), -170.0, GetUnitX(m) + 20.0 * Cos(vb), GetUnitY(m) + 20.0 * Sin(vb), -170.0) 

    else 
        set k = CreateTimer() 
        call TimerStart(k, 0.1, false, function CalipoaResetAttack) 
        call SaveTimerHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackResetTimer"), k) 
        call SaveLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackLightning"), AddLightningEx("AFOD", false, GetUnitX(gg_unit_h04E_0259) + 90.0 * Cos(vb), GetUnitY(gg_unit_h04E_0259) + 90.0 * Sin(vb), -170.0, GetUnitX(m) + 20.0 * Cos(vb), GetUnitY(m) + 20.0 * Sin(vb), -170.0)) 
        call SaveBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt"), true) 
        call SetSoundPosition(gg_snd_MagicLariatLoop1, GetUnitX(gg_unit_h04E_0259), GetUnitY(gg_unit_h04E_0259), 0.0) 
        call PlaySoundBJ(gg_snd_MagicLariatLoop1) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_CalipoaAttack takes nothing returns nothing 
    set gg_trg_CalipoaAttack = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_CalipoaAttack, EVENT_PLAYER_UNIT_ATTACKED) 
    call TriggerAddCondition(gg_trg_CalipoaAttack, Condition(function Trig_CalipoaAttack_Conditions)) 
    call TriggerAddAction(gg_trg_CalipoaAttack, function Trig_CalipoaAttack_Actions) 
endfunction 

