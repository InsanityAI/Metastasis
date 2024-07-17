if Debug then Debug.beginFile "Game/InteractiveEnvironment/GargoyleEasterEgg" end
OnInit.map("GargoyleEasterEgg", function(require)
    ---@return boolean
    function Trig_Gargoyle_Easter_Egg_Conditions()
        if (not (GetTriggerUnit() == gg_unit_u000_0150)) then
            return false
        end
        return true
    end

    function Trig_Gargoyle_Easter_Egg_Actions()
        CreateTextTagUnitBJ("TRIGSTR_4794", gg_unit_u000_0150, 0, 10, 100, 100, 100, 0)
        SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        SetTextTagLifespanBJ(GetLastCreatedTextTag(), 5)
        SetTextTagFadepointBJ(GetLastCreatedTextTag(), 4)
        RemoveUnit(GetTriggerUnit())
    end

    --===========================================================================
    gg_trg_Gargoyle_Easter_Egg = CreateTrigger()
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(0), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(1), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(2), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(3), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(4), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(5), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(6), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(7), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(8), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(9), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(10), true)
    TriggerRegisterPlayerSelectionEventBJ(gg_trg_Gargoyle_Easter_Egg, Player(11), true)
    TriggerAddCondition(gg_trg_Gargoyle_Easter_Egg, Condition(Trig_Gargoyle_Easter_Egg_Conditions))
    TriggerAddAction(gg_trg_Gargoyle_Easter_Egg, Trig_Gargoyle_Easter_Egg_Actions)
end)
if Debug then Debug.endFile() end
