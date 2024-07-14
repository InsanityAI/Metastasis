//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Untitled_Trigger_002_Actions takes nothing returns nothing
    call DisplayTextToForce( GetPlayersAll(), "Dock Location of raptor #1 " + I2S(udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0041)]))
    call DisplayTextToForce( GetPlayersAll(), "Dock Location of raptor #2 " + I2S(udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0043)]))
    call DisplayTextToForce( GetPlayersAll(), "Dock Location of raptor #4 " + I2S(udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0042)]))
    
    call DisplayTextToForce( GetPlayersAll(), "Unit Value of raptor #1 landed " + I2S(GetUnitUserData(gg_unit_h001_0041)))
    call DisplayTextToForce( GetPlayersAll(), "Unit Value of raptor #2 landed" + I2S(GetUnitUserData(gg_unit_h001_0043)))
    call DisplayTextToForce( GetPlayersAll(), "Unit Value of raptor #4 landed" + I2S(GetUnitUserData(gg_unit_h001_0042)))
    
    call DisplayTextToForce( GetPlayersAll(), "Unit Value of raptor #1 space" + I2S(GetUnitUserData(gg_unit_h002_0020)))
    call DisplayTextToForce( GetPlayersAll(), "Unit Value of raptor #2 space" + I2S(GetUnitUserData(gg_unit_h002_0021)))
    call DisplayTextToForce( GetPlayersAll(), "Unit Value of raptor #4 space" + I2S(GetUnitUserData(gg_unit_h002_0046)))
endfunction

//===========================================================================
function InitTrig_SS_Test takes nothing returns nothing
    set gg_trg_SS_Test = CreateTrigger(  )
    call TriggerRegisterPlayerKeyEventBJ( gg_trg_SS_Test, Player(0), bj_KEYEVENTTYPE_DEPRESS, bj_KEYEVENTKEY_LEFT )
    call TriggerAddAction( gg_trg_SS_Test, function Trig_Untitled_Trigger_002_Actions )
endfunction

