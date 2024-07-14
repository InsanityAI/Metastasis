function Trig_Rummage_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Func003Func004Func001Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Func003Func004Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Func003Func004Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Func003Func004C takes nothing returns boolean
    if ( not ( udg_TempInt == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Func003Func005C takes nothing returns boolean
    if ( not ( udg_TempInt <= 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Func003Func006C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetSpellTargetDestructable()) == 'LTcr' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Rummage_Func003C takes nothing returns boolean
    if ( not Trig_Rummage_Func003Func006C() ) then
        return false
    endif
    return true
endfunction

function Trig_Rummage_Actions takes nothing returns nothing
    if ( Trig_Rummage_Func003C() ) then
        set udg_TempInt = GetRandomInt(1, 28)
        call KillDestructable( GetSpellTargetDestructable() )
        if ( Trig_Rummage_Func003Func004C() ) then
            set udg_TempItemType = 'I01K'
        else
            if ( Trig_Rummage_Func003Func004Func001C() ) then
                set udg_TempItemType = 'I027'
            else
                if ( Trig_Rummage_Func003Func004Func001Func001C() ) then
                    set udg_TempItemType = 'I028'
                else
                    if ( Trig_Rummage_Func003Func004Func001Func001Func001C() ) then
                        set udg_TempItemType = 'I01J'
                    else
                    endif
                endif
            endif
        endif
        if ( Trig_Rummage_Func003Func005C() ) then
            set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
            call CreateItemLoc( udg_TempItemType, udg_TempPoint )
            call RemoveLocation(udg_TempPoint)
        else
        endif
    else
        call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 10.00, "This ability is meant to be used with crates.")
    endif
endfunction

//===========================================================================
function InitTrig_Rummage takes nothing returns nothing
    set gg_trg_Rummage = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Rummage, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Rummage, Condition( function Trig_Rummage_Conditions ) )
    call TriggerAddAction( gg_trg_Rummage, function Trig_Rummage_Actions )
endfunction

