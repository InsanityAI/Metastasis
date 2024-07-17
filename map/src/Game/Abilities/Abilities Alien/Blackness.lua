if Debug then Debug.beginFile "Game/Abilities/Alien/Blackness" end
OnInit.trig("Blackness", function(require)
    ---@return boolean
    function Trig_Blackness_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A041'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Blackness_Func001C()
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == GetSpellTargetUnit())) then
            return false
        end
        return true
    end

    function Trig_Blackness_Actions()
        local k = GetOwningPlayer(GetSpellTargetUnit()) ---@type player
        if (Trig_Blackness_Func001C()) then
            CinematicFilterGenericForPlayer(GetOwningPlayer(GetSpellTargetUnit()), 1, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100, 100, 100, 100, 0, 0, 0, 0)
            udg_Player_Blinded[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] = true
            PolledWait(6.00)
            udg_Player_Blinded[GetConvertedPlayerId(k)] = false
            CinematicFilterGenericForPlayer(k, 3, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0,
                0, 0, 0, 100, 100, 100, 100)
        else
            DisplayTextToPlayer(udg_Parasite, 0, 0, "TRIGSTR_2179")
        end
    end

    --===========================================================================
    gg_trg_Blackness = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Blackness, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Blackness, Condition(Trig_Blackness_Conditions))
    TriggerAddAction(gg_trg_Blackness, Trig_Blackness_Actions)
end)
if Debug then Debug.endFile() end
