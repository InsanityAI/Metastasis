if Debug then Debug.beginFile "Game/Abilities/Suits/Nanovirus" end
OnInit.map("Nanovirus", function(require)
    ---@return boolean
    function Trig_Nanovirus_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A09R'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func001Func001C()
        if ((UnitHasBuffBJ(udg_TempUnit2, FourCC('BNpa')) == true)) then
            return true
        end
        if ((UnitHasBuffBJ(udg_TempUnit2, FourCC('B00H')) == true)) then
            return true
        end
        if ((UnitHasBuffBJ(udg_TempUnit2, FourCC('BNpm')) == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func001Func003Func002Func001Func001C()
        if (not (udg_MutantUpgradeLevel == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func001Func003Func002Func001C()
        if (not (udg_MutantUpgradeLevel == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func001Func003Func002C()
        if (not (udg_MutantUpgradeLevel == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func001Func003C()
        if (not (UnitHasBuffBJ(udg_TempUnit2, FourCC('B009')) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func001C()
        if (not Trig_Nanovirus_Func004Func001Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Nanovirus_Func004Func007C()
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h02G'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h02O'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h016'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h014'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h011'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h012'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h049'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h017'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h04S'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00G'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h03Z'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h023'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h019'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00O'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00P'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00Q'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00R'))) then
            return true
        end
        if ((IsUnitType(udg_TempUnit2, UNIT_TYPE_STRUCTURE) == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Nanovirus_Func004C()
        if (not Trig_Nanovirus_Func004Func007C()) then
            return false
        end
        return true
    end

    function Trig_Nanovirus_Actions()
        udg_TempUnit2 = GetSpellTargetUnit()
        if (Trig_Nanovirus_Func004C()) then
            CreateTextTagUnitBJ("TRIGSTR_4809", udg_TempUnit2, 0, 10, 80.00, 80.00, 100, 0)
            SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
            SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            SetTextTagLifespanBJ(GetLastCreatedTextTag(), 5)
            SetTextTagFadepointBJ(GetLastCreatedTextTag(), 4)
        else
            if (Trig_Nanovirus_Func004Func001C()) then
                UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_TempUnit2)
                CreateNUnitsAtLoc(1, FourCC('e03D'), Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_TempUnit2),
                    bj_UNIT_FACING)
                UnitApplyTimedLifeBJ(2.00, FourCC('BTLF'), GetLastCreatedUnit())
                IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", udg_TempUnit2)
            else
                if (Trig_Nanovirus_Func004Func001Func003C()) then
                    if (Trig_Nanovirus_Func004Func001Func003Func002C()) then
                        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_TempUnit2)
                        CreateNUnitsAtLoc(1, FourCC('e03E'), Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_TempUnit2),
                            bj_UNIT_FACING)
                        UnitApplyTimedLifeBJ(2.00, FourCC('BTLF'), GetLastCreatedUnit())
                        IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", udg_TempUnit2)
                    else
                        if (Trig_Nanovirus_Func004Func001Func003Func002Func001C()) then
                            UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_TempUnit2)
                            CreateNUnitsAtLoc(1, FourCC('e013'), Player(PLAYER_NEUTRAL_AGGRESSIVE),
                                GetUnitLoc(udg_TempUnit2), bj_UNIT_FACING)
                            UnitApplyTimedLifeBJ(2.00, FourCC('BTLF'), GetLastCreatedUnit())
                            IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", udg_TempUnit2)
                        else
                            if (Trig_Nanovirus_Func004Func001Func003Func002Func001Func001C()) then
                                UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_TempUnit2)
                                CreateNUnitsAtLoc(1, FourCC('e00D'), Player(PLAYER_NEUTRAL_AGGRESSIVE),
                                    GetUnitLoc(udg_TempUnit2), bj_UNIT_FACING)
                                UnitApplyTimedLifeBJ(2.00, FourCC('BTLF'), GetLastCreatedUnit())
                                IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", udg_TempUnit2)
                            else
                            end
                        end
                    end
                else
                    UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, udg_TempUnit2)
                end
            end
        end
    end

    --===========================================================================
    gg_trg_Nanovirus = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Nanovirus, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Nanovirus, Condition(Trig_Nanovirus_Conditions))
    TriggerAddAction(gg_trg_Nanovirus, Trig_Nanovirus_Actions)
end)
if Debug then Debug.endFile() end
