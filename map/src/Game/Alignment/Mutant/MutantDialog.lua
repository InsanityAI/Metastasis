if Debug then Debug.beginFile "Game/Allignment/Mutant/MutantDialog" end
OnInit.trigg("MutantDialog", function(require)
    ---@return boolean
    function Trig_MutantDialog_Conditions()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A078'), GetTriggerUnit()) == 1)) then
            return false
        end
        if (not (GetOwningPlayer(GetTriggerUnit()) == udg_Mutant)) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Timeout, udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantDialog_Func005C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) ~= true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantDialog_Func026C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A046'), udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) >= 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantDialog_Func030002001()
        return (GetFilterPlayer() ~= udg_Mutant)
    end

    ---@return boolean
    function Trig_MutantDialog_Func033Func001C()
        if (not (udg_IsNiffyLockdownActive == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantDialog_Func033C()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_MutantDialog_Actions()
        if (Trig_MutantDialog_Func005C()) then
            RemoveUnit(GetTrainedUnit())
            return
        else
        end
        udg_MutantIsUpgrading = true
        udg_MutantUpgradeLevel = (udg_MutantUpgradeLevel + 1)
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        udg_MutantUpgradingTo = GetUnitTypeId(GetTrainedUnit())
        UnitAddAbilityBJ(FourCC('Avul'), udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        PauseUnitBJ(true, udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], Player(PLAYER_NEUTRAL_PASSIVE), true)
        udg_MutantUpgrade_Health = GetUnitLifePercent(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        RemoveUnit(udg_Mutant_EvoSelector)
        RemoveUnit(GetTrainedUnit())
        CreateNUnitsAtLoc(1, FourCC('h00T'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
        UnitAddAbilityBJ(FourCC('A07E'), udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        udg_Mutant_EvolvingMass = GetLastCreatedUnit()
        SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint))
        SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint))
        SizeUnitOverTime(udg_Mutant_EvolvingMass, 2.5, 0.01, 1, false)
        RemoveLocation(udg_TempPoint)
        PolledWait(2.00)
        SetUnitPositionLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], udg_HoldZone)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            UnitAddItemSwapped(UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()),
                udg_Mutant_EvolvingMass)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_MutantDialog_Func026C()) then
            udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(udg_Mutant)]
            SetItemUserData(udg_TempItem, 0)
            SetItemVisibleBJ(true, udg_TempItem)
            SetItemPositionLoc(udg_TempItem, udg_TempPoint)
            UnitAddItemSwapped(udg_TempItem, GetLastCreatedUnit())
        else
        end
        RemoveUnit(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] = udg_Mutant_EvolvingMass
        udg_TempUnit = udg_Mutant_EvolvingMass
        udg_TempPlayerGroup = GetPlayersMatching(Condition(Trig_MutantDialog_Func030002001))
        udg_CountupBar_HideTempBool = true
        udg_CountUpBarColor = "|cffFF8000"
        if (Trig_MutantDialog_Func033C()) then
            CountUpBar(udg_TempUnit, 2, 1, "MutantUpgrade")
        else
            if (Trig_MutantDialog_Func033Func001C()) then
                CountUpBar(udg_TempUnit, 8, 1, "MutantUpgrade")
            else
                CountUpBar(udg_TempUnit, 30, 1, "MutantUpgrade")
            end
        end
    end

    --===========================================================================
    gg_trg_MutantDialog = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MutantDialog, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_MutantDialog, Condition(Trig_MutantDialog_Conditions))
    TriggerAddAction(gg_trg_MutantDialog, Trig_MutantDialog_Actions)
end)
if Debug then Debug.endFile() end
