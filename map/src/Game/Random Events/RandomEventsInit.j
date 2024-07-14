function Trig_RandomEventsInit_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_Trigger[1] = gg_trg_CommissarPromotion
    set udg_RandomEvent_Trigger[2] = gg_trg_LostStation
    set udg_RandomEvent_Trigger[3] = gg_trg_SlugglyInfestation
    set udg_RandomEvent_Trigger[4] = gg_trg_PirateShip
    set udg_RandomEvent_Trigger[5] = gg_trg_Snoeglays
    set udg_RandomEvent_Trigger[6] = gg_trg_Anomaly
    set udg_RandomEvent_Trigger[7] = gg_trg_News
    set udg_RandomEvent_Trigger[8] = gg_trg_PersonnelUpgrade
    set udg_RandomEvent_Trigger[9] = gg_trg_DroneSwarm
    set udg_RandomEvent_Trigger[10] = gg_trg_SolarIntensity
    set udg_RandomEvent_Trigger[11] = gg_trg_DoorMalfunction
    set udg_RandomEvent_Trigger[12] = gg_trg_GiantAsteroid
    set udg_RandomEvent_Trigger[13] = gg_trg_LocalBlackout
    set udg_RandomEvent_Trigger[14] = gg_trg_MultiEvent
    set udg_RandomEvent_Trigger[15] = gg_trg_FakeGameEnd
    set udg_Apocalypse_Trigger[1] = gg_trg_USIBattleFleet
    set udg_Apocalypse_Trigger[2] = gg_trg_BlackHole
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(180.00, 720.00) )
    call PolledWait( 5.00 )
    call DialogSetMessageBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1395" )
    call DialogAddButtonBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1397" )
    call DialogAddButtonBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1398" )
    set udg_PersonnelUpgradeDialog_Button[1] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1399" )
    set udg_PersonnelUpgradeDialog_Button[2] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1400" )
    set udg_PersonnelUpgradeDialog_Button[3] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1401" )
    set udg_PersonnelUpgradeDialog_Button[4] = GetLastCreatedButtonBJ()
    call DialogAddButtonBJ( udg_PersonnelUpgradeDialog, "TRIGSTR_1402" )
    set udg_PersonnelUpgradeDialog_Button[5] = GetLastCreatedButtonBJ()
    set udg_PersonnelUpgrade_Research[1] = 'R001'
    set udg_PersonnelUpgrade_Research[2] = 'R002'
    set udg_PersonnelUpgrade_Research[3] = 'R003'
    set udg_PersonnelUpgrade_Research[4] = 'R004'
    set udg_PersonnelUpgrade_Research[5] = 'R005'
endfunction

//===========================================================================
function InitTrig_RandomEventsInit takes nothing returns nothing
    set gg_trg_RandomEventsInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_RandomEventsInit, function Trig_RandomEventsInit_Actions )
endfunction

