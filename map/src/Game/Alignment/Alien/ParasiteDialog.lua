if Debug then Debug.beginFile "Game/Allignment/Alien/ParasiteDialog" end
OnInit.trig("ParasiteDialog", function(require)
    ---@return boolean
    function Trig_ParasiteDialog_Conditions()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A078'), GetTriggerUnit()) == 1)) then
            return false
        end
        if (not (GetOwningPlayer(GetTriggerUnit()) == udg_Parasite)) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Timeout, udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteDialog_Func006C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) ~= true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteDialog_Func021C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A046'), udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) >= 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteDialog_Func027002001()
        return (GetFilterPlayer() ~= udg_Parasite)
    end

    ---@return boolean
    function Trig_ParasiteDialog_Func040Func001C()
        if (not (udg_IsNiffyLockdownActive == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteDialog_Func040C()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_ParasiteDialog_Actions()
        local a ---@type unit
        if (Trig_ParasiteDialog_Func006C()) then
            RemoveUnit(GetTrainedUnit())
            return
        else
        end
        udg_ParasiteIsUpgrading = true
        udg_ParasiteUpgradeLevel = (udg_ParasiteUpgradeLevel + 1)
        udg_ParasiteUpgradingTo = GetUnitTypeId(GetTrainedUnit())
        RemoveUnit(udg_Parasite_EvoSelector)
        RemoveUnit(GetTrainedUnit())
        UnitAddAbilityBJ(FourCC('Avul'), udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        PauseUnitBJ(true, udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], Player(PLAYER_NEUTRAL_PASSIVE), true)
        UnitAddAbilityBJ(FourCC('A07E'), udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        PolledWait(2)
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        CreateNUnitsAtLoc(1, FourCC('h02X'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, GetRandomDirectionDeg())
        a = GetLastCreatedUnit()
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            UnitAddItemSwapped(UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], GetForLoopIndexA()),
                GetLastCreatedUnit())
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_ParasiteDialog_Func021C()) then
            udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(udg_Parasite)]
            SetItemUserData(udg_TempItem, 0)
            SetItemVisibleBJ(true, udg_TempItem)
            SetItemPositionLoc(udg_TempItem, udg_TempPoint)
            UnitAddItemSwapped(udg_TempItem, GetLastCreatedUnit())
        else
        end
        SetUnitPositionLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], udg_HoldZone)
        RemoveUnit(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        udg_AlienForm_Alien = GetLastCreatedUnit()
        udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
        udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
        udg_TempPlayerGroup = GetPlayersMatching(Condition(Trig_ParasiteDialog_Func027002001))
        udg_CountupBar_HideTempBool = true
        udg_CountUpBarColor = "|cff800080"
        RemoveLocation(udg_TempPoint)
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        CreateNUnitsAtLoc(1, FourCC('e00H'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        CreateNUnitsAtLoc(1, FourCC('e00H'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        CreateNUnitsAtLoc(1, FourCC('e00A'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        CreateNUnitsAtLoc(1, FourCC('e00A'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        RemoveLocation(udg_TempPoint)
        udg_TempUnit = a
        if (Trig_ParasiteDialog_Func040C()) then
            CountUpBar(udg_TempUnit, 2, 1, "ParasiteUpgrade")
        else
            if (Trig_ParasiteDialog_Func040Func001C()) then
                CountUpBar(udg_TempUnit, 8, 1, "ParasiteUpgrade")
            else
                CountUpBar(udg_TempUnit, 30, 1, "ParasiteUpgrade")
            end
        end
    end

    --===========================================================================
    gg_trg_ParasiteDialog = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ParasiteDialog, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddCondition(gg_trg_ParasiteDialog, Condition(Trig_ParasiteDialog_Conditions))
    TriggerAddAction(gg_trg_ParasiteDialog, Trig_ParasiteDialog_Actions)
end)
if Debug then Debug.endFile() end
