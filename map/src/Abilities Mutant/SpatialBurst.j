//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_SpatialBurst_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A02M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SpatialBurst_Actions takes nothing returns nothing
local unit a=GetSpellAbilityUnit()
local unit b=GetSpellTargetUnit()
call PolledWait(0.1)

    set udg_TempPoint = GetUnitLoc(b)
    set udg_TempPoint2=GetUnitLoc(a)
    if TerrainLineCheck(udg_TempPoint,udg_TempPoint2,30) then
    if RectContainsLoc(gg_rct_Timeout, udg_TempPoint)== false then
    call SetUnitPositionLoc( a, udg_TempPoint )
    endif
    endif
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation(udg_TempPoint2)
endfunction

//===========================================================================
function InitTrig_SpatialBurst takes nothing returns nothing
    set gg_trg_SpatialBurst = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SpatialBurst, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_SpatialBurst, Condition( function Trig_SpatialBurst_Conditions ) )
    call TriggerAddAction( gg_trg_SpatialBurst, function Trig_SpatialBurst_Actions )
endfunction

