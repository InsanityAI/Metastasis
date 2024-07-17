if Debug then Debug.beginFile "Game/Stations/ST5/ST5Death" end
OnInit.map("ST5Death", function(require)
    function Trig_ST5Death_Func018A()
        UnitAddAbilityBJ(FourCC('A02T'), GetEnumUnit())
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        UnitRemoveAbilityBJ(FourCC('A04T'), GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04U'), GetEnumUnit())
        MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
        udg_TempPoint = GetUnitLoc(GetEnumUnit())
        CreateNUnitsAtLoc(1, FourCC('e001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        RemoveLocation(udg_TempPoint)
    end

    function Trig_ST5Death_Func020A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_ST5)
    end

    function Trig_ST5Death_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_ST5Abilities)
        DestroyTrigger(gg_trg_ST5Attack)
        DestroyTrigger(gg_trg_ST5AttackEnd)
        DestroyTrigger(gg_trg_SwaggerTeleportToPlanet)
        DestroyTrigger(gg_trg_SwaggerTeleportToSwagger)
        RemoveUnit(gg_unit_h03O_0208)
        RemoveUnit(gg_unit_e012_0092)
        DestroyTrigger(gg_trg_ST5Abilities)
        DestroyTrigger(gg_trg_Autopilot)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2679")
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
        ForGroupBJ(GetUnitsInRectAll(gg_rct_ST5), Trig_ST5Death_Func018A)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_ST5Death_Func020A)
        RectOfDoom(gg_rct_ST5)
    end

    --===========================================================================
    gg_trg_ST5Death = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST5Death, gg_unit_h00X_0049, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST5Death, Trig_ST5Death_Actions)
end)
if Debug then Debug.endFile() end
