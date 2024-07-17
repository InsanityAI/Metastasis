if Debug then Debug.beginFile "Game/Stations/ST8/ST8Init" end
OnInit.map("ST8Init", function(require)
    function Trig_ST8mInit_Func005A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST8)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_ST8mInit_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_TempUnit = gg_unit_h04F_0260
        udg_TempUnit2 = gg_unit_h04E_0259
        GenConsole(udg_TempUnit, udg_TempUnit2, gg_rct_ST8Control)
        ForForce(GetPlayersAll(), Trig_ST8mInit_Func005A)
    end

    --===========================================================================
    gg_trg_ST8mInit = CreateTrigger()
    TriggerAddAction(gg_trg_ST8mInit, Trig_ST8mInit_Actions)
end)
if Debug then Debug.endFile() end
