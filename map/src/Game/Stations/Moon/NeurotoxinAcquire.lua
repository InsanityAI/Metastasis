if Debug then Debug.beginFile "Game/Stations/Moon/NeurotoxinAcquire" end
OnInit.map("NeurotoxinAcquire", function(require)
    ---@return boolean
    function Trig_NeurotoxinAcquire_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NeurotoxinAcquire_Func003C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h04F'))) then
            return false
        end
        return true
    end

    function Trig_NeurotoxinAcquire_Actions()
        if (Trig_NeurotoxinAcquire_Func003C()) then
            udg_TempUnit2 = GetSpellTargetUnit()
            udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01X')))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl")
            UnitAddAbilityBJ(FourCC('A07D'), gg_unit_h04E_0259)
            SFXThreadClean()
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    --===========================================================================
    gg_trg_NeurotoxinAcquire = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_NeurotoxinAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_NeurotoxinAcquire, Condition(Trig_NeurotoxinAcquire_Conditions))
    TriggerAddAction(gg_trg_NeurotoxinAcquire, Trig_NeurotoxinAcquire_Actions)
end)
if Debug then Debug.endFile() end
