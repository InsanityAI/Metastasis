function Trig_LostStation_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[2] = true
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1332" )
    set udg_TempPoint = GetRandomLocInRect(gg_rct_SpaceSound)
    call PingMinimapLocForForce( GetPlayersAll(), udg_TempPoint, 15.00 )
    call SetUnitPositionLoc( gg_unit_h029_0114, udg_TempPoint )
    call RemoveLocation(udg_TempPoint)
    call StartTimerBJ( udg_LostStation_Disappear, false, 397.00 )
    call CreateTimerDialogBJ( GetLastCreatedTimerBJ(), "TRIGSTR_1333" )
    set udg_LostStation_TimerWindow = GetLastCreatedTimerDialogBJ()
    call EnableTrigger( gg_trg_LostStationDisappear )
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(90.00, 900.00) )
endfunction

//===========================================================================
function InitTrig_LostStation takes nothing returns nothing
    set gg_trg_LostStation = CreateTrigger(  )
    call DisableTrigger( gg_trg_LostStation )
    call TriggerAddAction( gg_trg_LostStation, function Trig_LostStation_Actions )
endfunction

