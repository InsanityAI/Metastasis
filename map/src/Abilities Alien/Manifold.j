//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Manifold_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A03Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Manifold_Actions takes nothing returns nothing
local item r
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call CreateNUnitsAtLoc( 1, 'e000', Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING )
      set r= UnitAddItemByIdSwapped( 'I016', GetLastCreatedUnit() )
    call UnitUseItemTarget( GetLastCreatedUnit(), r, GetSpellAbilityUnit() )

    call RemoveLocation( udg_TempPoint )
        set udg_TempUnitType = 'e00S'
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempReal = 50.00
    call ExecuteFunc( "AlienRequirementRemove" )
    call ExecuteFunc( "AlienRequirementRestore" )
    call PolledWait(1)
    call RemoveItem(r)
endfunction

//===========================================================================
function InitTrig_Manifold takes nothing returns nothing
    set gg_trg_Manifold = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Manifold, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Manifold, Condition( function Trig_Manifold_Conditions ) )
    call TriggerAddAction( gg_trg_Manifold, function Trig_Manifold_Actions )
endfunction

