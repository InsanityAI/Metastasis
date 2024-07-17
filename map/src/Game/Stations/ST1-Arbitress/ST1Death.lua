if Debug then Debug.beginFile "Game/Stations/ST1/ST1Death" end
OnInit.trig("ST1Death", function(require)
    function Trig_ST1Death_Func013A()
        UnitAddAbilityBJ(FourCC('A02T'), GetEnumUnit())
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04T'), GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04U'), GetEnumUnit())
        MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        udg_TempPoint = GetUnitLoc(GetEnumUnit())
        CreateNUnitsAtLoc(1, FourCC('e001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        RemoveLocation(udg_TempPoint)
    end

    function Trig_ST1Death_Func015A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_ST1)
    end

    function Trig_ST1Death_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_ST1Abilities)
        DestroyTrigger(gg_trg_ST1Death)
        DestroyTrigger(gg_trg_ST1Attack)
        DestroyTrigger(gg_trg_ST1AttackEnd)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        udg_TempPoint = GetUnitLoc(GetDyingUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 4
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomDirectionDeg(), GetRandomDirectionDeg())
            CreateNUnitsAtLoc(1, FourCC('e01E'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, GetRandomDirectionDeg())
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveLocation(udg_TempPoint)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_137")
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST1), Trig_ST1Death_Func013A)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_ST1Death_Func015A)
        RectOfDoom(gg_rct_ST1)
    end

    --===========================================================================
    gg_trg_ST1Death = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST1Death, gg_unit_h003_0018, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST1Death, Trig_ST1Death_Actions)
end)
if Debug then Debug.endFile() end
