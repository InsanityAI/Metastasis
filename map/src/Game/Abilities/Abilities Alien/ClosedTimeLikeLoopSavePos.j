function Trig_ClosedTimeLikeLoopSavePos_Func002C takes nothing returns boolean 
    if(not(udg_CTL_On >= 40)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ClosedTimeLikeLoopSavePos_Actions takes nothing returns nothing 
    if(Trig_ClosedTimeLikeLoopSavePos_Func002C()) then 
        set udg_CTL_On = 0 
    else 
    endif 
    set udg_CTL_On = (udg_CTL_On + 1) 
    set udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] 
    set udg_CTL_PosXArray[udg_CTL_On] = GetUnitX(udg_TempUnit) 
    set udg_CTL_PosYArray[udg_CTL_On] = GetUnitY(udg_TempUnit) 
    set udg_CTL_UnitType[udg_CTL_On] = GetUnitTypeId(udg_TempUnit) 
    set udg_CTL_InventorySlot1[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 1)) 
    set udg_CTL_InventorySlot2[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 2)) 
    set udg_CTL_InventorySlot3[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 3)) 
    set udg_CTL_InventorySlot4[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 4)) 
    set udg_CTL_InventorySlot5[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 5)) 
    set udg_CTL_InventorySlot6[udg_CTL_On] = GetItemTypeId(UnitItemInSlotBJ(udg_TempUnit, 6)) 
    set udg_CTL_UnitHealth[udg_CTL_On] = GetUnitStateSwap(UNIT_STATE_LIFE, udg_TempUnit) 
    set udg_CTL_UnitMana[udg_CTL_On] = GetUnitStateSwap(UNIT_STATE_MANA, udg_TempUnit) 
    set udg_CTL_Facing[udg_CTL_On] = GetUnitFacing(udg_TempUnit) 
endfunction 

//=========================================================================== 
function InitTrig_ClosedTimeLikeLoopSavePos takes nothing returns nothing 
    set gg_trg_ClosedTimeLikeLoopSavePos = CreateTrigger() 
    call DisableTrigger(gg_trg_ClosedTimeLikeLoopSavePos) 
    call TriggerRegisterTimerEventPeriodic(gg_trg_ClosedTimeLikeLoopSavePos, 0.25) 
    call TriggerAddAction(gg_trg_ClosedTimeLikeLoopSavePos, function Trig_ClosedTimeLikeLoopSavePos_Actions) 
endfunction 

