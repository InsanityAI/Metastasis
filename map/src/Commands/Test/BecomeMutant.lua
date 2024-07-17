if Debug then Debug.beginFile "Commands/Test/BecomeMutant" end
OnInit.trig("BecomeMutant", function(require)
    require "StateTable"
    ---@return boolean
    function Trig_BecomeMutant_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_BecomeMutant_Actions()
        udg_Mutant = GetTriggerPlayer()
        StateTable.SetPlayerRole(udg_Mutant, Role.Mutant)
        CreateNUnitsAtLoc(1, FourCC('e031'), GetTriggerPlayer(), udg_HoldZone, bj_UNIT_FACING) --Was GetEnumUnit()
        --if playerhero not in suit, give devour ability
    end

    --===========================================================================
    local i             = 0 ---@type integer

    gg_trg_BecomeMutant = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_BecomeMutant, Player(i), "-mutant", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_BecomeMutant, Condition(Trig_BecomeMutant_Conditions))
    TriggerAddAction(gg_trg_BecomeMutant, Trig_BecomeMutant_Actions)
end)
if Debug then Debug.endFile() end
