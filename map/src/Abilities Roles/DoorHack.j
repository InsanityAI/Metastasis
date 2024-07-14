function Trig_DoorHack_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A053' ) ) then
        return false
    endif
    return true
endfunction

function Trig_DoorHack_Func004Func001Func002C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_DoorHack_Func004Func001C takes nothing returns boolean
    if ( not Trig_DoorHack_Func004Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_DoorHack_Func004Func005Func001C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    if ( not ( udg_TempBool2 == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_DoorHack_Func004Func005C takes nothing returns boolean
    if ( not Trig_DoorHack_Func004Func005Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_DoorHack_Func004A takes nothing returns nothing
    if ( Trig_DoorHack_Func004Func001C() ) then
    else
        return
    endif
    set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1")) 
    set udg_TempBool=IsTriggerEnabled(udg_TempTrigger)
    set udg_TempBool2=udg_TempTrigger!=null
    if ( Trig_DoorHack_Func004Func005C() ) then
        call DisableTrigger( udg_TempTrigger )
        set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2")) 
        set udg_TempDoorHack = true
        call TriggerExecute( udg_TempTrigger )
        set udg_TempDoorHack = false
        call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger),StringHash("doorpath")),999999,true)
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 11.00, "|cffffcc00Door locked.|r")
        set udg_TempPoint = GetDestructableLoc(GetEnumDestructable())
        call CreateNUnitsAtLoc( 1, 'e01A', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING )
        call RemoveLocation(udg_TempPoint)
        set udg_TempUnit = GetLastCreatedUnit()
        set udg_CountUpBarColor = "|cff000000"
        call SaveDestructableHandle(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("kittens"),GetEnumDestructable())
        call CountUpBar(udg_TempUnit, 30, 0.50, "DoorResetLock")
    else
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 11.00, "|cffffcc00Door's not unlocked...|r")
    endif
endfunction

function Trig_DoorHack_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call EnumDestructablesInCircleBJ( 256, udg_TempPoint, function Trig_DoorHack_Func004A )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_DoorHack takes nothing returns nothing
    set gg_trg_DoorHack = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_DoorHack, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_DoorHack, Condition( function Trig_DoorHack_Conditions ) )
    call TriggerAddAction( gg_trg_DoorHack, function Trig_DoorHack_Actions )
endfunction

