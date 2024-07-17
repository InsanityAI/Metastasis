if Debug then Debug.beginFile "Game/Stations/Moon/RUMAcquire" end
OnInit.trig("RUMAcquire", function(require)
    ---@return boolean
    function Trig_RUMAcquire_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RUMAcquire_Func003Func002C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A06W'), udg_TempUnit) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RUMAcquire_Func003C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h001'))) then
            return false
        end
        return true
    end

    function Trig_RUMAcquire_Actions()
        if (Trig_RUMAcquire_Func003C()) then
            udg_TempUnit = udg_SS_Space[GetUnitUserData(GetSpellTargetUnit())]
            if (Trig_RUMAcquire_Func003Func002C()) then
                DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0,
                    "This raptor has already been upgraded!")
                return
            else
            end
            udg_TempUnit2 = GetSpellTargetUnit()
            udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
            RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), FourCC('I01U')))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Other\\Awaken\\Awaken.mdl")
            SFXThreadClean()
            RemoveLocation(udg_TempPoint)
            SetUnitAbilityLevelSwapped(FourCC('A003'), udg_TempUnit, 2)
            SetUnitVertexColorBJ(udg_TempUnit2, 100.00, 60.00, 40.00, 0)
            SetUnitAbilityLevelSwapped(FourCC('A002'), udg_TempUnit, 2)
            SetUnitVertexColorBJ(udg_TempUnit, 100.00, 50.00, 40.00, 0)
            UnitAddAbilityBJ(FourCC('A06W'), udg_TempUnit)
            UnitAddAbilityBJ(FourCC('A06X'), udg_TempUnit)
            UnitAddAbilityBJ(FourCC('A06Y'), udg_TempUnit)
            UnitAddAbilityBJ(FourCC('A06Z'), udg_TempUnit)
        else
        end
    end

    --===========================================================================
    gg_trg_RUMAcquire = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RUMAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RUMAcquire, Condition(Trig_RUMAcquire_Conditions))
    TriggerAddAction(gg_trg_RUMAcquire, Trig_RUMAcquire_Actions)
end)
if Debug then Debug.endFile() end
