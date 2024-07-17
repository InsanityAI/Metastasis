if Debug then Debug.beginFile "Commands/Test/Kill" end
OnInit.trig("Kill", function(require)
    ---@return boolean
    function Trig_Kill_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function KillPickedUnit()
        KillUnit(GetEnumUnit())
    end

    function Trig_Kill_Actions()
        ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), KillPickedUnit)
    end

    --===========================================================================
    local i     = 0 ---@type integer

    gg_trg_Kill = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_Kill, Player(i), "-kill", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_Kill, Condition(Trig_Kill_Conditions))
    TriggerAddAction(gg_trg_Kill, Trig_Kill_Actions)
end)
if Debug then Debug.endFile() end
