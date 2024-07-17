if Debug then Debug.beginFile "Game/Sun/SunpodApocalypse" end
OnInit.trig("SunpodApocalypse", function(require)
    ---@return boolean
    function Trig_Sunpod_apocalypse_Conditions()
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    function Trig_Sunpod_apocalypse_Actions()
        SunLoop(GetTriggerUnit())
    end

    --===========================================================================
    gg_trg_Sunpod_apocalypse = CreateTrigger()
    DisableTrigger(gg_trg_Sunpod_apocalypse)
    TriggerRegisterUnitInRangeSimple(gg_trg_Sunpod_apocalypse, 600.00, gg_unit_h01A_0197)
    TriggerAddCondition(gg_trg_Sunpod_apocalypse, Condition(Trig_Sunpod_apocalypse_Conditions))
    TriggerAddAction(gg_trg_Sunpod_apocalypse, Trig_Sunpod_apocalypse_Actions)
end)
if Debug then Debug.endFile() end
