if Debug then Debug.beginFile "Game/Abilities/Android/DuplicateMedicalRegenerator" end
OnInit.map("DuplicateMedicalRegenerator", function(require)
    ---@return boolean
    function Trig_DuplicateMedicalRegenerator_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0AC'))) then
            return false
        end
        return true
    end

    function Trig_DuplicateMedicalRegenerator_Actions()
        if (GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC('I01N')) ~= nil) then
            --Create medpack at caster location
            CreateItemLoc(FourCC('I01N'), GetUnitLoc(GetTriggerUnit()))

            --If less than 6, aka free inventory slot, give it straight to the unit!
            if (UnitInventoryCount(GetTriggerUnit()) < 6) then
                UnitAddItem(GetTriggerUnit(), GetLastCreatedItem())
            end
        else --No antibodies to duplicate, so, refund the mana
            SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) + 100.00))
        end
    end

    --===========================================================================
    gg_trg_DuplicateMedicalRegenerator = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DuplicateMedicalRegenerator, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_DuplicateMedicalRegenerator, Condition(Trig_DuplicateMedicalRegenerator_Conditions))
    TriggerAddAction(gg_trg_DuplicateMedicalRegenerator, Trig_DuplicateMedicalRegenerator_Actions)
end)
if Debug then Debug.endFile() end
