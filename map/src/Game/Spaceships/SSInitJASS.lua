if Debug then Debug.beginFile "Game/Spaceships/SSInitJASS" end
OnInit.map("SSInitJASS", function(require)
    function Trig_SSInit_Copy_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        SetUnitTimeScalePercent(gg_unit_h00X_0049, 15.00)
        SetUnitTimeScalePercent(gg_unit_h008_0196, 15.00)
        udg_TempUnit = gg_unit_h001_0042
        udg_TempUnit2 = gg_unit_h002_0046
        udg_TempUnit3 = gg_unit_h004_0048
        udg_TempRect = gg_rct_SS4
        udg_TempRect2 = gg_rct_SS4EE
        udg_TempRect3 = gg_rct_SS4Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0042)] = gg_unit_h009_0029
        udg_All_Dock_Filled[14] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0042)] = 14
        udg_TempInt = 12
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0041
        udg_TempUnit2 = gg_unit_h002_0020
        udg_TempUnit3 = gg_unit_h004_0023
        udg_TempRect = gg_rct_SS1
        udg_TempRect2 = gg_rct_SS1EE
        udg_TempRect3 = gg_rct_SS1Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0041)] = gg_unit_h009_0029
        udg_All_Dock_Filled[9] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0041)] = 9
        udg_TempInt = 9
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0043
        udg_TempUnit2 = gg_unit_h002_0021
        udg_TempUnit3 = gg_unit_h004_0019
        udg_TempRect = gg_rct_SS2
        udg_TempRect2 = gg_rct_SS2EE
        udg_TempRect3 = gg_rct_SS2Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0043)] = gg_unit_h009_0029
        udg_All_Dock_Filled[12] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0043)] = 12
        udg_TempInt = 10
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0044
        udg_TempUnit2 = gg_unit_h002_0045
        udg_TempUnit3 = gg_unit_h004_0047
        udg_TempRect = gg_rct_SS3
        udg_TempRect2 = gg_rct_SS3EE
        udg_TempRect3 = gg_rct_SS3Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0044)] = gg_unit_h009_0029
        udg_All_Dock_Filled[16] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0044)] = 16
        udg_TempInt = 11
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0016
        udg_TempUnit2 = gg_unit_h002_0138
        udg_TempUnit3 = gg_unit_h004_0156
        udg_TempRect = gg_rct_SS5
        udg_TempRect2 = gg_rct_SS5EE
        udg_TempRect3 = gg_rct_SS5Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0016)] = gg_unit_h003_0018
        udg_All_Dock_Filled[1] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0016)] = 1
        udg_TempInt = 13
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0002
        udg_TempUnit2 = gg_unit_h002_0153
        udg_TempUnit3 = gg_unit_h004_0157
        udg_TempRect = gg_rct_SS6
        udg_TempRect2 = gg_rct_SS6EE
        udg_TempRect3 = gg_rct_SS6Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0002)] = gg_unit_h003_0018
        udg_All_Dock_Filled[4] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0002)] = 4
        udg_TempInt = 14
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0163
        udg_TempUnit2 = gg_unit_h002_0158
        udg_TempUnit3 = gg_unit_h004_0160
        udg_TempRect = gg_rct_SS7
        udg_TempRect2 = gg_rct_SS7EE
        udg_TempRect3 = gg_rct_SS7Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0163)] = gg_unit_h00X_0049
        udg_All_Dock_Filled[17] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0163)] = 17
        udg_TempInt = 15
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h001_0162
        udg_TempUnit2 = gg_unit_h002_0159
        udg_TempUnit3 = gg_unit_h004_0161
        udg_TempRect = gg_rct_SS8
        udg_TempRect2 = gg_rct_SS8EE
        udg_TempRect3 = gg_rct_SS8Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0162)] = gg_unit_h00X_0049
        udg_All_Dock_Filled[19] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0162)] = 19
        udg_TempInt = 16
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h02I_0183
        udg_TempUnit2 = gg_unit_h02H_0198
        udg_TempUnit3 = gg_unit_h004_0199
        udg_TempRect = gg_rct_SS9
        udg_TempRect2 = gg_rct_SS9EE
        udg_TempRect3 = gg_rct_SS9Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h02I_0183)] = gg_unit_h008_0196
        udg_All_Dock_Filled[36] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02I_0183)] = 36
        udg_TempInt = 17
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h02K_0203
        udg_TempUnit2 = gg_unit_h02L_0205
        udg_TempUnit3 = gg_unit_h004_0221
        udg_TempRect = gg_rct_SS10
        udg_TempRect2 = gg_rct_SS10EE
        udg_TempRect3 = gg_rct_SS10Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h02K_0203)] = gg_unit_h009_0029
        udg_All_Dock_Filled[29] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02K_0203)] = 29
        udg_TempInt = 18
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h02K_0204
        udg_TempUnit2 = gg_unit_h02L_0202
        udg_TempUnit3 = gg_unit_h004_0206
        udg_TempRect = gg_rct_SS11
        udg_TempRect2 = gg_rct_SS11EE
        udg_TempRect3 = gg_rct_SS11Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h02K_0204)] = gg_unit_h009_0029
        udg_All_Dock_Filled[33] = true
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02K_0204)] = 33
        udg_TempInt = 19
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h02S_0215
        udg_TempUnit2 = gg_unit_h02Q_0212
        udg_TempUnit3 = gg_unit_h004_0213
        udg_TempRect = gg_rct_SS12
        udg_TempRect2 = gg_rct_SS12EE
        udg_TempRect3 = gg_rct_SS12Control
        udg_SS_Harbor[GetUnitUserData(gg_unit_h02S_0215)] = nil
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02S_0215)] = 0
        udg_TempInt = 20
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h04E_0259
        udg_TempUnit2 = gg_unit_h04E_0259
        udg_TempUnit3 = nil
        udg_TempRect = nil
        udg_TempRect2 = gg_rct_ST8EE
        udg_TempRect3 = nil
        udg_SS_Harbor[GetUnitUserData(gg_unit_h04E_0259)] = nil
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h04E_0259)] = 0
        udg_TempInt = 23
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
        udg_TempUnit = gg_unit_h04V_0253
        udg_TempUnit2 = gg_unit_h04V_0253
        udg_TempUnit3 = nil
        udg_TempRect = nil
        udg_TempRect2 = gg_rct_ST10EE
        udg_TempRect3 = nil
        udg_SS_Harbor[GetUnitUserData(gg_unit_h04V_0253)] = nil
        udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h04V_0253)] = 0
        udg_TempInt = 25
        Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,
            udg_TempInt)
    end

    --===========================================================================
    gg_trg_SSInitJASS = CreateTrigger()
    TriggerAddAction(gg_trg_SSInitJASS, Trig_SSInit_Copy_Actions)
end)
if Debug then Debug.endFile() end
