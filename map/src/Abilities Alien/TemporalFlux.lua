//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_TemporalFlux_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A02Z' ) ) then
        return false
    endif
    return true
endfunction

function Trig_TemporalFlux_Actions takes nothing returns nothing
local unit a=GetSpellTargetUnit()
local item r
    call UnitRemoveBuffs(a,true,true)
    set udg_TempPoint = GetUnitLoc(a)
        set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
            set udg_TempUnitType = 'e00T'
    set udg_TempReal = 180.00
    call ExecuteFunc( "AlienRequirementRemove" )
    call ExecuteFunc( "AlienRequirementRestore" )
    call CreateNUnitsAtLoc( 1, 'e000', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING )
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "slow", a )
    call CreateNUnitsAtLoc( 1, 'e000', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING )
      set r= UnitAddItemByIdSwapped( 'I014', GetLastCreatedUnit() )
    call UnitUseItemTarget( GetLastCreatedUnit(), r, GetSpellTargetUnit() )

    call RemoveLocation( udg_TempPoint )
    call PolledWait(1)
    call RemoveItem(r)
    call UnitAddAbilityBJ( 'Avul',a )
    call PolledWait( 35.00 )
    call UnitRemoveAbilityBJ( 'Avul', a )
endfunction

//===========================================================================
function InitTrig_TemporalFlux takes nothing returns nothing
    set gg_trg_TemporalFlux = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_TemporalFlux, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_TemporalFlux, Condition( function Trig_TemporalFlux_Conditions ) )
    call TriggerAddAction( gg_trg_TemporalFlux, function Trig_TemporalFlux_Actions )
endfunction

