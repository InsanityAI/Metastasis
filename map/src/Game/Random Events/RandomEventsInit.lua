if Debug then Debug.beginFile "Game/RandomEvents/RandomEventsInit" end
OnInit.trig("RandomEventsInit", function(require)
    DestroyTrigger(GetTriggeringTrigger())
    udg_RandomEvent_Trigger[1] = gg_trg_CommissarPromotion
    udg_RandomEvent_Trigger[2] = gg_trg_LostStation
    --udg_RandomEvent_Trigger[3] = gg_trg_SlugglyInfestation
    udg_RandomEvent_Trigger[3] = gg_trg_FakeGameEnd
    udg_RandomEvent_Trigger[4] = gg_trg_PirateShip
    udg_RandomEvent_Trigger[5] = gg_trg_Snoeglays
    udg_RandomEvent_Trigger[6] = gg_trg_Anomaly
    udg_RandomEvent_Trigger[7] = gg_trg_News
    udg_RandomEvent_Trigger[8] = gg_trg_PersonnelUpgrade
    udg_RandomEvent_Trigger[9] = gg_trg_DroneSwarm
    udg_RandomEvent_Trigger[10] = gg_trg_SolarIntensity
    udg_RandomEvent_Trigger[11] = gg_trg_DoorMalfunction
    udg_RandomEvent_Trigger[12] = gg_trg_GiantAsteroid
    udg_RandomEvent_Trigger[13] = gg_trg_LocalBlackout
    udg_RandomEvent_Trigger[14] = gg_trg_MultiEvent

    udg_Apocalypse_Trigger[1] = gg_trg_USIBattleFleet
    udg_Apocalypse_Trigger[2] = gg_trg_BlackHole
    StartTimerBJ(udg_RandomEvent, false, GetRandomReal(180.00, 720.00))
    PolledWait(5.00)
    DialogSetMessageBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1395")
    DialogAddButtonBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1397")
    DialogAddButtonBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1398")
    udg_PersonnelUpgradeDialog_Button[1] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1399")
    udg_PersonnelUpgradeDialog_Button[2] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1400")
    udg_PersonnelUpgradeDialog_Button[3] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1401")
    udg_PersonnelUpgradeDialog_Button[4] = GetLastCreatedButtonBJ()
    DialogAddButtonBJ(udg_PersonnelUpgradeDialog, "TRIGSTR_1402")
    udg_PersonnelUpgradeDialog_Button[5] = GetLastCreatedButtonBJ()
    udg_PersonnelUpgrade_Research[1] = FourCC('R001')
    udg_PersonnelUpgrade_Research[2] = FourCC('R002')
    udg_PersonnelUpgrade_Research[3] = FourCC('R003')
    udg_PersonnelUpgrade_Research[4] = FourCC('R004')
    udg_PersonnelUpgrade_Research[5] = FourCC('R005')
end)
if Debug then Debug.endFile() end
