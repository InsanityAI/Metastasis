function Trig_ST3Cannon_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Cannon_Func003Func004C takes nothing returns boolean
    if ( ( RectContainsUnit(gg_rct_Space, GetSpellTargetUnit()) != true ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h002' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02H' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02L' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02Q' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02T' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02P' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h031' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h032' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h03J' ) ) then
        return true
    endif
    return false
endfunction

function Trig_ST3Cannon_Func003C takes nothing returns boolean
    if ( not Trig_ST3Cannon_Func003Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Cannon_Actions takes nothing returns nothing
    if ( Trig_ST3Cannon_Func003C() ) then
        call DisplayTextToPlayer( GetOwningPlayer(GetTriggerUnit()), 0, 0, "TRIGSTR_5334" )
        call IssueImmediateOrderBJ( GetSpellAbilityUnit(), "stop" )
        return
    else
    endif
    call DisplayTextToForce( GetPlayersAll(), ( "|cffFF0000The Kyo Cannon has been fired at " + ( GetUnitName(GetSpellTargetUnit()) + "!|r" ) ) )
    call PlaySoundBJ( gg_snd_HumanDissipate1 )
    call PolledWait( 1.00 )
    call PlaySoundBJ( gg_snd_ThunderClapCaster )
endfunction

//===========================================================================
function InitTrig_ST3Cannon takes nothing returns nothing
    set gg_trg_ST3Cannon = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_ST3Cannon, gg_unit_h007_0027, EVENT_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_ST3Cannon, Condition( function Trig_ST3Cannon_Conditions ) )
    call TriggerAddAction( gg_trg_ST3Cannon, function Trig_ST3Cannon_Actions )
endfunction

