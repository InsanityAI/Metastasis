function Trig_DragIntoSun_Func003Func001Func003Func001C takes nothing returns boolean
    if ( ( udg_TempBool == true ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h031' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h032' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h02P' ) ) then
        return true
    endif
    return false
endfunction

function Trig_DragIntoSun_Func003Func001Func003C takes nothing returns boolean
    if ( not Trig_DragIntoSun_Func003Func001Func003Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_DragIntoSun_Func003Func001C takes nothing returns boolean
    if ( not ( GetEnumUnit() != udg_TempUnit ) ) then
        return false
    endif
    return true
endfunction

function Trig_DragIntoSun_Func003A takes nothing returns nothing
    if ( Trig_DragIntoSun_Func003Func001C() ) then
        set udg_TempBool=IsUnitExplorer(GetEnumUnit())
        set udg_TempReal=AngleBetweenUnits(GetEnumUnit(),gg_unit_h01A_0197)
        if ( Trig_DragIntoSun_Func003Func001Func003C() ) then
            call SetUnitX(GetEnumUnit(),GetUnitX(GetEnumUnit())+CosBJ(udg_TempReal)*(GetUnitMoveSpeed(GetEnumUnit())+15)/25)
            call SetUnitY(GetEnumUnit(),GetUnitY(GetEnumUnit())+SinBJ(udg_TempReal)*(GetUnitMoveSpeed(GetEnumUnit())+15)/25)
        else
            set udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 1.00, udg_TempReal)
            call SetUnitPositionLoc( GetEnumUnit(), udg_TempPoint )
            call RemoveLocation(udg_TempPoint)
            call RemoveLocation(udg_TempPoint2)
        endif
    else
    endif
endfunction

function Trig_DragIntoSun_Actions takes nothing returns nothing
    set udg_TempUnit = gg_unit_h01A_0197
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Space), function Trig_DragIntoSun_Func003A )
endfunction

//===========================================================================
function InitTrig_DragIntoSun takes nothing returns nothing
    set gg_trg_DragIntoSun = CreateTrigger(  )
    call DisableTrigger( gg_trg_DragIntoSun )
    call TriggerRegisterTimerEventPeriodic( gg_trg_DragIntoSun, 0.04 )
    call TriggerAddAction( gg_trg_DragIntoSun, function Trig_DragIntoSun_Actions )
endfunction

