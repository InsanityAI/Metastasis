function Trig_ProjectedExplosion_Func001C takes nothing returns boolean
    if ( ( GetSpellAbilityId() == 'A03V' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A03X' ) ) then
        return true
    endif
    return false
endfunction

function Trig_ProjectedExplosion_Conditions takes nothing returns boolean
    if ( not Trig_ProjectedExplosion_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_ProjectedExplosion_Actions takes nothing returns nothing
    local location a=GetSpellTargetLoc()
    set udg_TempPoint=a
    call CreateNUnitsAtLoc( 1, 'e00R', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
    set udg_TempUnit = GetLastCreatedUnit()
    set udg_CountUpBarColor = "|cffFF0000"
    call BasicAI_IssueDangerArea(a,800.0,3.1)
    call CountUpBar(udg_TempUnit, 60, 0.05, "FusionBombExplosion2")
    call RemoveLocation(a)
endfunction

//===========================================================================
function InitTrig_ProjectedExplosion takes nothing returns nothing
    set gg_trg_ProjectedExplosion = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ProjectedExplosion, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ProjectedExplosion, Condition( function Trig_ProjectedExplosion_Conditions ) )
    call TriggerAddAction( gg_trg_ProjectedExplosion, function Trig_ProjectedExplosion_Actions )
endfunction

