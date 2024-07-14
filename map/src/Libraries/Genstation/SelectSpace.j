function Trig_SelectSpace_Func001C takes nothing returns boolean
    if ( ( GetSpellAbilityId() == 'A073' ) ) then
        return true
    endif
    if ( ( GetSpellAbilityId() == 'A085' ) ) then
        return true
    endif
    return false
endfunction

function Trig_SelectSpace_Conditions takes nothing returns boolean
    if ( not Trig_SelectSpace_Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_SelectSpace_Func005C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_SelectSpace_Actions takes nothing returns nothing
    set udg_TempUnit=LoadUnitHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("space"))
    set udg_TempPoint = GetUnitLoc(udg_TempUnit)
    if ( Trig_SelectSpace_Func005C() ) then
        call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint, 0 )
        call SelectUnitForPlayerSingle( udg_TempUnit, udg_Parasite )
    else
        call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0 )
        call SelectUnitForPlayerSingle( udg_TempUnit, GetOwningPlayer(GetSpellAbilityUnit()) )
    endif
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_SelectSpace takes nothing returns nothing
    set gg_trg_SelectSpace = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SelectSpace, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_SelectSpace, Condition( function Trig_SelectSpace_Conditions ) )
    call TriggerAddAction( gg_trg_SelectSpace, function Trig_SelectSpace_Actions )
endfunction

