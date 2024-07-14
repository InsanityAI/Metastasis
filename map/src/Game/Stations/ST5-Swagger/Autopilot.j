function Trig_Autopilot_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A02P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Autopilot_Actions takes nothing returns nothing
    call DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 30, "|cff00FF00Autopilot engaged.|r")
    set udg_TempPoint = GetRectCenter(gg_rct_ST5Control)
    call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0 )
    call RemoveLocation(udg_TempPoint)
    call SetUnitOwner( gg_unit_h00Y_0050, Player(PLAYER_NEUTRAL_PASSIVE), true )
    call SetUnitOwner( gg_unit_h00X_0049, Player(PLAYER_NEUTRAL_PASSIVE), true )
    set udg_TempPoint2 = GetUnitLoc(gg_unit_h00X_0049)
    set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 5000.00, GetUnitFacing(gg_unit_h00X_0049))
    call IssuePointOrderLocBJ( gg_unit_h00X_0049, "move", udg_TempPoint )
    call RemoveLocation(udg_TempPoint)
    call RemoveLocation(udg_TempPoint2)
endfunction

//===========================================================================
function InitTrig_Autopilot takes nothing returns nothing
    set gg_trg_Autopilot = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_Autopilot, gg_unit_h00X_0049, EVENT_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Autopilot, Condition( function Trig_Autopilot_Conditions ) )
    call TriggerAddAction( gg_trg_Autopilot, function Trig_Autopilot_Actions )
endfunction

