function Trig_Alodimensional_A_I_Func002A takes nothing returns nothing
endfunction

function Trig_Alodimensional_A_I_Func006C takes nothing returns boolean
    if ( not ( IsUnitGroupEmptyBJ(GetLastCreatedGroup()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Alodimensional_A_I_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsInRangeOfLocAll(600.00, GetUnitLoc(udg_Extraterrestial_unit)), function Trig_Alodimensional_A_I_Func002A )
    set udg_TempUnitGroup = GetLastCreatedGroup()
    call GroupRemoveUnitSimple( udg_Extraterrestial_unit, GetLastCreatedGroup() )
    set udg_TempPoint = OffsetLocation(GetUnitLoc(udg_Extraterrestial_unit), GetRandomReal(0, 360.00), GetRandomReal(0, 360.00))
    if ( Trig_Alodimensional_A_I_Func006C() ) then
        call IssueTargetOrderBJ( udg_Extraterrestial_unit, "attack", GroupPickRandomUnit(udg_TempUnitGroup) )
    else
        call SetUnitPositionLocFacingLocBJ( udg_Extraterrestial_unit, udg_TempPoint, udg_TempPoint )
    endif
    call RemoveLocation(udg_TempPoint)
    call DestroyGroup(udg_TempUnitGroup)
endfunction

//===========================================================================
function InitTrig_Alodimensional_A_I takes nothing returns nothing
    set gg_trg_Alodimensional_A_I = CreateTrigger(  )
    call DisableTrigger( gg_trg_Alodimensional_A_I )
    call TriggerRegisterTimerEventPeriodic( gg_trg_Alodimensional_A_I, 6.00 )
    call TriggerAddAction( gg_trg_Alodimensional_A_I, function Trig_Alodimensional_A_I_Actions )
endfunction

