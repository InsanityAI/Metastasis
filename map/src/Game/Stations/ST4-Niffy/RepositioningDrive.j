function Trig_RepositioningDrive_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A074' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepositioningDrive_Func004C takes nothing returns boolean
    if ( not ( RectContainsLoc(gg_rct_Space, udg_TempPoint) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_RepositioningDrive_Actions takes nothing returns nothing
    set udg_TempPoint = GetSpellTargetLoc()
    if ( Trig_RepositioningDrive_Func004C() ) then
        call IssueImmediateOrderBJ( gg_unit_h009_0029, "stop" )
    else
    endif
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_RepositioningDrive takes nothing returns nothing
    set gg_trg_RepositioningDrive = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_RepositioningDrive, gg_unit_h009_0029, EVENT_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_RepositioningDrive, Condition( function Trig_RepositioningDrive_Conditions ) )
    call TriggerAddAction( gg_trg_RepositioningDrive, function Trig_RepositioningDrive_Actions )
endfunction

