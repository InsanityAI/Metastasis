function Trig_DoorInit2_Func003Func001Func006C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_DoorInit2_Func003Func001C takes nothing returns boolean
    if ( not Trig_DoorInit2_Func003Func001Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_DoorInit2_Func003A takes nothing returns nothing
    if ( Trig_DoorInit2_Func003Func001C() ) then
        set udg_TempDestruct = GetEnumDestructable()
        set udg_TempPoint = GetDestructableLoc(GetEnumDestructable())
        set udg_TempRect = Rect(( GetLocationX(udg_TempPoint) - 280.00 ), ( GetLocationY(udg_TempPoint) - 280.00 ), ( GetLocationX(udg_TempPoint) + 280.00 ), ( GetLocationY(udg_TempPoint) + 280.00 ))
        call RegisterSecurityDoor(udg_TempDestruct, udg_TempRect, 0)
        call RemoveLocation(udg_TempPoint)
    else
    endif
endfunction

function Trig_DoorInit2_Actions takes nothing returns nothing
    call DisableTrigger( GetTriggeringTrigger() )
    call EnumDestructablesInRectAll( GetPlayableMapRect(), function Trig_DoorInit2_Func003A )
    set udg_TempDestruct = gg_dest_B000_0656
    call DoorRegisterClearance(udg_TempDestruct,'I00J')
    set udg_TempDestruct = gg_dest_B000_1445
    call DoorRegisterClearance(udg_TempDestruct,'I00J')
    set udg_TempDestruct = gg_dest_B000_1811
    call DoorRegisterClearance(udg_TempDestruct,'I00J')
endfunction

//===========================================================================
function InitTrig_DoorInit2 takes nothing returns nothing
    set gg_trg_DoorInit2 = CreateTrigger(  )
    call TriggerAddAction( gg_trg_DoorInit2, function Trig_DoorInit2_Actions )
endfunction

