if Debug then Debug.beginFile "Game/Abilities/Mutant/Roar" end
OnInit.map("Roar", function(require)
    ---@return boolean
    function Trig_Roar_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01J'))) then
            return false
        end
        return true
    end

    function Trig_Roar_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        SetSoundPositionLocBJ(gg_snd_SargerasRoar, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_SargerasRoar)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_Roar = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Roar, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Roar, Condition(Trig_Roar_Conditions))
    TriggerAddAction(gg_trg_Roar, Trig_Roar_Actions)
end)
if Debug then Debug.endFile() end
