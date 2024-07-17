if Debug then Debug.beginFile "Game/Abilities/Android/DuplicateAntibodies" end
OnInit.map("DuplicateAntibodies", function(require)
    ---@return boolean
    function Trig_DuplicateAntibodies_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0AB'))) then
            return false
        end
        return true
    end

    function Trig_DuplicateAntibodies_Actions()
        if (GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC('I004')) ~= nil) then
            --Create medpack at caster location
            CreateItemLoc(FourCC('I004'), GetUnitLoc(GetTriggerUnit()))

            --If less than 6, aka free inventory slot, give it straight to the unit!
            if (UnitInventoryCount(GetTriggerUnit()) < 6) then
                UnitAddItem(GetTriggerUnit(), GetLastCreatedItem())
            end
        else --No antibodies to duplicate, so, refund the mana
            SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) + 100.00))
        end
    end

    --===========================================================================
    gg_trg_DuplicateAntibodies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DuplicateAntibodies, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_DuplicateAntibodies, Condition(Trig_DuplicateAntibodies_Conditions))
    TriggerAddAction(gg_trg_DuplicateAntibodies, Trig_DuplicateAntibodies_Actions)
end)
if Debug then Debug.endFile() end
