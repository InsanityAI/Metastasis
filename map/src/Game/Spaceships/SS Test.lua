if Debug then Debug.beginFile "Game/Spaceships/SSTest" end
OnInit.map("SSTest", function(require)
    function Trig_Untitled_Trigger_002_Actions()
        DisplayTextToForce(GetPlayersAll(),
            "Dock Location of raptor #1 " + I2S(udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0041)]))
        DisplayTextToForce(GetPlayersAll(),
            "Dock Location of raptor #2 " + I2S(udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0043)]))
        DisplayTextToForce(GetPlayersAll(),
            "Dock Location of raptor #4 " + I2S(udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0042)]))

        DisplayTextToForce(GetPlayersAll(), "Unit Value of raptor #1 landed " + I2S(GetUnitUserData(gg_unit_h001_0041)))
        DisplayTextToForce(GetPlayersAll(), "Unit Value of raptor #2 landed" + I2S(GetUnitUserData(gg_unit_h001_0043)))
        DisplayTextToForce(GetPlayersAll(), "Unit Value of raptor #4 landed" + I2S(GetUnitUserData(gg_unit_h001_0042)))

        DisplayTextToForce(GetPlayersAll(), "Unit Value of raptor #1 space" + I2S(GetUnitUserData(gg_unit_h002_0020)))
        DisplayTextToForce(GetPlayersAll(), "Unit Value of raptor #2 space" + I2S(GetUnitUserData(gg_unit_h002_0021)))
        DisplayTextToForce(GetPlayersAll(), "Unit Value of raptor #4 space" + I2S(GetUnitUserData(gg_unit_h002_0046)))
    end

    --===========================================================================
    -- fuck your tests
    -- gg_trg_SS_Test = CreateTrigger()
    -- TriggerRegisterPlayerKeyEventBJ(gg_trg_SS_Test, Player(0), bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_LEFT)
    -- TriggerAddAction(gg_trg_SS_Test, Trig_Untitled_Trigger_002_Actions)
end)
if Debug then Debug.endFile() end
