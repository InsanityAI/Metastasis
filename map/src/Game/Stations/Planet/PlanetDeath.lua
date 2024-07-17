if Debug then Debug.beginFile "Game/Stations/Planet/PlanetDeath" end
OnInit.trig("PlanetDeath", function(require)
    function Trig_PlanetDeath_Func015A()
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

    ---@return boolean
    function Trig_PlanetDeath_Func016C()
        if (not (udg_Swagger_Grounded == true)) then
            return false
        end
        return true
    end

    function Trig_PlanetDeath_Func018A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Planet)
    end

    function Trig_PlanetDeath_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_PlanetDamage)
        DestroyTrigger(gg_trg_PlanetDamagePerSecond)
        DestroyTrigger(gg_trg_MoonMovement)
        DestroyTrigger(gg_trg_Snoeglays)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2973")
        udg_TempPoint = GetUnitLoc(GetDyingUnit())
        CreateNUnitsAtLoc(1, FourCC('e00E'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        RemoveLocation(udg_TempPoint)
        SetUnitPositionLoc(gg_unit_h008_0196, udg_HoldZone)
        SetUnitVertexColorBJ(gg_unit_h008_0196, 100, 100, 100, 100.00)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Planet), Trig_PlanetDeath_Func015A)
        if (Trig_PlanetDeath_Func016C()) then
            KillUnit(gg_unit_h00X_0049)
        else
        end
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_PlanetDeath_Func018A)
        RectOfDoom(gg_rct_Planet)
    end

    --===========================================================================
    gg_trg_PlanetDeath = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_PlanetDeath, gg_unit_h008_0196, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_PlanetDeath, Trig_PlanetDeath_Actions)
end)
if Debug then Debug.endFile() end
