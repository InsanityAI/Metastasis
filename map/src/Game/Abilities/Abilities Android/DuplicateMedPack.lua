if Debug then Debug.beginFile "Game/Abilities/Android/DuplicateMedPack" end
OnInit.map("DuplicateMedPack", function(require)
    ---@return boolean
    function Trig_DuplicateMedPack_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0AA'))) then
            return false
        end
        return true
    end

    function Trig_DuplicateMedPack_Actions()
        if (GetItemOfTypeFromUnitBJ(GetTriggerUnit(), FourCC('I002')) ~= nil) then
            --Create medpack at caster location
            CreateItemLoc(FourCC('I002'), GetUnitLoc(GetTriggerUnit()))

            --If less than 6, aka free inventory slot, give it straight to the unit!
            if (UnitInventoryCount(GetTriggerUnit()) < 6) then
                UnitAddItem(GetTriggerUnit(), GetLastCreatedItem())
            end
        else --No medpack to duplicate, so, refund the mana
            SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) + 50.00))
        end
    end

    --===========================================================================
    gg_trg_DuplicateMedPack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DuplicateMedPack, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_DuplicateMedPack, Condition(Trig_DuplicateMedPack_Conditions))
    TriggerAddAction(gg_trg_DuplicateMedPack, Trig_DuplicateMedPack_Actions)
end)
if Debug then Debug.endFile() end
