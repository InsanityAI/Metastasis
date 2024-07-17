if Debug then Debug.beginFile "Game/Abilities/Suits/DeterministicInvigorationExpiration" end
OnInit.map("DeterministicInvigorationExpiration", function(require)
    function Trig_Deterministic_Invigoration_Expiration_Actions()
        local i                 = 0 ---@type integer
        local invigorationTimer = GetExpiredTimer() ---@type timer

        --Find the [i] of the timer
        while i <= 12 do
            if (invigorationTimer == udg_GuardInvigorationExpiration[i]) then
                UnitRemoveAbilityBJ(FourCC('A0A0'), udg_GuardInvigorationSelf[i])
                UnitRemoveAbilityBJ(FourCC('A09W'), udg_GuardInvigorationAlly[i])
                UnitRemoveAbilityBJ(FourCC('A09V'), udg_GuardInvigorationAlly[i])
                UnitRemoveBuffBJ(FourCC('B01E'), udg_GuardInvigorationAlly[i])
                i = 12 --just like writing return!
            end

            i = i + 1
        end
    end

    --===========================================================================

    local i                                      = 0 ---@type integer

    gg_trg_Deterministic_Invigoration_Expiration = CreateTrigger()
    TriggerAddAction(gg_trg_Deterministic_Invigoration_Expiration, Trig_Deterministic_Invigoration_Expiration_Actions)

    while i <= 11 do
        TriggerRegisterTimerExpireEventBJ(gg_trg_Deterministic_Invigoration_Expiration,
            udg_GuardInvigorationExpiration[i])
        i = i + 1
    end
end)
if Debug then Debug.endFile() end
