if Debug then Debug.beginFile "Game/Stations/Moon/OreAcquire" end
OnInit.map("OreAcquire", function(require)
    ---@return boolean
    function Trig_OreAcquire_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_OreAcquire_Func003C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h04F'))) then
            return false
        end
        return true
    end

    function Trig_OreAcquire_Actions()
        if (Trig_OreAcquire_Func003C()) then
            udg_TempUnit2 = GetSpellTargetUnit()
            udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01W')))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl")
            SetUnitManaBJ(gg_unit_h04E_0259, (GetUnitStateSwap(UNIT_STATE_MANA, gg_unit_h04E_0259) + 150.00))
            SFXThreadClean()
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    --===========================================================================
    gg_trg_OreAcquire = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_OreAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_OreAcquire, Condition(Trig_OreAcquire_Conditions))
    TriggerAddAction(gg_trg_OreAcquire, Trig_OreAcquire_Actions)
end)
if Debug then Debug.endFile() end
