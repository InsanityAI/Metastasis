if Debug then Debug.beginFile "Game/Abilities/Android/AshenDeath" end
OnInit.map("AshenDeath", function(require)
    ---@return boolean
    function Trig_AshenDeath_Conditions()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A0A9'), GetTriggerUnit()) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AshenDeath_Func016Func001Func002C()
        if ((udg_Mutant == GetEnumPlayer())) then
            return true
        end
        if ((udg_Parasite == GetEnumPlayer())) then
            return true
        end
        if ((udg_HiddenAndroid == GetEnumPlayer())) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AshenDeath_Func016Func001C()
        if (not Trig_AshenDeath_Func016Func001Func002C()) then
            return false
        end
        return true
    end

    function Trig_AshenDeath_Func016A()
        if (Trig_AshenDeath_Func016Func001C()) then
        else
            udg_TempInt = (udg_TempInt + 1)
        end
    end

    ---@return boolean
    function Trig_AshenDeath_Func017C()
        if (not (udg_TempInt == 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AshenDeath_Func019Func002Func028C()
        if ((udg_Mutant == GetEnumPlayer())) then
            return true
        end
        if ((udg_Parasite == GetEnumPlayer())) then
            return true
        end
        if ((udg_HiddenAndroid == GetEnumPlayer())) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AshenDeath_Func019Func002C()
        if (not Trig_AshenDeath_Func019Func002Func028C()) then
            return false
        end
        return true
    end

    function Trig_AshenDeath_Func019A()
        -- Do not revive alien and mutant
        if (Trig_AshenDeath_Func019Func002C()) then
        else
            -- Determining spawn point via angle
            udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 240.00, udg_TempReal)
            -- Close the dead chat board
            if GetLocalPlayer() == GetEnumPlayer() then
                MultiboardDisplay(ChatBoard, false)
            end
            CreateNUnitsAtLoc(1, FourCC('n00L'), GetEnumPlayer(), udg_TempPoint, udg_TempReal)
            GroupAddUnitSimple(GetLastCreatedUnit(), udg_AshenMarineGroup)
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl")
            DestroyEffectBJ(GetLastCreatedEffectBJ())
            udg_TempReal = (udg_TempReal + (360.00 / I2R(udg_TempInt)))
            udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetEnumPlayer())] = false
            udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetEnumPlayer())] = false
            DisplayTextToPlayer(GetOwningPlayer(GetLastCreatedUnit()), 0, 0,
                "|cffff3909The Android brought you back to life - one last chance to carry mankind, since he crumbled under the burden. Make sure you do not die alone again, but take all of your enemies with you.|r")
            SetUnitLifePercentBJ(GetLastCreatedUnit(), 50.00)
            udg_Playerhero[GetConvertedPlayerId(GetEnumPlayer())] = GetLastCreatedUnit()
            SetPlayerName(GetEnumPlayer(), udg_Player_NameBeforeDead[GetConvertedPlayerId(GetEnumPlayer())])
            ShowInterfaceForceOn(GetForceOfPlayer(GetEnumPlayer()), 0.25)
            PanCameraToTimedLocForPlayer(GetEnumPlayer(), udg_TempPoint, 0)
            SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetEnumPlayer())
            RemoveLocation(udg_TempPoint)
            udg_TempPlayer = GetEnumPlayer()
            SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), GetEnumPlayer(), bj_ALLIANCE_ALLIED)
            SetPlayerAllianceStateBJ(GetEnumPlayer(), Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED)
            ForceAddPlayerSimple(udg_TempPlayer, udg_TempPlayerGroup)
            ForceRemovePlayerSimple(GetEnumPlayer(), udg_DeadGroup)
        end
    end

    function Trig_AshenDeath_Func020Func002A()
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED)
    end

    function Trig_AshenDeath_Func020Func003A()
        SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED)
        SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION)
    end

    function Trig_AshenDeath_Func020A()
        udg_TempPlayer = GetEnumPlayer()
        ForForce(GetPlayersAll(), Trig_AshenDeath_Func020Func002A)
        ForForce(udg_DeadGroup, Trig_AshenDeath_Func020Func003A)
    end

    function Trig_AshenDeath_Actions()
        local a       = GetUnitLoc(GetTriggerUnit()) ---@type location
        udg_TempPoint = a
        CreateNUnitsAtLoc(1, FourCC('e00R'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        udg_CountUpBarColor = "|cffFF0000"
        BasicAI_IssueDangerArea(a, 800.0, 3.1)
        CountUpBar(udg_TempUnit, 60, 0.05, "FusionBombExplosion2")
        TriggerSleepAction(3.00)
        -- ---
        udg_TempPoint2 = a
        udg_TempReal = 0.00
        -- TempInt = amount of players to revive
        udg_TempInt = 0
        ForForce(udg_DeadGroup, Trig_AshenDeath_Func016A)
        if (Trig_AshenDeath_Func017C()) then
            return
        else
        end
        ForceClear(udg_TempPlayerGroup)
        ForForce(udg_DeadGroup, Trig_AshenDeath_Func019A)
        ForForce(udg_TempPlayerGroup, Trig_AshenDeath_Func020A)
        StartTimerBJ(udg_AshenMarineFadeTimer, true, 1.12)
        ForceClear(udg_TempPlayerGroup)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_AshenDeath = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AshenDeath, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_AshenDeath, Condition(Trig_AshenDeath_Conditions))
    TriggerAddAction(gg_trg_AshenDeath, Trig_AshenDeath_Actions)
end)
if Debug then Debug.endFile() end
