if Debug then Debug.beginFile "Game/Abilities/Suits/ElectricDischarge" end
OnInit.map("ElectricDischarge", function(require)
    ---@return boolean
    function Trig_ElectricDischarge_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02F'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ElectricDischarge_Func006Func002C()
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h039'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h037'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ElectricDischarge_Func006C()
        if (not Trig_ElectricDischarge_Func006Func002C()) then
            return false
        end
        return true
    end

    function Trig_ElectricDischarge_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit())
        udg_TempReal = DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2)
        if (Trig_ElectricDischarge_Func006C()) then
        else
            UnitDamageTargetBJ(GetSpellAbilityUnit(), GetSpellTargetUnit(),
                (GetUnitStateSwap(UNIT_STATE_LIFE, GetSpellTargetUnit()) * (0.05 + ((udg_TempReal / 1000.00) / 10.00))),
                ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
        end
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_ElectricDischarge = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ElectricDischarge, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ElectricDischarge, Condition(Trig_ElectricDischarge_Conditions))
    TriggerAddAction(gg_trg_ElectricDischarge, Trig_ElectricDischarge_Actions)
end)
if Debug then Debug.endFile() end
