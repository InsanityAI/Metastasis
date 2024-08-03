function Trig_ST10ExplorerAid_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A083' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST10ExplorerAid_Actions takes nothing returns nothing
    local player thisPlayer = GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempPoint = GetRectCenter(udg_SpaceObject_Rect[GetUnitUserData(GetSpellTargetUnit())])
    if thisPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA) then
        set thisPlayer = udg_Parasite
    endif
    call PanCameraToTimedLocForPlayer(thisPlayer, udg_TempPoint, 0.25)
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_ST10ExplorerAid takes nothing returns nothing
    set gg_trg_ST10ExplorerAid = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ST10ExplorerAid, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ST10ExplorerAid, Condition( function Trig_ST10ExplorerAid_Conditions ) )
    call TriggerAddAction( gg_trg_ST10ExplorerAid, function Trig_ST10ExplorerAid_Actions )
endfunction

