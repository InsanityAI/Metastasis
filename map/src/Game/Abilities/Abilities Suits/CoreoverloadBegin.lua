if Debug then Debug.beginFile "Game/Abilities/Suits/CoreOverloadBegin" end
OnInit.trigg("CoreOverloadBegin", function(require)
    ---@return boolean
    function Trig_CoreoverloadBegin_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A06C'))) then
            return false
        end
        return true
    end

    function Trig_CoreoverloadBegin_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempUnit = GetSpellAbilityUnit()
        udg_CountUpBarColor = "|cff000000"
        CountUpBar(udg_TempUnit, 60, 0.06666, "DoNothing")
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_CoreoverloadBegin = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CoreoverloadBegin, EVENT_PLAYER_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_CoreoverloadBegin, Condition(Trig_CoreoverloadBegin_Conditions))
    TriggerAddAction(gg_trg_CoreoverloadBegin, Trig_CoreoverloadBegin_Actions)
end)
if Debug then Debug.endFile() end
