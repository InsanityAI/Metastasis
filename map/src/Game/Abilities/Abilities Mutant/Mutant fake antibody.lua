if Debug then Debug.beginFile "Game/Abilities/Mutant/MutantFakeAntibody" end
OnInit.map("MutantFakeAntibody", function(require)
    ---@return boolean
    function Trig_Mutant_fake_antibody_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I004'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mutant_fake_antibody_Func003C()
        if (not (UnitHasBuffBJ(GetTriggerUnit(), FourCC('B009')) == true)) then
            return false
        end
        if (not (udg_Infection3_initiated == true)) then
            return false
        end
        return true
    end

    function Trig_Mutant_fake_antibody_Actions()
        if (Trig_Mutant_fake_antibody_Func003C()) then
            TriggerSleepAction(3.00)
            UnitRemoveBuffBJ(FourCC('B009'), GetTriggerUnit())
            TriggerSleepAction(3.00)
            udg_TempLoc3 = GetUnitLoc(GetTriggerUnit())
            CreateNUnitsAtLoc(1, FourCC('e03G'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempLoc3, bj_CAMERA_DEFAULT_ROLL)
            IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", GetTriggerUnit())
            RemoveLocation(udg_TempLoc3)
        else
        end
    end

    --===========================================================================
    gg_trg_Mutant_fake_antibody = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Mutant_fake_antibody, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Mutant_fake_antibody, Condition(Trig_Mutant_fake_antibody_Conditions))
    TriggerAddAction(gg_trg_Mutant_fake_antibody, Trig_Mutant_fake_antibody_Actions)
end)
if Debug then Debug.endFile() end
