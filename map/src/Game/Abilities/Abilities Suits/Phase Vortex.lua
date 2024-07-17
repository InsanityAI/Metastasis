if Debug then Debug.beginFile "Game/Abilities/Suits/PhaseVortex" end
OnInit.map("PhaseVortex", function(require)
    ---@return boolean
    function Trig_Phase_Vortex_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A09L'))) then
            return false
        end
        return true
    end

    function Trig_Phase_Vortex_Func011A()
        udg_Manacurrent1 = GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit())
        SetUnitManaBJ(GetEnumUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit()) - 40.00))
        udg_Manacurrent2 = GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit())
        udg_Manadrained = (udg_Manacurrent1 - udg_Manacurrent2)
        SetUnitLifeBJ(GetEnumUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) - udg_Manadrained))
        return
    end

    function Trig_Phase_Vortex_Actions()
        SetUnitAnimation(GetTriggerUnit(), "Spell")
        udg_TempLoc3 = GetSpellTargetLoc()
        udg_DMgroup = GetUnitsInRangeOfLocAll(300.00, udg_TempLoc3)
        AddSpecialEffectLocBJ(udg_TempLoc3, "war3mapImported\\DarkNova.mdx")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        CreateTextTagLocBJ("TRIGSTR_4550", udg_TempLoc3, 0, 8.00, 100, 100, 100, 0)
        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.50)
        ForGroupBJ(udg_DMgroup, Trig_Phase_Vortex_Func011A)
        DestroyTextTagBJ(GetLastCreatedTextTag())
        RemoveLocation(udg_TempLoc3)
        DestroyGroup(udg_DMgroup)
    end

    --===========================================================================
    gg_trg_Phase_Vortex = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Phase_Vortex, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Phase_Vortex, Condition(Trig_Phase_Vortex_Conditions))
    TriggerAddAction(gg_trg_Phase_Vortex, Trig_Phase_Vortex_Actions)
end)
if Debug then Debug.endFile() end
