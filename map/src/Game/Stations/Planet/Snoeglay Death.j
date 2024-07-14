function Trig_Snoeglay_Death_Func001C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetDyingUnit()) == 'n003' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetDyingUnit()) == 'h02E' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Snoeglay_Death_Conditions takes nothing returns boolean
    if ( not Trig_Snoeglay_Death_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Snoeglay_Death_Func003C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetKillingUnitBJ()) == Player(PLAYER_NEUTRAL_AGGRESSIVE) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Snoeglay_Death_Func004C takes nothing returns boolean
    if ( not ( udg_DeadSnoeglays == 15 ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetKillingUnitBJ()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) ) ) then
        return false
    endif
    if ( not ( GetRandomInt(1, 2) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Snoeglay_Death_Actions takes nothing returns nothing
    if ( Trig_Snoeglay_Death_Func003C() ) then
        set udg_TempPoint = GetRandomLocInRect(gg_rct_Planet)
        call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
        call RemoveLocation(udg_TempPoint)
    else
        set udg_DeadSnoeglays = ( udg_DeadSnoeglays + 1 )
    endif
    if ( Trig_Snoeglay_Death_Func004C() ) then
        set udg_TempPoint = GetUnitLoc(GetDyingUnit())
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl" )
        call SFXThreadClean()
        call CreateNUnitsAtLoc( 1, 'n005', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING )
        call UnitAddAbilityBJ( 'Arav', GetLastCreatedUnit() )
        call SetUnitFlyHeightBJ( GetLastCreatedUnit(), 2000.00, 0.00 )
        call SetUnitFlyHeightBJ( GetLastCreatedUnit(), 0.00, 1000.00 )
        call RemoveLocation(udg_TempPoint)
        call DestroyTrigger(GetTriggeringTrigger())
    else
        call DoNothing(  )
    endif
endfunction

//===========================================================================
function InitTrig_Snoeglay_Death takes nothing returns nothing
    set gg_trg_Snoeglay_Death = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Snoeglay_Death, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_Snoeglay_Death, Condition( function Trig_Snoeglay_Death_Conditions ) )
    call TriggerAddAction( gg_trg_Snoeglay_Death, function Trig_Snoeglay_Death_Actions )
endfunction

