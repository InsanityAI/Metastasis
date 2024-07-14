function Trig_SantaHat_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01J' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SantaHat_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap( 'R00B', 1, GetOwningPlayer(GetManipulatingUnit()) )
    call SetItemDroppableBJ( GetManipulatedItem(), false )
endfunction

//===========================================================================
function InitTrig_SantaHat takes nothing returns nothing
    set gg_trg_SantaHat = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SantaHat, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_SantaHat, Condition( function Trig_SantaHat_Conditions ) )
    call TriggerAddAction( gg_trg_SantaHat, function Trig_SantaHat_Actions )
endfunction

