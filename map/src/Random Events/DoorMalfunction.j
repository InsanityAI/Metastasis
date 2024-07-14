function Trig_DoorMalfunction_Func002Func001Func001C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_DoorMalfunction_Func002Func001C takes nothing returns boolean
    if ( not Trig_DoorMalfunction_Func002Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_DoorMalfunction_Func002A takes nothing returns nothing
    if ( Trig_DoorMalfunction_Func002Func001C() ) then
        call DoorMalfunction(GetEnumDestructable())
    else
    endif
endfunction

function Trig_DoorMalfunction_Func006002 takes nothing returns nothing
    call RemoveUnit( GetEnumUnit() )
endfunction

function Trig_DoorMalfunction_Func007Func001Func001C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_DoorMalfunction_Func007Func001C takes nothing returns boolean
    if ( not Trig_DoorMalfunction_Func007Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_DoorMalfunction_Func007A takes nothing returns nothing
    if ( Trig_DoorMalfunction_Func007Func001C() ) then
        call DoorMalfunction_End(GetEnumDestructable())
    else
    endif
endfunction

function Trig_DoorMalfunction_Actions takes nothing returns nothing
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4340" )
    call EnumDestructablesInRectAll( GetEntireMapRect(), function Trig_DoorMalfunction_Func002A )
    call TriggerSleepAction( GetRandomReal(300.00, 600.00) )
    call TriggerExecute( gg_trg_DoorInit2 )
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4341" )
    call ForGroupBJ( GetUnitsOfTypeIdAll('e039'), function Trig_DoorMalfunction_Func006002 )
    call EnumDestructablesInRectAll( GetEntireMapRect(), function Trig_DoorMalfunction_Func007A )
endfunction

//===========================================================================
function InitTrig_DoorMalfunction takes nothing returns nothing
    set gg_trg_DoorMalfunction = CreateTrigger(  )
    call DisableTrigger( gg_trg_DoorMalfunction )
    call TriggerAddAction( gg_trg_DoorMalfunction, function Trig_DoorMalfunction_Actions )
endfunction

