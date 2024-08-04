function Trig_SSInit_InitPlayerVisibility takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS1 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS2 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS3 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS4 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS7 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS8 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS9 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS10 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_SS11 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_SSInit_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_TempUnit = gg_unit_h001_0042
    set udg_TempUnit2 = gg_unit_h002_0046
    set udg_TempUnit3 = gg_unit_h004_0048
    set udg_TempRect = gg_rct_SS4
    set udg_TempRect2 = gg_rct_SS4EE
    set udg_TempRect3 = gg_rct_SS4Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0042)] = gg_unit_h009_0029
    set udg_All_Dock_Filled[14] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0042)] = 14
    set udg_TempInt = 12
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0041
    set udg_TempUnit2 = gg_unit_h002_0020
    set udg_TempUnit3 = gg_unit_h004_0023
    set udg_TempRect = gg_rct_SS1
    set udg_TempRect2 = gg_rct_SS1EE
    set udg_TempRect3 = gg_rct_SS1Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0041)] = gg_unit_h009_0029
    set udg_All_Dock_Filled[9] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0041)] = 9
    set udg_TempInt = 9
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0043
    set udg_TempUnit2 = gg_unit_h002_0021
    set udg_TempUnit3 = gg_unit_h004_0019
    set udg_TempRect = gg_rct_SS2
    set udg_TempRect2 = gg_rct_SS2EE
    set udg_TempRect3 = gg_rct_SS2Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0043)] = gg_unit_h009_0029
    set udg_All_Dock_Filled[12] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0043)] = 12
    set udg_TempInt = 10
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0044
    set udg_TempUnit2 = gg_unit_h002_0045
    set udg_TempUnit3 = gg_unit_h004_0047
    set udg_TempRect = gg_rct_SS3
    set udg_TempRect2 = gg_rct_SS3EE
    set udg_TempRect3 = gg_rct_SS3Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0044)] = gg_unit_h009_0029
    set udg_All_Dock_Filled[16] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0044)] = 16
    set udg_TempInt = 11
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0016
    set udg_TempUnit2 = gg_unit_h002_0138
    set udg_TempUnit3 = gg_unit_h004_0156
    set udg_TempRect = gg_rct_SS5
    set udg_TempRect2 = gg_rct_SS5EE
    set udg_TempRect3 = gg_rct_SS5Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0016)] = gg_unit_h003_0018
    set udg_All_Dock_Filled[1] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0016)] = 1
    set udg_TempInt = 13
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0002
    set udg_TempUnit2 = gg_unit_h002_0153
    set udg_TempUnit3 = gg_unit_h004_0157
    set udg_TempRect = gg_rct_SS6
    set udg_TempRect2 = gg_rct_SS6EE
    set udg_TempRect3 = gg_rct_SS6Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0002)] = gg_unit_h003_0018
    set udg_All_Dock_Filled[4] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0002)] = 4
    set udg_TempInt = 14
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0163
    set udg_TempUnit2 = gg_unit_h002_0158
    set udg_TempUnit3 = gg_unit_h004_0160
    set udg_TempRect = gg_rct_SS7
    set udg_TempRect2 = gg_rct_SS7EE
    set udg_TempRect3 = gg_rct_SS7Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0163)] = gg_unit_h00X_0049
    set udg_All_Dock_Filled[17] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0163)] = 17
    set udg_TempInt = 15
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h001_0162
    set udg_TempUnit2 = gg_unit_h002_0159
    set udg_TempUnit3 = gg_unit_h004_0161
    set udg_TempRect = gg_rct_SS8
    set udg_TempRect2 = gg_rct_SS8EE
    set udg_TempRect3 = gg_rct_SS8Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h001_0162)] = gg_unit_h00X_0049
    set udg_All_Dock_Filled[19] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h001_0162)] = 19
    set udg_TempInt = 16
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h02I_0183
    set udg_TempUnit2 = gg_unit_h02H_0198
    set udg_TempUnit3 = gg_unit_h004_0199
    set udg_TempRect = gg_rct_SS9
    set udg_TempRect2 = gg_rct_SS9EE
    set udg_TempRect3 = gg_rct_SS9Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h02I_0183)] = gg_unit_h008_0196
    set udg_All_Dock_Filled[36] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02I_0183)] = 36
    set udg_TempInt = 17
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h02K_0203
    set udg_TempUnit2 = gg_unit_h02L_0205
    set udg_TempUnit3 = gg_unit_h004_0221
    set udg_TempRect = gg_rct_SS10
    set udg_TempRect2 = gg_rct_SS10EE
    set udg_TempRect3 = gg_rct_SS10Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h02K_0203)] = gg_unit_h009_0029
    set udg_All_Dock_Filled[29] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02K_0203)] = 29
    set udg_TempInt = 18
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h02K_0204
    set udg_TempUnit2 = gg_unit_h02L_0202
    set udg_TempUnit3 = gg_unit_h004_0206
    set udg_TempRect = gg_rct_SS11
    set udg_TempRect2 = gg_rct_SS11EE
    set udg_TempRect3 = gg_rct_SS11Control
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h02K_0204)] = gg_unit_h009_0029
    set udg_All_Dock_Filled[33] = true
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h02K_0204)] = 33
    set udg_TempInt = 19
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h04E_0259
    set udg_TempUnit2 = gg_unit_h04E_0259
    set udg_TempUnit3 = null
    set udg_TempRect = null
    set udg_TempRect2 = gg_rct_ST8EE
    set udg_TempRect3 = null
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h04E_0259)] = null
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h04E_0259)] = 0
    set udg_TempInt = 23
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    set udg_TempUnit = gg_unit_h04V_0253
    set udg_TempUnit2 = gg_unit_h04V_0253
    set udg_TempUnit3 = null
    set udg_TempRect = null
    set udg_TempRect2 = gg_rct_ST10EE
    set udg_TempRect3 = null
    set udg_SS_Harbor[GetUnitUserData(gg_unit_h04V_0253)] = null
    set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h04V_0253)] = 0
    set udg_TempInt = 25
    call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,udg_TempInt)
    call ForForce(GetPlayersAll(), function Trig_SSInit_InitPlayerVisibility)
endfunction

//===========================================================================
function InitTrig_SSInit takes nothing returns nothing
    set gg_trg_SSInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_SSInit, function Trig_SSInit_Actions )
endfunction

