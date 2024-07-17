if Debug then Debug.beginFile "Game/Stations/ST4/ARDAcquire" end
OnInit.map("ARDAcquire", function(require)
    ---@return boolean
    function Trig_ARDAcquire_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A075'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ARDAcquire_Func003C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h00A'))) then
            return false
        end
        return true
    end

    function Trig_ARDAcquire_Actions()
        if (Trig_ARDAcquire_Func003C()) then
            udg_TempUnit2 = GetSpellTargetUnit()
            udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
            UnitAddAbilityBJ(FourCC('A074'), gg_unit_h009_0029)
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01V')))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Other\\Awaken\\Awaken.mdl")
            SFXThreadClean()
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    --===========================================================================
    gg_trg_ARDAcquire = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ARDAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ARDAcquire, Condition(Trig_ARDAcquire_Conditions))
    TriggerAddAction(gg_trg_ARDAcquire, Trig_ARDAcquire_Actions)
end)
if Debug then Debug.endFile() end
