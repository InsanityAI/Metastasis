function Trig_Overlorddockbug_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A001' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h04G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Overlorddockbug_Func006C takes nothing returns boolean
    if ( not ( DistanceBetweenPoints(udg_Spaceship_Overlordcomparison, udg_Overlord_Spaceshipcomparison) <= 200.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Overlorddockbug_Actions takes nothing returns nothing
    set udg_Spaceship_Overlordcomparison = GetUnitLoc(GetTriggerUnit())
    set udg_Overlord_Spaceshipcomparison = GetUnitLoc(GetEventTargetUnit())
    if ( Trig_Overlorddockbug_Func006C() ) then
        call PauseUnitBJ( true, GetTriggerUnit() )
        call TriggerSleepAction( 1.00 )
        call PauseUnitBJ( false, GetTriggerUnit() )
    else
    endif
endfunction

//===========================================================================
function InitTrig_Overlorddockbug takes nothing returns nothing
    set gg_trg_Overlorddockbug = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Overlorddockbug, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Overlorddockbug, Condition( function Trig_Overlorddockbug_Conditions ) )
    call TriggerAddAction( gg_trg_Overlorddockbug, function Trig_Overlorddockbug_Actions )
endfunction

