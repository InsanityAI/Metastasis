//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_DuplicateAntibodies_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A0AB' ) ) then
        return false
    endif
    return true
endfunction


function Trig_DuplicateAntibodies_Actions takes nothing returns nothing
    if ( GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I004') != null ) then
        //Create medpack at caster location
        call CreateItemLoc( 'I004', GetUnitLoc(GetTriggerUnit()) )
        
        //If less than 6, aka free inventory slot, give it straight to the unit!
        if ( UnitInventoryCount(GetTriggerUnit()) < 6 ) then
            call UnitAddItem( GetTriggerUnit(), GetLastCreatedItem())
        endif
    else//No antibodies to duplicate, so, refund the mana
        call SetUnitManaBJ( GetTriggerUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) + 100.00 ) )
    endif
endfunction

//===========================================================================
function InitTrig_DuplicateAntibodies takes nothing returns nothing
    set gg_trg_DuplicateAntibodies = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_DuplicateAntibodies, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_DuplicateAntibodies, Condition( function Trig_DuplicateAntibodies_Conditions ) )
    call TriggerAddAction( gg_trg_DuplicateAntibodies, function Trig_DuplicateAntibodies_Actions )
endfunction

