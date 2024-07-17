if Debug then Debug.beginFile "Game/Stations/ST10/ST10Death" end
OnInit.trig("ST10Death", function(require)
    function Trig_ST10Death_Func009A()
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

    function Trig_ST10Death_Func011A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_ST10)
    end

    function Trig_ST10Death_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5376")
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
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST10), Trig_ST10Death_Func009A)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_ST10Death_Func011A)
        RectOfDoom(gg_rct_ST10)
    end

    --===========================================================================
    gg_trg_ST10Death = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST10Death, gg_unit_h04V_0253, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST10Death, Trig_ST10Death_Actions)
end)
if Debug then Debug.endFile() end
