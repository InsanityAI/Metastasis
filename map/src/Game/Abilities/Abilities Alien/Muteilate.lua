if Debug then Debug.beginFile "Game/Abilities/Alien/Muteilate" end
OnInit.trig("Muteilate", function(require)
    ---@return boolean
    function Trig_Muteilate_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02Y'))) then
            return false
        end
        return true
    end

    function Trig_Muteilate_Actions()
        local k = GetSpellTargetUnit() ---@type unit
        local i = GetPlayerName(GetOwningPlayer(k)) ---@type string
        local d = GetOwningPlayer(k) ---@type player
        local j ---@type string
        if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(k))] == k then
            DisplayTextToPlayer(GetOwningPlayer(k), 0, 0, "|cff00FFFFYou can no longer seem to form words...|r")
            SetPlayerName(GetOwningPlayer(k),
                "                                                                                                                                                                                                                                                " ..
                "                                                                                                                                                                                                                                                " ..
                "                                                                                                                                                                                                                                                ")
            j = GetPlayerName(GetOwningPlayer(k))
            PolledWait(60.00)
            if GetPlayerName(d) == j then
                SetPlayerName(d, i)
                DisplayTextToPlayer(d, 0, 0, "|cff00FFFFYour voice returns to you!|r")
            end
        end
    end

    --===========================================================================
    gg_trg_Muteilate = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Muteilate, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Muteilate, Condition(Trig_Muteilate_Conditions))
    TriggerAddAction(gg_trg_Muteilate, Trig_Muteilate_Actions)
end)
if Debug then Debug.endFile() end
