if Debug then Debug.beginFile "Game/Abilities/Suits/ChargeupBegin" end
OnInit.trig("ChargeupBegin", function(require)
    ---@return boolean
    function Trig_ChargeupBegin_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04K'))) then
            return false
        end
        return true
    end

    function Trig_ChargeupBegin_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        CreateNUnitsAtLoc(1, FourCC('e01O'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        ResetUnitAnimation(GetLastCreatedUnit())
        SizeUnitOverTime(GetLastCreatedUnit(), 5.0, 1.0, 3.0, false)
        SaveUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("Chargeup_Effect"), GetLastCreatedUnit())
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_ChargeupBegin = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ChargeupBegin, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_ChargeupBegin, Condition(Trig_ChargeupBegin_Conditions))
    TriggerAddAction(gg_trg_ChargeupBegin, Trig_ChargeupBegin_Actions)
end)
if Debug then Debug.endFile() end
