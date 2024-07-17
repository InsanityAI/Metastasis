if Debug then Debug.beginFile "Game/Stations/Moon/MoonDeath" end
OnInit.trig("MoonDeath", function(require)
    function Trig_MoonDeath_Func017A()
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

    function Trig_MoonDeath_Func019A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_MoonRect)
    end

    function Trig_MoonDeath_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_MoonMovement)
        DestroyTrigger(gg_trg_GravitationalControl)
        DestroyTrigger(gg_trg_GravitationalControlAngle)
        DestroyTrigger(gg_trg_GravitationalControlTarget)
        DestroyTrigger(gg_trg_MoonAttack)
        DestroyTrigger(gg_trg_MoonAttackEnd)
        DestroyTrigger(gg_trg_MoonDamage)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2739")
        udg_TempPoint = GetUnitLoc(GetDyingUnit())
        CreateNUnitsAtLoc(1, FourCC('e00E'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        RemoveLocation(udg_TempPoint)
        SetUnitVertexColorBJ(gg_unit_h03T_0209, 100, 100, 100, 100.00)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_MoonRect), Trig_MoonDeath_Func017A)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_MoonDeath_Func019A)
        RectOfDoom(gg_rct_MoonRect)
    end

    --===========================================================================
    gg_trg_MoonDeath = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_MoonDeath, gg_unit_h03T_0209, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_MoonDeath, Trig_MoonDeath_Actions)
end)
if Debug then Debug.endFile() end
