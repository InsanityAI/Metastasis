if Debug then Debug.beginFile "Game/Allignment/Mutant/MutantDevour" end
OnInit.triggggggggg("MutantDevour", function(require)
    ---@return boolean
    function Trig_MutantDevour_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05M'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantDevour_Func003Func003C()
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n006'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n001'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n000'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n002'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n00A'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('nech'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('nfro'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('necr'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('nder'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('nshe'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('e01H'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_MutantDevour_Func003C()
        if (not Trig_MutantDevour_Func003Func003C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantDevour_Func004C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('e01H'))) then
            return false
        end
        return true
    end

    function Trig_MutantDevour_Actions()
        if (Trig_MutantDevour_Func003C()) then
        else
            IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
            return
        end
        if (Trig_MutantDevour_Func004C()) then
            KillUnit(GetSpellTargetUnit())
            udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 200.00)
        else
            RemoveUnit(GetSpellTargetUnit())
            udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 75.00)
        end
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        SetSoundPositionLocBJ(gg_snd_Devour, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_Devour)
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Orc\\Orcblood\\BattrollBlood.mdl")
        SFXThreadClean()
        RemoveLocation(udg_TempPoint)
        udg_TempReal = 12.00
        udg_TempUnitType = FourCC('e031')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
    end

    --===========================================================================
    gg_trg_MutantDevour = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MutantDevour, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_MutantDevour, Condition(Trig_MutantDevour_Conditions))
    TriggerAddAction(gg_trg_MutantDevour, Trig_MutantDevour_Actions)
end)
if Debug then Debug.endFile() end
