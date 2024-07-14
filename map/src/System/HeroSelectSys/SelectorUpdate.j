function Trig_SelectorUpdate_Func002Func003C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SelectorUpdate_Func002A takes nothing returns nothing
    call SetUnitLifePercentBJ( GetEnumUnit(), ( GetUnitLifePercent(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) + 1.00 ) )
    call SetUnitManaPercentBJ( GetEnumUnit(), GetUnitManaPercent(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) )
    if ( Trig_SelectorUpdate_Func002Func003C() ) then
        call SetUnitPosition(GetEnumUnit(), GetUnitX(GetPlayerheroU(GetEnumUnit())), GetUnitY(GetPlayerheroU(GetEnumUnit())))
    else
    endif
endfunction

function Trig_SelectorUpdate_Actions takes nothing returns nothing
    call ForGroupBJ( udg_SelectorGroup, function Trig_SelectorUpdate_Func002A )
endfunction

//===========================================================================
function InitTrig_SelectorUpdate takes nothing returns nothing
    set gg_trg_SelectorUpdate = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_SelectorUpdate, 0.25 )
    call TriggerAddAction( gg_trg_SelectorUpdate, function Trig_SelectorUpdate_Actions )
endfunction

