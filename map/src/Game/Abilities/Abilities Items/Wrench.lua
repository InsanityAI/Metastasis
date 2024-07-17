if Debug then Debug.beginFile "Game/Abilities/Items/Wrench" end
OnInit.map("Wrench", function(require)
    ---@return boolean
    function Trig_Wrench_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A00Z'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Wrench_Func004Func001C()
        if (not (GetItemTypeId(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA())) == FourCC('I00H'))) then
            return false
        end
        return true
    end

    function Trig_Wrench_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            if (Trig_Wrench_Func004Func001C()) then
                udg_TempItem = UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA())
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        SetItemPositionLoc(udg_TempItem, udg_TempPoint)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_Wrench = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Wrench, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Wrench, Condition(Trig_Wrench_Conditions))
    TriggerAddAction(gg_trg_Wrench, Trig_Wrench_Actions)
end)
if Debug then Debug.endFile() end
