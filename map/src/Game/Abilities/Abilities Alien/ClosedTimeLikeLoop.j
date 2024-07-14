function Trig_ClosedTimeLikeLoop_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A033' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func004C takes nothing returns boolean
    if ( not ( udg_TempInt > 40 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func005C takes nothing returns boolean
    if ( not ( udg_CTL_PosXArray[udg_TempInt] == 0.00 ) ) then
        return false
    endif
    if ( not ( udg_CTL_PosYArray[udg_TempInt] == 0.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func012Func001Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetLastReplacedUnitBJ()) == 'h00H' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func012Func001C takes nothing returns boolean
    if ( not ( udg_CTL_UnitType[udg_TempInt] != 'h02Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func012C takes nothing returns boolean
    if ( not ( GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) != udg_CTL_UnitType[udg_TempInt] ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func016C takes nothing returns boolean
    if ( not ( RectContainsLoc(gg_rct_Timeout, udg_TempPoint) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func020Func001C takes nothing returns boolean
    if ( not ( GetItemLevel(UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA())) == 10 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func022C takes nothing returns boolean
    if ( not ( GetItemLevel(GetLastCreatedItem()) == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func023C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetLastCreatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func025C takes nothing returns boolean
    if ( not ( GetItemLevel(GetLastCreatedItem()) == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func026C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetLastCreatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func027C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetLastCreatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func029C takes nothing returns boolean
    if ( not ( GetItemLevel(GetLastCreatedItem()) == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func030C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetLastCreatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func032C takes nothing returns boolean
    if ( not ( GetItemLevel(GetLastCreatedItem()) == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func033C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetLastCreatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func035C takes nothing returns boolean
    if ( not ( GetItemLevel(GetLastCreatedItem()) == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func037C takes nothing returns boolean
    if ( not ( GetItemLevel(GetLastCreatedItem()) == 8 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Func038C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetLastCreatedItem()) == 'I00L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ClosedTimeLikeLoop_Actions takes nothing returns nothing
    set udg_TempInt = ( udg_CTL_On + 1 )
    if ( Trig_ClosedTimeLikeLoop_Func004C() ) then
        set udg_TempInt = 1
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func005C() ) then
        return
    else
    endif
    set udg_TempPoint = Location(udg_CTL_PosXArray[udg_TempInt], udg_CTL_PosYArray[udg_TempInt])
    // Start - Bugfix Block for when you were in pod
    if ( RectContainsCoords(gg_rct_Timeout, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint))) then
    return
    endif
    // End - Bugfix Block for when you were in pod
    if ( Trig_ClosedTimeLikeLoop_Func012C() ) then
        if ( Trig_ClosedTimeLikeLoop_Func012Func001C() ) then
            call ReplaceUnitBJ( udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], udg_CTL_UnitType[udg_TempInt], bj_UNIT_STATE_METHOD_RELATIVE )
            call SetUnitOwner( GetLastReplacedUnitBJ(), udg_Parasite, true )
            set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastReplacedUnitBJ()
            if ( Trig_ClosedTimeLikeLoop_Func012Func001Func004C() ) then
                call UnitAddAbilityBJ( 'A02O', GetLastReplacedUnitBJ() )
            else
            endif
        else
            call ReplaceUnitBJ( udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], udg_CTL_UnitType[udg_TempInt], bj_UNIT_STATE_METHOD_RELATIVE )
            set udg_AlienForm_Alien = GetLastReplacedUnitBJ()
            set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastReplacedUnitBJ()
            set udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastReplacedUnitBJ()
        endif
    else
    endif
    set udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]
    call SelectUnitForPlayerSingle( udg_TempUnit, udg_Parasite )
    call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint, 0 )
    if ( Trig_ClosedTimeLikeLoop_Func016C() ) then
        call SetUnitPositionLocFacingBJ( udg_TempUnit, udg_TempPoint, udg_CTL_Facing[udg_TempInt] )
    else
    endif
    call SetUnitLifeBJ( udg_TempUnit, udg_CTL_UnitHealth[udg_TempInt] )
    call SetUnitManaBJ( udg_TempUnit, udg_CTL_UnitMana[udg_TempInt] )
    call SetUnitManaBJ( udg_TempUnit, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_TempUnit) - 25.00 ) )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( Trig_ClosedTimeLikeLoop_Func020Func001C() ) then
            call UnitRemoveItemSwapped( UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()), udg_TempUnit )
        else
            call RemoveItem( UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()) )
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call UnitAddItemByIdSwapped( udg_CTL_InventorySlot1[udg_TempInt], udg_TempUnit )
    if ( Trig_ClosedTimeLikeLoop_Func022C() ) then
        call RemoveItem( GetLastCreatedItem() )
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func023C() ) then
        call RemoveItem( GetLastCreatedItem() )
        call UnitAddItemByIdSwapped( 'I01Y', udg_TempUnit )
    else
    endif
    call UnitAddItemByIdSwapped( udg_CTL_InventorySlot2[udg_TempInt], udg_TempUnit )
    if ( Trig_ClosedTimeLikeLoop_Func025C() ) then
        call RemoveItem( GetLastCreatedItem() )
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func026C() ) then
        call RemoveItem( GetLastCreatedItem() )
        call UnitAddItemByIdSwapped( 'I01Y', udg_TempUnit )
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func027C() ) then
        call RemoveItem( GetLastCreatedItem() )
        call UnitAddItemByIdSwapped( 'I01Y', udg_TempUnit )
    else
    endif
    call UnitAddItemByIdSwapped( udg_CTL_InventorySlot3[udg_TempInt], udg_TempUnit )
    if ( Trig_ClosedTimeLikeLoop_Func029C() ) then
        call RemoveItem( GetLastCreatedItem() )
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func030C() ) then
        call RemoveItem( GetLastCreatedItem() )
        call UnitAddItemByIdSwapped( 'I01Y', udg_TempUnit )
    else
    endif
    call UnitAddItemByIdSwapped( udg_CTL_InventorySlot4[udg_TempInt], udg_TempUnit )
    if ( Trig_ClosedTimeLikeLoop_Func032C() ) then
        call RemoveItem( GetLastCreatedItem() )
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func033C() ) then
        call RemoveItem( GetLastCreatedItem() )
        call UnitAddItemByIdSwapped( 'I01Y', udg_TempUnit )
    else
    endif
    call UnitAddItemByIdSwapped( udg_CTL_InventorySlot5[udg_TempInt], udg_TempUnit )
    if ( Trig_ClosedTimeLikeLoop_Func035C() ) then
        call RemoveItem( GetLastCreatedItem() )
    else
    endif
    call UnitAddItemByIdSwapped( udg_CTL_InventorySlot6[udg_TempInt], udg_TempUnit )
    if ( Trig_ClosedTimeLikeLoop_Func037C() ) then
        call RemoveItem( GetLastCreatedItem() )
    else
    endif
    if ( Trig_ClosedTimeLikeLoop_Func038C() ) then
        call RemoveItem( GetLastCreatedItem() )
        call UnitAddItemByIdSwapped( 'I01Y', udg_TempUnit )
    else
    endif
    call RemoveLocation(udg_TempPoint)
    set udg_TempUnitType = 'e00K'
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempReal = 40.00
    call ExecuteFunc("AlienRequirementRemove")
    call ExecuteFunc("AlienRequirementRestore")
endfunction

//===========================================================================
function InitTrig_ClosedTimeLikeLoop takes nothing returns nothing
    set gg_trg_ClosedTimeLikeLoop = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ClosedTimeLikeLoop, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ClosedTimeLikeLoop, Condition( function Trig_ClosedTimeLikeLoop_Conditions ) )
    call TriggerAddAction( gg_trg_ClosedTimeLikeLoop, function Trig_ClosedTimeLikeLoop_Actions )
endfunction

