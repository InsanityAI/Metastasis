if Debug then Debug.beginFile "Game/Allignment/Android/AntiAcquireRemote" end
OnInit.map("AntiAcquireRemote", function(require)
    ---@return boolean
    function Trig_AntiacquireRemote_Conditions()
        if (not (GetOwningPlayer(GetTriggerUnit()) == udg_HiddenAndroid)) then
            return false
        end
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01I'))) then
            return false
        end
        return true
    end

    function Trig_AntiacquireRemote_Actions()
        UnitRemoveItemSwapped(GetManipulatedItem(), GetManipulatingUnit())
    end

    --===========================================================================
    gg_trg_AntiacquireRemote = CreateTrigger()
    DisableTrigger(gg_trg_AntiacquireRemote)
    TriggerRegisterAnyUnitEventBJ(gg_trg_AntiacquireRemote, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_AntiacquireRemote, Condition(Trig_AntiacquireRemote_Conditions))
    TriggerAddAction(gg_trg_AntiacquireRemote, Trig_AntiacquireRemote_Actions)
end)
if Debug then Debug.endFile() end
