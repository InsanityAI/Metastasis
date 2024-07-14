function Trig_SuitsDrop_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AF' ) ) then
        return false
    endif
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_SuitsDrop_Func013C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_TempUnit) == 'h04K' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SuitsDrop_Actions takes nothing returns nothing
    set udg_TempUnit = GetSpellAbilityUnit()
    set udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))]
    set udg_TempReal = GetUnitLifePercent(udg_TempUnit)
    call SetItemUserData( udg_TempItem, 0 )
    call SetItemVisibleBJ( true, udg_TempItem )
    set udg_TempPoint = GetUnitLoc(udg_TempUnit)
    call SetItemPositionLoc( udg_TempItem, udg_TempPoint )
    call RemoveLocation(udg_TempPoint)
    call UnitAddItemSwapped( udg_TempItem, udg_TempUnit )
    if ( Trig_SuitsDrop_Func013C() ) then
        if HaveSavedHandle(LS(),GetHandleId(udg_TempUnit),StringHash("Suit_SlivGroup")) then
        call DestroyGroup(LoadGroupHandle(LS(),GetHandleId(udg_TempUnit),StringHash("Suit_SlivGroup")))
        endif
    else
    endif
    call UnitAddAbilityBJ( 'S001', udg_TempUnit )
    call SetUnitAbilityLevelSwapped( 'S001', udg_TempUnit, 1 )
    call SetUnitLifePercentBJ( udg_TempUnit, udg_TempReal )
    set udg_TempUnit = GetSpellAbilityUnit()
    call ExecuteFunc("SuitRoleAbilityReAdd")
endfunction

//===========================================================================
function InitTrig_SuitsDrop takes nothing returns nothing
    set gg_trg_SuitsDrop = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SuitsDrop, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_SuitsDrop, Condition( function Trig_SuitsDrop_Conditions ) )
    call TriggerAddAction( gg_trg_SuitsDrop, function Trig_SuitsDrop_Actions )
endfunction

