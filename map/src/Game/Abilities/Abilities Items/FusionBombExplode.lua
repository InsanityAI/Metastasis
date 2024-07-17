if Debug then Debug.beginFile "Game/Abilities/Items/FusionBombExplode" end
OnInit.trig("FusionBombExplode", function(require)
    ---@return boolean
    function Trig_FusionBombExplode_Func006Func001Func001C()
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('DTrx'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT40'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT16'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT06'))) then
            return false
        end
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('YT30'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func006Func001C()
        if (not Trig_FusionBombExplode_Func006Func001Func001C()) then
            return false
        end
        return true
    end

    function Trig_FusionBombExplode_Func006A()
        if (Trig_FusionBombExplode_Func006Func001C()) then
            KillDestructable(GetEnumDestructable())
        else
        end
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func010Func002C()
        if (not (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] <= 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func010Func003C()
        if (not (Player(bj_PLAYER_NEUTRAL_EXTRA) == GetOwningPlayer(GetEnumUnit()))) then
            return false
        end
        return true
    end

    function Trig_FusionBombExplode_Func010A()
        udg_TempPlayer = GetOwningPlayer(GetEnumUnit())
        if (Trig_FusionBombExplode_Func010Func002C()) then
            CameraSetEQNoiseForPlayer(GetOwningPlayer(GetEnumUnit()), 9.00)
            ExecuteFunc("BombEndShaking")
        else
        end
        if (Trig_FusionBombExplode_Func010Func003C()) then
            CinematicFilterGenericForPlayer(udg_Parasite, 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100, 100, 100, 0, 0, 0, 0, 100)
        else
            CinematicFilterGenericForPlayer(GetOwningPlayer(GetEnumUnit()), 6.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100, 100, 100, 0, 0, 0, 0, 100)
        end
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func013Func002Func001Func001C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A03U'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func013Func002Func001C()
        if (not Trig_FusionBombExplode_Func013Func002Func001Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func013Func002C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_FusionBombExplode_Func013A()
        udg_TempBool = UnitInSector(GetEnumUnit(), udg_TempInt)
        if (Trig_FusionBombExplode_Func013Func002C()) then
            if (Trig_FusionBombExplode_Func013Func002Func001C()) then
                UnitDamageTargetBJ(udg_TempUnit, GetEnumUnit(), 5000.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
            else
            end
        else
        end
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func014Func002Func001Func001C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A03U'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func014Func002Func001C()
        if (not Trig_FusionBombExplode_Func014Func002Func001Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FusionBombExplode_Func014Func002C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_FusionBombExplode_Func014A()
        udg_TempBool = UnitInSector(GetEnumUnit(), udg_TempInt)
        if (Trig_FusionBombExplode_Func014Func002C()) then
            if (Trig_FusionBombExplode_Func014Func002Func001C()) then
                UnitDamageTargetBJ(udg_TempUnit, GetEnumUnit(), 200.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
            else
            end
        else
        end
    end

    function Trig_FusionBombExplode_Actions()
        udg_TempUnit = udg_CountupBarTemp
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        SetUnitAnimation(udg_TempUnit, "decay")
        CreateNUnitsAtLoc(1, FourCC('e004'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        udg_TempInt = GetSector(udg_TempPoint)
        EnumDestructablesInCircleBJ(400.00, udg_TempPoint, Trig_FusionBombExplode_Func006A)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 14
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = IntelligentRubble(udg_TempPoint, GetRandomReal(0, 800), GetRandomDirectionDeg())
            CreateNUnitsAtLoc(1, FourCC('e002'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, GetRandomDirectionDeg())
            CreateDestructableLoc(FourCC('B003'), udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0)
            SetDestructableLifePercentBJ(GetLastCreatedDestructable(), GetRandomReal(15.00, 75.00))
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = IntelligentRubble(udg_TempPoint, GetRandomReal(0, 250),
                bj_forLoopAIndex * (360.0 / bj_forLoopAIndexEnd))
            CreateDestructableLoc(FourCC('B003'), udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0)
            SetDestructableLifePercentBJ(GetLastCreatedDestructable(), GetRandomReal(50.00, 100.00))
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 8
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = IntelligentRubble(udg_TempPoint, GetRandomReal(250, 400),
                bj_forLoopAIndex * (360.0 / bj_forLoopAIndexEnd))
            CreateDestructableLoc(FourCC('B003'), udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0)
            SetDestructableLifePercentBJ(GetLastCreatedDestructable(), GetRandomReal(50.00, 100.00))
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        ForGroupBJ(GetUnitsInRangeOfLocAll(1800.00, udg_TempPoint), Trig_FusionBombExplode_Func010A)
        SetSoundPositionLocBJ(gg_snd_BuildingDeathLargeHuman, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_BuildingDeathLargeHuman)
        ForGroupBJ(GetUnitsInRangeOfLocAll(250.00, udg_TempPoint), Trig_FusionBombExplode_Func013A)
        ForGroupBJ(GetUnitsInRangeOfLocAll(550.00, udg_TempPoint), Trig_FusionBombExplode_Func014A)
        AddSpecialEffectLoc("war3mapImported\\BlackSplat.mdl", udg_TempPoint)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_FusionBombExplode = CreateTrigger()
    TriggerAddAction(gg_trg_FusionBombExplode, Trig_FusionBombExplode_Actions)
end)
if Debug then Debug.endFile() end
