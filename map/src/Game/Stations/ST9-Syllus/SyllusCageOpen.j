function Trig_SyllusCageOpen_Func002Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func002Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func002Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02O' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func003Func001Func002C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SyllusCageOpen_Func003Func001C takes nothing returns boolean
    if ( not Trig_SyllusCageOpen_Func003Func001Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func003Func005Func001C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    if ( not ( udg_TempBool2 == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func003Func005C takes nothing returns boolean
    if ( not Trig_SyllusCageOpen_Func003Func005Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageOpen_Func003A takes nothing returns nothing
    if ( Trig_SyllusCageOpen_Func003Func001C() ) then
    else
        return
    endif
    set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1")) 
    set udg_TempBool=IsTriggerEnabled(udg_TempTrigger)
    set udg_TempBool2= udg_TempTrigger==null
    if ( Trig_SyllusCageOpen_Func003Func005C() ) then
        call DisableTrigger( udg_TempTrigger )
        set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2")) 
        set udg_TempDoorHack = true
        call TriggerExecute( udg_TempTrigger )
        set udg_TempDoorHack = false
        call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger),StringHash("doorpath")),999999,true)
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 11.00, "|cffffcc00Cell locked.|r")
    else
        call EnableTrigger( udg_TempTrigger )
        call TriggerExecute( udg_TempTrigger )
        call KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")))
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 11.00, "|cffffcc00Cell unlocked.|r")
    endif
endfunction

function Trig_SyllusCageOpen_Actions takes nothing returns nothing
    if ( Trig_SyllusCageOpen_Func002C() ) then
        set udg_TempPoint = GetRectCenter(gg_rct_Cage1)
    else
        if ( Trig_SyllusCageOpen_Func002Func001C() ) then
            set udg_TempPoint = GetRectCenter(gg_rct_Cage2)
            call KillDestructable( gg_dest_YTab_4373 )
            call KillDestructable( gg_dest_YTab_4372 )
            call KillDestructable( gg_dest_YTab_4371 )
            call KillDestructable( gg_dest_YTab_4370 )
            call KillDestructable( gg_dest_YTab_4369 )
        else
            if ( Trig_SyllusCageOpen_Func002Func001Func001C() ) then
                set udg_TempPoint = GetRectCenter(gg_rct_Cage3)
            else
                if ( Trig_SyllusCageOpen_Func002Func001Func001Func001C() ) then
                    set udg_TempPoint = GetRectCenter(gg_rct_Cage4)
                else
                    if ( Trig_SyllusCageOpen_Func002Func001Func001Func001Func001C() ) then
                        set udg_TempPoint = GetRectCenter(gg_rct_Cage5)
                    else
                        if ( Trig_SyllusCageOpen_Func002Func001Func001Func001Func001Func001C() ) then
                            set udg_TempPoint = GetRectCenter(gg_rct_Cage6)
                        else
                            return
                        endif
                    endif
                endif
            endif
        endif
    endif
    call EnumDestructablesInCircleBJ( 900.00, udg_TempPoint, function Trig_SyllusCageOpen_Func003A )
endfunction

//===========================================================================
function InitTrig_SyllusCageOpen takes nothing returns nothing
    set gg_trg_SyllusCageOpen = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SyllusCageOpen, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddAction( gg_trg_SyllusCageOpen, function Trig_SyllusCageOpen_Actions )
endfunction

