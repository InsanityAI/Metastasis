if Debug then Debug.beginFile "Commands/Test/Mine" end
OnInit.trig("Mine", function(require)
    ---@return boolean
    function Trig_Mine_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function ChangeOwner()
        SetUnitOwner(GetEnumUnit(), GetTriggerPlayer(), true)
    end

    function Trig_Mine_Actions()
        ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), ChangeOwner)
    end

    --===========================================================================
    local i     = 0 ---@type integer
    gg_trg_Mine = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_Mine, Player(i), "-mine", true)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_Mine, Condition(Trig_Mine_Conditions))
    TriggerAddAction(gg_trg_Mine, Trig_Mine_Actions)
end)
if Debug then Debug.endFile() end
