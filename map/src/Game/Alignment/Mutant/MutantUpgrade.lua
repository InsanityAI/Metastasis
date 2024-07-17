if Debug then Debug.beginFile "Game/Allignment/Mutant/MutantUpgrade" end
OnInit.trig("MutantUpgrade", function(require)
    ---@return boolean
    function Trig_MutantUpgrade_Conditions()
        if (not (GetTriggerPlayer() == udg_Mutant)) then
            return false
        end
        if (not (udg_MutantIsUpgrading == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006Func001Func001C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == FourCC('h01B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006Func001Func002C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == FourCC('h01I'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006Func001Func003C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == FourCC('h01O'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006Func001Func004C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == FourCC('h01E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006Func001C()
        if (not (udg_MutantUpgradeLevel == 2)) then
            return false
        end
        if (not (udg_UpgradePointsMutant >= 1800.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006Func002C()
        if (not (GetUnitTypeId(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == FourCC('h00V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017Func006C()
        if (not (udg_MutantUpgradeLevel == 1)) then
            return false
        end
        if (not (udg_UpgradePointsMutant >= 900.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantUpgrade_Func017C()
        if (not (udg_MutantUpgradeLevel == 0)) then
            return false
        end
        if (not (udg_UpgradePointsMutant >= 300.00)) then
            return false
        end
        return true
    end

    function Trig_MutantUpgrade_Actions()
        RemoveUnit(udg_Mutant_EvoSelector)
        if (Trig_MutantUpgrade_Func017C()) then
            udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
            CreateNUnitsAtLoc(1, FourCC('e02A'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
            udg_Mutant_EvoSelector = GetLastCreatedUnit()
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
            RemoveLocation(udg_TempPoint)
        else
            if (Trig_MutantUpgrade_Func017Func006C()) then
                if (Trig_MutantUpgrade_Func017Func006Func002C()) then
                    udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    CreateNUnitsAtLoc(1, FourCC('e02C'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                    udg_Mutant_EvoSelector = GetLastCreatedUnit()
                    SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
                    RemoveLocation(udg_TempPoint)
                else
                    udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    CreateNUnitsAtLoc(1, FourCC('e02B'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                    udg_Mutant_EvoSelector = GetLastCreatedUnit()
                    SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
                    RemoveLocation(udg_TempPoint)
                end
            else
                if (Trig_MutantUpgrade_Func017Func006Func001C()) then
                    if (Trig_MutantUpgrade_Func017Func006Func001Func001C()) then
                        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                        CreateNUnitsAtLoc(1, FourCC('e02F'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                        udg_Mutant_EvoSelector = GetLastCreatedUnit()
                        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
                        RemoveLocation(udg_TempPoint)
                    else
                    end
                    if (Trig_MutantUpgrade_Func017Func006Func001Func002C()) then
                        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                        CreateNUnitsAtLoc(1, FourCC('e02D'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                        udg_Mutant_EvoSelector = GetLastCreatedUnit()
                        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
                        RemoveLocation(udg_TempPoint)
                    else
                    end
                    if (Trig_MutantUpgrade_Func017Func006Func001Func003C()) then
                        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                        CreateNUnitsAtLoc(1, FourCC('e02E'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                        udg_Mutant_EvoSelector = GetLastCreatedUnit()
                        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
                        RemoveLocation(udg_TempPoint)
                    else
                    end
                    if (Trig_MutantUpgrade_Func017Func006Func001Func004C()) then
                        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                        CreateNUnitsAtLoc(1, FourCC('e02G'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                        udg_Mutant_EvoSelector = GetLastCreatedUnit()
                        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant)
                        RemoveLocation(udg_TempPoint)
                    else
                    end
                else
                end
            end
        end
        -- Trigger - Turn on Infinite Mutant bugfix <gen>
    end

    --===========================================================================
    gg_trg_MutantUpgrade = CreateTrigger()
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(0))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(1))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(2))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(3))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(4))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(5))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(6))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(7))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(8))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(9))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(10))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_MutantUpgrade, Player(11))
    TriggerAddCondition(gg_trg_MutantUpgrade, Condition(Trig_MutantUpgrade_Conditions))
    TriggerAddAction(gg_trg_MutantUpgrade, Trig_MutantUpgrade_Actions)
end)
if Debug then Debug.endFile() end
