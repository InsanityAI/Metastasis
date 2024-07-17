if Debug then Debug.beginFile "Game/Stations/ST3/ATMAcquire" end
OnInit.trig("ATMAcquire", function(require)
    ---@return boolean
    function Trig_ATMAcquire_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06T'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ATMAcquire_Func003C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h006'))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A06R'), GetSpellTargetUnit()) == 0)) then
            return false
        end
        if (not (udg_Kyo_ATM_Armed == false)) then
            return false
        end
        return true
    end

    function Trig_ATMAcquire_Actions()
        if (Trig_ATMAcquire_Func003C()) then
            udg_Kyo_ATM_Armed = true
            udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
            SetSoundPositionLocBJ(gg_snd_Lever, udg_TempPoint, 0)
            PlaySoundBJ(gg_snd_Lever)
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01T')))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
            SFXThreadClean()
            RemoveLocation(udg_TempPoint)
            udg_TempUnit = gg_unit_h007_0027
            udg_Kyo_ATM_LightningRing = LightningRing(udg_TempUnit)
            UnitAddAbilityBJ(FourCC('A06U'), gg_unit_h007_0027)
        else
        end
    end

    --===========================================================================
    gg_trg_ATMAcquire = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ATMAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ATMAcquire, Condition(Trig_ATMAcquire_Conditions))
    TriggerAddAction(gg_trg_ATMAcquire, Trig_ATMAcquire_Actions)
end)
if Debug then Debug.endFile() end
