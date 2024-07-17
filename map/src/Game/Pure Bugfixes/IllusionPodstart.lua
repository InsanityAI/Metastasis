if Debug then Debug.beginFile "Game/PureBugfixes/IllusionPodstart" end
OnInit.trig("IllusionPodstart", function(require)
    ---@return boolean
    function Trig_IllusionPodstart_Func001C()
        if ((GetUnitTypeId(GetTriggerUnit()) == FourCC('h02O'))) then
            return true
        end
        if ((GetUnitTypeId(GetBuyingUnit()) == FourCC('h00M'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_IllusionPodstart_Conditions()
        if (not Trig_IllusionPodstart_Func001C()) then
            return false
        end
        return true
    end

    function Trig_IllusionPodstart_Actions()
        udg_IllusionSuitBoolean = true
        StartTimerBJ(udg_IllusionSuitTimer, false, 5.00)
    end

    --===========================================================================
    gg_trg_IllusionPodstart = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_IllusionPodstart, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_IllusionPodstart, Condition(Trig_IllusionPodstart_Conditions))
    TriggerAddAction(gg_trg_IllusionPodstart, Trig_IllusionPodstart_Actions)
end)
if Debug then Debug.endFile() end
