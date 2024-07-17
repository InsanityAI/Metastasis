if Debug then Debug.beginFile "Game/Allignment/Alien/ParasiteUpgrade" end
OnInit.map("ParasiteUpgrade", function(require)
    ---@return boolean
    function Trig_ParasiteUpgrade_Conditions()
        if (not (GetTriggerPlayer() == udg_Parasite)) then
            return false
        end
        if (not (udg_ParasiteIsUpgrading == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgrade_Func017Func006Func002C()
        if (not (udg_AlienCurrentForm == FourCC('h035'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgrade_Func017Func006Func003C()
        if (not (udg_AlienCurrentForm == FourCC('h02V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgrade_Func017Func006Func004C()
        if (not (udg_AlienCurrentForm == FourCC('h03E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgrade_Func017Func006C()
        if (not (udg_ParasiteUpgradeLevel == 1)) then
            return false
        end
        if (not (udg_UpgradePointsAlien >= 1370.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ParasiteUpgrade_Func017C()
        if (not (udg_ParasiteUpgradeLevel == 0)) then
            return false
        end
        if (not (udg_UpgradePointsAlien >= 660.00)) then
            return false
        end
        return true
    end

    function Trig_ParasiteUpgrade_Actions()
        RemoveUnit(udg_Parasite_EvoSelector)
        if (Trig_ParasiteUpgrade_Func017C()) then
            udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
            CreateNUnitsAtLoc(1, FourCC('e023'), udg_Parasite, udg_TempPoint, bj_UNIT_FACING)
            udg_Parasite_EvoSelector = GetLastCreatedUnit()
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
            RemoveLocation(udg_TempPoint)
        else
            if (Trig_ParasiteUpgrade_Func017Func006C()) then
                DialogClearBJ(udg_ParasiteChooseDialog)
                if (Trig_ParasiteUpgrade_Func017Func006Func002C()) then
                    udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    CreateNUnitsAtLoc(1, FourCC('e029'), udg_Parasite, udg_TempPoint, bj_UNIT_FACING)
                    udg_Parasite_EvoSelector = GetLastCreatedUnit()
                    SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
                    RemoveLocation(udg_TempPoint)
                else
                end
                if (Trig_ParasiteUpgrade_Func017Func006Func003C()) then
                    udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    CreateNUnitsAtLoc(1, FourCC('e028'), udg_Parasite, udg_TempPoint, bj_UNIT_FACING)
                    udg_Parasite_EvoSelector = GetLastCreatedUnit()
                    SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
                    RemoveLocation(udg_TempPoint)
                else
                end
                if (Trig_ParasiteUpgrade_Func017Func006Func004C()) then
                    udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])
                    CreateNUnitsAtLoc(1, FourCC('e027'), udg_Parasite, udg_TempPoint, bj_UNIT_FACING)
                    udg_Parasite_EvoSelector = GetLastCreatedUnit()
                    SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
                    RemoveLocation(udg_TempPoint)
                else
                end
            else
            end
        end
        -- Trigger - Turn on Infinite Alien bugfix <gen>
    end

    --===========================================================================
    gg_trg_ParasiteUpgrade = CreateTrigger()
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(0))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(1))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(2))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(3))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(4))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(5))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(6))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(7))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(8))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(9))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(10))
    TriggerRegisterPlayerEventEndCinematic(gg_trg_ParasiteUpgrade, Player(11))
    TriggerAddCondition(gg_trg_ParasiteUpgrade, Condition(Trig_ParasiteUpgrade_Conditions))
    TriggerAddAction(gg_trg_ParasiteUpgrade, Trig_ParasiteUpgrade_Actions)
end)
if Debug then Debug.endFile() end
