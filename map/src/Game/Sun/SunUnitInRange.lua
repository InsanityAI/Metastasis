if Debug then Debug.beginFile "Game/Sun/SunUnitInRange" end
OnInit.map("SunUnitInRange", function(require)
    ---@return boolean
    function Trig_SunUnitInRange_Conditions()
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        if (not (GetUnitTypeId(GetTriggerUnit()) ~= FourCC('h02P'))) then
            return false
        end
        return true
    end

    function Trig_SunUnitInRange_Actions()
        SunLoop(GetTriggerUnit())
    end

    --===========================================================================
    gg_trg_SunUnitInRange = CreateTrigger()
    TriggerRegisterUnitInRangeSimple(gg_trg_SunUnitInRange, 600.00, gg_unit_h01A_0197)
    TriggerAddCondition(gg_trg_SunUnitInRange, Condition(Trig_SunUnitInRange_Conditions))
    TriggerAddAction(gg_trg_SunUnitInRange, Trig_SunUnitInRange_Actions)
end)
if Debug then Debug.endFile() end
