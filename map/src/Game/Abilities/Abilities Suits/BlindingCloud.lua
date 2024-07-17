if Debug then Debug.beginFile "Game/Abilities/Suits/BlindingCloud" end
OnInit.trig("BlindingCloud", function(require)
    ---@return boolean
    function Trig_BlindingCloud_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04P'))) then
            return false
        end
        return true
    end

    function Trig_BlindingCloud_Actions()
        udg_TempPoint2 = GetSpellTargetLoc()
        CreateNUnitsAtLoc(1, FourCC('e013'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2,
            AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
        IssuePointOrderLocBJ(GetLastCreatedUnit(), "cloudoffog", udg_TempPoint2)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_BlindingCloud = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_BlindingCloud, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_BlindingCloud, Condition(Trig_BlindingCloud_Conditions))
    TriggerAddAction(gg_trg_BlindingCloud, Trig_BlindingCloud_Actions)
end)
if Debug then Debug.endFile() end
