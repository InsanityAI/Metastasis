if Debug then Debug.beginFile "Game/Abilities/Alien/Manifold" end
OnInit.map("Manifold", function(require)
    ---@return boolean
    function Trig_Manifold_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03Y'))) then
            return false
        end
        return true
    end

    function Trig_Manifold_Actions()
        local r ---@type item
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        CreateNUnitsAtLoc(1, FourCC('e000'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING)
        r = UnitAddItemByIdSwapped(FourCC('I016'), GetLastCreatedUnit())
        UnitUseItemTarget(GetLastCreatedUnit(), r, GetSpellAbilityUnit())

        RemoveLocation(udg_TempPoint)
        udg_TempUnitType = FourCC('e00S')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempReal = 50.00
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
        PolledWait(1)
        RemoveItem(r)
    end

    --===========================================================================
    gg_trg_Manifold = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Manifold, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Manifold, Condition(Trig_Manifold_Conditions))
    TriggerAddAction(gg_trg_Manifold, Trig_Manifold_Actions)
end)
if Debug then Debug.endFile() end
