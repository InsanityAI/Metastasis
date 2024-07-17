if Debug then Debug.beginFile "Game/Abilities/Items/TeleportBombExplode" end
OnInit.map("TeleportBombExplode", function(require)
    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func003Func001C()
        if (not (IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A079'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    function Trig_TeleportBombExplode_Func003Func003A()
        if (Trig_TeleportBombExplode_Func003Func003Func001C()) then
            udg_TempBool = true
        else
        end
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func005C()
        if (not (udg_TempBool == false)) then
            return false
        end
        if (not (udg_Mirror_Enabled == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func007Func007C()
        if (not (udg_Mirror_Enabled == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func007Func009Func001Func008C()
        if (not (GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func007Func009Func001C()
        if (not (IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A079'), GetEnumUnit()) == 0)) then
            return false
        end
        if (not (RectContainsUnit(gg_rct_Mirror_Arena, GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_TeleportBombExplode_Func003Func007Func009A()
        if (Trig_TeleportBombExplode_Func003Func007Func009Func001C()) then
            SetUnitPositionLoc(GetEnumUnit(), udg_TeleportBombMirrorExitPoint)
            -- Mandatory Teleporting stuff
            SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TempPoint, 0)
            PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
            CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
            CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TeleportBombMirrorExitPoint,
                bj_UNIT_FACING)
            -- Mandatory Teleporting stuff
            if (Trig_TeleportBombExplode_Func003Func007Func009Func001Func008C()) then
                PanCameraToTimedLocForPlayer(udg_Parasite, udg_TeleportBombMirrorExitPoint, 0)
            else
                PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()), udg_TeleportBombMirrorExitPoint, 0)
            end
        else
        end
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func007Func016Func001Func002C()
        if (not (GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func007Func016Func001C()
        if (not (IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A079'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    function Trig_TeleportBombExplode_Func003Func007Func016A()
        if (Trig_TeleportBombExplode_Func003Func007Func016Func001C()) then
            SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint2)
            if (Trig_TeleportBombExplode_Func003Func007Func016Func001Func002C()) then
                PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint2, 0)
            else
                PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()), udg_TempPoint2, 0)
            end
        else
        end
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003Func007C()
        if (not (RectContainsLoc(gg_rct_Mirror_Arena, udg_TempPoint) == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func003C()
        if (not (IsUnitDeadBJ(gg_unit_h009_0029) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func012Func001Func002Func002Func002C()
        if (not (GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func012Func001Func002Func002C()
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func012Func001Func002C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_TeleportBombExplode_Func012Func001C()
        if (not (IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false)) then
            return false
        end
        if (not (GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A079'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    function Trig_TeleportBombExplode_Func012A()
        if (Trig_TeleportBombExplode_Func012Func001C()) then
            udg_TempBool = UnitInSector(GetEnumUnit(), udg_TempInt)
            if (Trig_TeleportBombExplode_Func012Func001Func002C()) then
                SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint2)
                if (Trig_TeleportBombExplode_Func012Func001Func002Func002C()) then
                    UnitDamageTargetBJ(GetEnumUnit(), GetEnumUnit(), 100.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_UNKNOWN)
                    if (Trig_TeleportBombExplode_Func012Func001Func002Func002Func002C()) then
                        PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint2, 0)
                    else
                        PanCameraToTimedLocForPlayer(GetOwningPlayer(GetEnumUnit()), udg_TempPoint2, 0)
                    end
                else
                end
            else
            end
        else
        end
    end

    function Trig_TeleportBombExplode_Actions()
        udg_TempUnit = udg_CountupBarTemp
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        if (Trig_TeleportBombExplode_Func003C()) then
            -- Check if any unit is to go inside
            udg_TempBool = false
            ForGroupBJ(GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), Trig_TeleportBombExplode_Func003Func003A)
            DestroyGroup(udg_TempUnitGroup)
            if (Trig_TeleportBombExplode_Func003Func005C()) then
                return
            else
            end
            -- End Check if any unit is to go inside
            if (Trig_TeleportBombExplode_Func003Func007C()) then
                udg_TeleportBombMirrorExitPoint = GetUnitLoc(udg_TempUnit)
                DestroyEffectBJ(udg_Mirror_EntranceVisual)
                AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl")
                udg_Mirror_EntranceVisual = GetLastCreatedEffectBJ()
                -- The above special effect stays and shows the portal exit
                if (Trig_TeleportBombExplode_Func003Func007Func007C()) then
                    udg_Mirror_Enabled = true
                    TriggerExecute(gg_trg_Mirror_start)
                else
                end
                -- Mandatory Teleporting stuff
                SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TempPoint, 0)
                PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
                CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
                udg_TempPoint2 = GetRectCenter(gg_rct_Mirror_Arena)
                CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, bj_UNIT_FACING)
                ForGroupBJ(GetUnitsInRangeOfLocAll(400.00, udg_TempPoint),
                    Trig_TeleportBombExplode_Func003Func007Func016A)
            else
                -- Using teleport in mirror arena lmao
                ForGroupBJ(GetUnitsInRangeOfLocAll(400.00, udg_TempPoint),
                    Trig_TeleportBombExplode_Func003Func007Func009A)
            end
            RemoveLocation(udg_TempPoint)
            RemoveLocation(udg_TempPoint2)
            return
        else
        end
        SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
        CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        udg_TempPoint2 = GetRectCenter(gg_rct_BombTeleport)
        SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint)
        -- 100% to damage (aka no RnG), to do 100 dmg is interesting.
        CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, bj_UNIT_FACING)
        udg_TempInt = GetSector(udg_TempPoint)
        ForGroupBJ(GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), Trig_TeleportBombExplode_Func012A)
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_TeleportBombExplode = CreateTrigger()
    TriggerAddAction(gg_trg_TeleportBombExplode, Trig_TeleportBombExplode_Actions)
end)
if Debug then Debug.endFile() end
