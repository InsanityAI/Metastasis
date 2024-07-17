if Debug then Debug.beginFile "Game/PureBugfixes/StalkerRangeRestrictionActivation" end
OnInit.trig("StalkerRangeRestrictionActivation", function(require)
    function Trig_Stalker_Range_Restriction_Activation_Actions()
        --If less than 400 range, stop attacking.
        if (DistanceBetweenPoints(udg_StalkerAttackLocation, udg_StalkerUnitLocation) <= 400.00) then
            IssueImmediateOrderBJ(udg_StalkerUnit, "stop")

            --Explain to mutant the range mechanic, and color-code it plz.
            DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 1.00,
                "|cffF4A460Distance from Prey: |r|cffFF0000" ..
                R2S(DistanceBetweenPoints(udg_StalkerAttackLocation, udg_StalkerUnitLocation)))
        else
            DisplayTimedTextToPlayer(udg_Mutant, 0, 0, 1.00,
                "|cffF4A460Distance from Prey: |r|cff8AB600" ..
                R2S(DistanceBetweenPoints(udg_StalkerAttackLocation, udg_StalkerUnitLocation)))
        end


        --Memory Leak Cleaning
        RemoveLocation(udg_StalkerAttackLocation)
        RemoveLocation(udg_StalkerUnitLocation)
    end

    --===========================================================================
    gg_trg_Stalker_Range_Restriction_Activation = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_Stalker_Range_Restriction_Activation, udg_StalkerAttackTimer)
    TriggerAddAction(gg_trg_Stalker_Range_Restriction_Activation, Trig_Stalker_Range_Restriction_Activation_Actions)
end)
if Debug then Debug.endFile() end
