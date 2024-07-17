if Debug then Debug.beginFile "Game/Stations/ST7/ST7Death" end
OnInit.trig("ST7Death", function(require)
    function Trig_ST7Death_Func008A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_PirateShip)
    end

    function Trig_ST7Death_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1355")
        StartTimerBJ(udg_PirateShip_DestructionTimer, false, 40.00)
        CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_1354")
        udg_PirateShip_CountdownWindow = GetLastCreatedTimerDialogBJ()
        PolledWait(5.00)
        ForForce(GetPlayersAll(), Trig_ST7Death_Func008A)
    end

    --===========================================================================
    gg_trg_ST7Death = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST7Death, gg_unit_h02A_0115, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST7Death, Trig_ST7Death_Actions)
end)
if Debug then Debug.endFile() end
