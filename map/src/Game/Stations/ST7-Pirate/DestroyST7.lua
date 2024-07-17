if Debug then Debug.beginFile "Game/Stations/ST7/DestroyST7" end
OnInit.trig("DestroyST7", function(require)
    function Trig_DestroyST7_Func006A()
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
    end

    function Trig_DestroyST7_Func010A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_PirateShip)
    end

    function Trig_DestroyST7_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DestroyTrigger(gg_trg_ST7Death)
        KillUnit(gg_unit_h02B_0116)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_PirateShip), Trig_DestroyST7_Func006A)
        DestroyTimerDialogBJ(udg_PirateShip_CountdownWindow)
        CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 5.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00,
            0, 0, 0)
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_DestroyST7_Func010A)
        RectOfDoom(gg_rct_PirateShip)
    end

    --===========================================================================
    gg_trg_DestroyST7 = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_DestroyST7, udg_PirateShip_DestructionTimer)
    TriggerRegisterUnitEvent(gg_trg_DestroyST7, gg_unit_h02B_0116, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_DestroyST7, Trig_DestroyST7_Actions)
end)
if Debug then Debug.endFile() end
