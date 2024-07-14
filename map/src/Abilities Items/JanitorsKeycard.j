function Trig_JanitorsKeycard_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I00J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_JanitorsKeycard_Func005Func001Func002C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_JanitorsKeycard_Func005Func001C takes nothing returns boolean
    if ( not Trig_JanitorsKeycard_Func005Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_JanitorsKeycard_Func005Func006Func001C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    if ( not ( udg_TempBool2 == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_JanitorsKeycard_Func005Func006C takes nothing returns boolean
    if ( not Trig_JanitorsKeycard_Func005Func006Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_JanitorsKeycard_Func005A takes nothing returns nothing
    if ( Trig_JanitorsKeycard_Func005Func001C() ) then
    else
        return
    endif
    set udg_TempBool = true
    set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1")) 
    set udg_TempBool=IsTriggerEnabled(udg_TempTrigger)
    set udg_TempBool2=udg_TempTrigger!=null
    if ( Trig_JanitorsKeycard_Func005Func006C() ) then
        call DisableTrigger( udg_TempTrigger )
        set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2")) 
        set udg_TempDoorHack = true
        call TriggerExecute( udg_TempTrigger )
        set udg_TempDoorHack = false
        call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger),StringHash("doorpath")),999999,true)
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetManipulatingUnit()), 0, 0, 11.00, "|cffffcc00Door locked.|r")
    else
        call EnableTrigger( udg_TempTrigger )
        call TriggerExecute( udg_TempTrigger )
        call KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")))
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetManipulatingUnit()), 0, 0, 11.00, "|cffffcc00Door unlocked.|r")
    endif
endfunction

function Trig_JanitorsKeycard_Func006C takes nothing returns boolean
    if ( not ( udg_TempBool == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_JanitorsKeycard_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
    set udg_TempBool = false
    call EnumDestructablesInCircleBJ( 256, udg_TempPoint, function Trig_JanitorsKeycard_Func005A )
    if ( Trig_JanitorsKeycard_Func006C() ) then
        call SetItemCharges( GetManipulatedItem(), 1 )
    else
    endif
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_JanitorsKeycard takes nothing returns nothing
    set gg_trg_JanitorsKeycard = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_JanitorsKeycard, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_JanitorsKeycard, Condition( function Trig_JanitorsKeycard_Conditions ) )
    call TriggerAddAction( gg_trg_JanitorsKeycard, function Trig_JanitorsKeycard_Actions )
endfunction

