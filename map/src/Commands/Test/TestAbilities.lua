if Debug then Debug.beginFile "Commands/Test/TestAbilities" end
OnInit.map("TestAbilities", function(require)
    ---@return boolean
    function Trig_TestAbilities_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_TestAbilities_Func001A()
        UnitAddAbilityBJ(FourCC('A087'), GetEnumUnit())
    end

    function Trig_TestAbilities_Actions()
        ForGroupBJ(GetUnitsSelectedAll(GetTriggerPlayer()), Trig_TestAbilities_Func001A)
    end

    --===========================================================================
    local i              = 0 ---@type integer
    gg_trg_TestAbilities = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_TestAbilities, Player(i), "-test_abilities", true)
        TriggerRegisterPlayerChatEvent(gg_trg_TestAbilities, Player(i), "--", true)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_TestAbilities, Condition(Trig_TestAbilities_Conditions))
    TriggerAddAction(gg_trg_TestAbilities, Trig_TestAbilities_Actions)
end)
if Debug then Debug.endFile() end
