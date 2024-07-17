if Debug then Debug.beginFile "Game/TeleportAndAI/ItemDrop" end
OnInit.trig("ItemDrop", function(require)
    ---@return boolean
    function Trig_Item_drop_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('n00I'))) then
            return false
        end
        return true
    end

    function Trig_Item_drop_Actions()
        udg_TempLoc = GetUnitLoc(GetTriggerUnit())
        CreateItemLoc(FourCC('I02X'), udg_TempLoc)
        DisableTrigger(gg_trg_Alodimensional_A_I)
        RemoveLocation(udg_TempLoc)
    end

    --===========================================================================
    gg_trg_Item_drop = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_Item_drop, Player(PLAYER_NEUTRAL_AGGRESSIVE), EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Item_drop, Condition(Trig_Item_drop_Conditions))
    TriggerAddAction(gg_trg_Item_drop, Trig_Item_drop_Actions)
end)
if Debug then Debug.endFile() end
