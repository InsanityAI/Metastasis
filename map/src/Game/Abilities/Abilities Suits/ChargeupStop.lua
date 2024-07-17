if Debug then Debug.beginFile "Game/Abilities/Suits/ChargeupStop" end
OnInit.map("ChargeupStop", function(require)
    ---@return boolean
    function Trig_ChargeupStop_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04K'))) then
            return false
        end
        return true
    end

    function Trig_ChargeupStop_Actions()
        KillUnit(LoadUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("Chargeup_Effect")))
    end

    --===========================================================================
    gg_trg_ChargeupStop = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ChargeupStop, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerAddCondition(gg_trg_ChargeupStop, Condition(Trig_ChargeupStop_Conditions))
    TriggerAddAction(gg_trg_ChargeupStop, Trig_ChargeupStop_Actions)
end)
if Debug then Debug.endFile() end
