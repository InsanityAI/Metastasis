if Debug then Debug.beginFile "Game/Stations/ST10/ST10Init" end
OnInit.trig("ST10Init", function(require)
    function Trig_ST10Init_Func002A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST10V1)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    function Trig_ST10Init_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        ForForce(GetPlayersAll(), Trig_ST10Init_Func002A)
        udg_TempUnit = gg_unit_h04U_0252
        udg_TempUnit2 = gg_unit_h04V_0253
        GenConsole(udg_TempUnit, udg_TempUnit2, gg_rct_ST10Control)
    end

    --===========================================================================
    gg_trg_ST10Init = CreateTrigger()
    TriggerAddAction(gg_trg_ST10Init, Trig_ST10Init_Actions)
end)
if Debug then Debug.endFile() end
