if Debug then Debug.beginFile "Commands/Test/Hostile" end
OnInit.trig("Hostile", function(require)
    ---@return boolean
    function Trig_Hostile_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_Hostile_Func002A()
        SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
    end

    function Trig_Hostile_Actions()
        ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), Trig_Hostile_Func002A)
    end

    --===========================================================================
    local i        = 0 ---@type integer
    gg_trg_Hostile = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_Hostile, Player(0), "-hostile", true)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_Hostile, Condition(Trig_Hostile_Conditions))
    TriggerAddAction(gg_trg_Hostile, Trig_Hostile_Actions)
end)
if Debug then Debug.endFile() end
