if Debug then Debug.beginFile "Game/Abilities/Android/TacticalNuclearWarhead" end
OnInit.map("TacticalNuclearWarhead", function(require)
    ---@return boolean
    function Trig_TacticalNuclearWarhead_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02D'))) then
            return false
        end
        return true
    end

    function Trig_TacticalNuclearWarhead_Actions()
        PauseUnitBJ(true, GetSpellAbilityUnit())
        AddSpecialEffectTargetUnitBJ("origin", GetSpellAbilityUnit(),
            "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl")
        SFXThreadClean()
        udg_TempUnit = GetSpellAbilityUnit()
        udg_CountUpBarColor = "|cffFF80C0"
        UnitAddAbilityForPeriod(GetSpellAbilityUnit(), FourCC('Avul'), 7)
        PauseUnitForPeriod(GetSpellAbilityUnit(), 7.0)
        CountUpBar(udg_TempUnit, 40, 0.16, "TacNukeExplosion")
    end

    --===========================================================================
    gg_trg_TacticalNuclearWarhead = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TacticalNuclearWarhead, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_TacticalNuclearWarhead, Condition(Trig_TacticalNuclearWarhead_Conditions))
    TriggerAddAction(gg_trg_TacticalNuclearWarhead, Trig_TacticalNuclearWarhead_Actions)
end)
if Debug then Debug.endFile() end
