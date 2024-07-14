function Trig_TaintedVendorBuy_Conditions takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A01U', GetTriggerUnit()) != 0 ) ) then
        return false
    endif
    if ( not ( udg_Mutant != GetOwningPlayer(GetBuyingUnit()) ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetBuyingUnit()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_TaintedVendorBuy_Func005C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'I004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_TaintedVendorBuy_Actions takes nothing returns nothing
    if ( Trig_TaintedVendorBuy_Func005C() ) then
        call RemoveItem( GetSoldItem() )
    else
    endif
    set udg_TempPoint = GetUnitLoc(GetBuyingUnit())
    call CreateNUnitsAtLoc( 1, 'e000', udg_Mutant, udg_TempPoint, bj_UNIT_FACING )
    call RemoveLocation(udg_TempPoint)
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "parasite", GetBuyingUnit() )
endfunction

//===========================================================================
function InitTrig_TaintedVendorBuy takes nothing returns nothing
    set gg_trg_TaintedVendorBuy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_TaintedVendorBuy, EVENT_PLAYER_UNIT_SELL_ITEM )
    call TriggerAddCondition( gg_trg_TaintedVendorBuy, Condition( function Trig_TaintedVendorBuy_Conditions ) )
    call TriggerAddAction( gg_trg_TaintedVendorBuy, function Trig_TaintedVendorBuy_Actions )
endfunction

