if Debug then Debug.beginFile "Game/TeleportAndAI/Alodimensional" end
OnInit.map("Alodimensional", function(require)
    function Trig_Alodimensional1_Actions()
        udg_HP_Comparison[(2 + udg_HP_Index)] = GetUnitStateSwap(UNIT_STATE_LIFE, udg_Alodimensional_Being)
        udg_HP_Comparison[(3 + udg_HP_Index)] = (udg_HP_Comparison[(1 + udg_HP_Index)] - udg_HP_Comparison[(2 + udg_HP_Index)])
        SetUnitLifeBJ(udg_Alodimensional_Being,
            (GetUnitStateSwap(UNIT_STATE_LIFE, udg_Alodimensional_Being) + udg_HP_Comparison[(3 + udg_HP_Index)]))
        SetUnitManaBJ(udg_Alodimensional_Being,
            (GetUnitStateSwap(UNIT_STATE_MANA, udg_Alodimensional_Being) - udg_HP_Comparison[(3 + udg_HP_Index)]))
        udg_HP_Index = (udg_HP_Index + 1)
        udg_HP_Comparison[(1 + udg_HP_Index)] = GetUnitStateSwap(UNIT_STATE_LIFE, udg_Alodimensional_Being)
    end

    --===========================================================================
    gg_trg_Alodimensional1 = CreateTrigger()
    DisableTrigger(gg_trg_Alodimensional1)
    TriggerRegisterTimerEventPeriodic(gg_trg_Alodimensional1, 1.00)
    TriggerAddAction(gg_trg_Alodimensional1, Trig_Alodimensional1_Actions)
end)
if Debug then Debug.endFile() end
