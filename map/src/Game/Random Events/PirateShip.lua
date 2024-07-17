if Debug then Debug.beginFile "Game/RandomEvents/PirateShip" end
OnInit.trig("PirateShip", function(require)
    function Trig_PirateShip_Func008A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_PirateShip)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_PirateShip_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[4] = true
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3012")
        udg_TempPoint = GetRandomLocInRect(gg_rct_SpaceSound)
        SetUnitPositionLoc(gg_unit_h02B_0116, udg_TempPoint)
        PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint, 15.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 0.00, 0.00)
        RemoveLocation(udg_TempPoint)
        ForForce(GetPlayersAll(), Trig_PirateShip_Func008A)
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00))
        SetUnitOwner(gg_unit_h02B_0116, Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        udg_TempUnit = gg_unit_h02B_0116
        udg_SpaceAI_PirateCaptainAlive = true
    end

    --===========================================================================
    gg_trg_PirateShip = CreateTrigger()
    DisableTrigger(gg_trg_PirateShip)
    TriggerAddAction(gg_trg_PirateShip, Trig_PirateShip_Actions)
end)
if Debug then Debug.endFile() end
