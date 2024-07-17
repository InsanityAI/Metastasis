if Debug then Debug.beginFile "Game/TeleportAndAI/TheWarpOngoing" end
OnInit.trig("TheWarpOngoing", function(require)
    function Trig_The_Warp_ongoing_Actions()
        udg_Warp7 = 1
        while udg_Warp7 <= 7 do
            udg_Warp_Effect = GetRandomLocInRect(gg_rct_Warp)
            AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
            DestroyEffectBJ(GetLastCreatedEffectBJ())
            AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl")
            DestroyEffectBJ(GetLastCreatedEffectBJ())
            AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl")
            DestroyEffectBJ(GetLastCreatedEffectBJ())
            RemoveLocation(udg_Warp_Effect)
            udg_Warp7 = udg_Warp7 + 1
        end
    end

    --===========================================================================
    gg_trg_The_Warp_ongoing = CreateTrigger()
    DisableTrigger(gg_trg_The_Warp_ongoing)
    TriggerRegisterTimerEventPeriodic(gg_trg_The_Warp_ongoing, 0.50)
    TriggerAddAction(gg_trg_The_Warp_ongoing, Trig_The_Warp_ongoing_Actions)
end)
if Debug then Debug.endFile() end
