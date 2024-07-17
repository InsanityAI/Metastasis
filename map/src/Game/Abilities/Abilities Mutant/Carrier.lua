if Debug then Debug.beginFile "Game/Abilities/Mutant/Carrier" end
OnInit.map("Carrier", function(require)
    ---@return boolean
    function Trig_Carrier_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05I'))) then
            return false
        end
        return true
    end

    function Carrier_Infect()
        local a = GetTriggerUnit() ---@type unit
        local b ---@type unit
        if GetUnitPointValue(a) ~= 37 and IsUnitType(a, UNIT_TYPE_MECHANICAL) == false then
            b = CreateUnit(udg_Mutant, FourCC('e00D'), GetUnitX(a), GetUnitY(a), 0.0)
            PolledWait(0.0)
            IssueTargetOrderBJ(b, "parasite", a)
        end
    end

    function Trig_Carrier_Actions()
        local t = CreateTrigger() ---@type trigger
        TriggerRegisterUnitInRangeSimple(t, 350.0, GetSpellTargetUnit())
        TriggerAddAction(t, Carrier_Infect)
        udg_Unit_CarrierTrigger[GetUnitAN(GetSpellTargetUnit())] = t
    end

    --===========================================================================
    gg_trg_Carrier = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Carrier, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Carrier, Condition(Trig_Carrier_Conditions))
    TriggerAddAction(gg_trg_Carrier, Trig_Carrier_Actions)
end)
if Debug then Debug.endFile() end
