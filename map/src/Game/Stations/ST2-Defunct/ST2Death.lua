if Debug then Debug.beginFile "Game/Stations/ST2/ST2Death" end
OnInit.trig("ST2Death", function(require)
    function Trig_ST2Death_Func011A()
        UnitAddAbilityBJ(FourCC('A02T'), GetEnumUnit())
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04T'), GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04U'), GetEnumUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
        udg_TempPoint = GetUnitLoc(GetEnumUnit())
        CreateNUnitsAtLoc(1, FourCC('e001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        RemoveLocation(udg_TempPoint)
    end

    function Trig_ST2Death_Func013A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_ST2)
    end

    function Trig_ST2Death_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_ST2Attack)
        DestroyTrigger(gg_trg_ST2AttackEnd)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4365")
        udg_TempPoint = GetUnitLoc(GetDyingUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 2
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomDirectionDeg(), GetRandomDirectionDeg())
            CreateNUnitsAtLoc(1, FourCC('e01E'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, GetRandomDirectionDeg())
            SetUnitAnimation(GetLastCreatedUnit(), "death")
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveLocation(udg_TempPoint)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST2), Trig_ST2Death_Func011A)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_ST2Death_Func013A)
        RectOfDoom(gg_rct_ST2)
    end

    --===========================================================================
    gg_trg_ST2Death = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST2Death, gg_unit_h005_0024, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST2Death, Trig_ST2Death_Actions)
end)
if Debug then Debug.endFile() end
