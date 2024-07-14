function Trig_RDGLimitHard_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnteringUnit()) == 'e018' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RDGLimitHard_Func003002002001 takes nothing returns boolean
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
endfunction

function Trig_RDGLimitHard_Func003002002002 takes nothing returns boolean
    return ( GetUnitTypeId(GetFilterUnit()) == 'e018' )
endfunction

function Trig_RDGLimitHard_Func003002002 takes nothing returns boolean
    return GetBooleanAnd( Trig_RDGLimitHard_Func003002002001(), Trig_RDGLimitHard_Func003002002002() )
endfunction

function Trig_RDGLimitHard_Func004C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(udg_TempUnitGroup) > 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RDGLimitHard_Actions takes nothing returns nothing
    set udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetEnteringUnit()), Condition(function Trig_RDGLimitHard_Func003002002))
    if ( Trig_RDGLimitHard_Func004C() ) then
        call RemoveUnit( GetEnteringUnit() )
    else
    endif
        call DestroyGroup( udg_TempUnitGroup )
        call DestroyGroup( udg_TempUnitGroup2 )
endfunction

//===========================================================================
function InitTrig_RDGLimitHard takes nothing returns nothing
    set gg_trg_RDGLimitHard = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_RDGLimitHard, GetPlayableMapRect() )
    call TriggerAddCondition( gg_trg_RDGLimitHard, Condition( function Trig_RDGLimitHard_Conditions ) )
    call TriggerAddAction( gg_trg_RDGLimitHard, function Trig_RDGLimitHard_Actions )
endfunction

