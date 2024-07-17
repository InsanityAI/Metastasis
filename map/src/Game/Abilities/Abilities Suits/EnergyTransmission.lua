if Debug then Debug.beginFile "Game/Abilities/Suits/EnergyTransmission" end
OnInit.trig("EnergyTransmission", function(require)
    ---@return boolean
    function Trig_EnergyTransmission_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02H'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_EnergyTransmission_Func011C()
        if (not (GetSpellAbilityUnit() == GetSpellTargetUnit())) then
            return false
        end
        return true
    end

    function Trig_EnergyTransmission_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit())
        AddSpecialEffectLocBJ(udg_TempPoint, "war3mapImported\\HealthGain.mdx")
        SFXThreadClean()
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl")
        SFXThreadClean()
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        if (Trig_EnergyTransmission_Func011C()) then
            SetUnitLifeBJ(GetSpellTargetUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + 100.00))
        else
            SetUnitLifeBJ(GetSpellTargetUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) + 150.00))
            SetUnitLifeBJ(GetSpellAbilityUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellAbilityUnit()) - 50.00))
        end
    end

    --===========================================================================
    gg_trg_EnergyTransmission = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EnergyTransmission, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_EnergyTransmission, Condition(Trig_EnergyTransmission_Conditions))
    TriggerAddAction(gg_trg_EnergyTransmission, Trig_EnergyTransmission_Actions)
end)
if Debug then Debug.endFile() end
