if Debug then Debug.beginFile "Game/Abilities/Mutant/CarrierSackExplode" end
OnInit.map("CarrierSackExplode", function(require)
    function Trig_CarrierSackExplode_Func004A()
        UnitDamageTargetBJ(udg_TempUnit4, GetEnumUnit(), 1000.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
    end

    function Trig_CarrierSackExplode_Func005A()
        UnitDamageTargetBJ(udg_TempUnit4, GetEnumUnit(), 125.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
    end

    ---@return boolean
    function Trig_CarrierSackExplode_Func006Func001C()
        if (not (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('DTrx'))) then
            return false
        end
        return true
    end

    function Trig_CarrierSackExplode_Func006A()
        if (Trig_CarrierSackExplode_Func006Func001C()) then
            KillDestructable(GetEnumDestructable())
        else
        end
    end

    function Trig_CarrierSackExplode_Func008A()
        udg_TempPlayer = GetOwningPlayer(GetEnumUnit())
        CinematicFilterGenericForPlayer(GetOwningPlayer(GetEnumUnit()), 2.0, BLEND_MODE_BLEND,
            "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100, 0, 0, 0, 0, 0, 0, 100)
    end

    function Trig_CarrierSackExplode_Actions()
        udg_TempUnit4 = udg_CountupBarTemp
        udg_TempPoint = GetUnitLoc(udg_TempUnit4)
        CreateNUnitsAtLoc(1, FourCC('e00A'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        ForGroupBJ(GetUnitsInRangeOfLocAll(200.00, udg_TempPoint), Trig_CarrierSackExplode_Func004A)
        ForGroupBJ(GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), Trig_CarrierSackExplode_Func005A)
        EnumDestructablesInCircleBJ(300.00, udg_TempPoint, Trig_CarrierSackExplode_Func006A)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 5
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomReal(0, 400.00), GetRandomDirectionDeg())
            CreateNUnitsAtLoc(1, FourCC('e00A'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, bj_UNIT_FACING)
            CreateDestructableLoc(FourCC('B003'), udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0)
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        ForGroupBJ(GetUnitsInRangeOfLocAll(900.00, udg_TempPoint), Trig_CarrierSackExplode_Func008A)
        SetSoundPositionLocBJ(gg_snd_EggSackDeath1, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_EggSackDeath1)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_CarrierSackExplode = CreateTrigger()
    TriggerAddAction(gg_trg_CarrierSackExplode, Trig_CarrierSackExplode_Actions)
end)
if Debug then Debug.endFile() end
