if Debug then Debug.beginFile "Game/Stations/ST4/ST4Death" end
OnInit.trig("ST4Death", function(require)
    function Trig_ST4Death_Func018A()
        UnitAddAbilityBJ(FourCC('A02T'), GetEnumUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04T'), GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04U'), GetEnumUnit())
        MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
        udg_TempPoint = GetUnitLoc(GetEnumUnit())
        CreateNUnitsAtLoc(1, FourCC('e001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        RemoveLocation(udg_TempPoint)
    end

    function Trig_ST4Death_Func020A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_ST4S2)
    end

    function Trig_ST4Death_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_ST4Abilities)
        DestroyTrigger(gg_trg_ST4Attack)
        DestroyTrigger(gg_trg_ST4AttackEnd)
        DestroyTrigger(gg_trg_ST4Death)
        DestroyTrigger(gg_trg_ST4DefenseDrone1)
        DestroyTrigger(gg_trg_ST4DefenseDrone1Loss)
        DestroyTrigger(gg_trg_ST4DefenseDrone2)
        DestroyTrigger(gg_trg_ST4DefenseDrone2Loss)
        TriggerExecute(gg_trg_ResetPowerBonus)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4367")
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
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST4S2), Trig_ST4Death_Func018A)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_ST4Death_Func020A)
        RectOfDoom(gg_rct_ST4S2)
    end

    --===========================================================================
    gg_trg_ST4Death = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST4Death, gg_unit_h009_0029, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST4Death, Trig_ST4Death_Actions)
end)
if Debug then Debug.endFile() end
