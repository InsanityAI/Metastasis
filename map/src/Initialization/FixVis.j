function Trig_FixVis_Func004A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_UnvisionNiffy )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_FixVis_Func053C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_FixVis_Func054C takes nothing returns boolean
    if ( not ( false == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_FixVis_Actions takes nothing returns nothing
    call EnableTrigger( gg_trg_Rename )
    // There's a bug where the center of the map, roughly above the Niffy docking bay, is partially visible which fudges up the minimap. This restores the black mask.
    call ForForce( GetPlayersAll(), function Trig_FixVis_Func004A )
    // Also, initialize space things
    set udg_Sector_Space[1] = gg_unit_h003_0018
    set udg_Sector_Space[2] = gg_unit_h005_0024
    set udg_Sector_Space[3] = gg_unit_h007_0027
    set udg_Sector_Space[4] = gg_unit_h009_0029
    set udg_Sector_Space[5] = gg_unit_h00X_0049
    set udg_Sector_Space[6] = gg_unit_h029_0114
    set udg_Sector_Space[7] = gg_unit_h02B_0116
    set udg_Sector_Space[8] = gg_unit_h008_0196
    set udg_Sector_Space[22] = gg_unit_h03T_0209
    set udg_Sector_Space[23] = gg_unit_h04E_0259
    set udg_Sector_Space[24] = gg_unit_h04T_0265
    set udg_Sector_Space[25] = gg_unit_h04V_0253
    set bj_forLoopAIndex = 9
    set bj_forLoopAIndexEnd = 20
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_Sector_Space[GetForLoopIndexA()] = udg_SpaceshipID_Space[( GetForLoopIndexA() - 8 )]
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set udg_Sector_Space[21] = null
    set udg_Sector_Space[22] = gg_unit_h03T_0209
    // SpaceObject_Rect for spaceship/explorers is set in spaceship initialization.
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h009_0029)] = gg_rct_ST4S2
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h00X_0049)] = gg_rct_ST5
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h005_0024)] = gg_rct_ST2
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h003_0018)] = gg_rct_ST1
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h008_0196)] = gg_rct_Planet
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h007_0027)] = gg_rct_ST3
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h02B_0116)] = gg_rct_PirateShip
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h029_0114)] = gg_rct_LostStation
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h03T_0209)] = gg_rct_MoonRect
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h04E_0259)] = gg_rct_ST8
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h04T_0265)] = gg_rct_ST9
    set udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h04V_0253)] = gg_rct_ST10
    set udg_ChatGroupStore = gg_trg_ChatGroupBroadcast
    // Sluggly assassin init
    set udg_SpaceObject_SlugglyAssassinX[1] = -11535.00
    set udg_SpaceObject_SlugglyAssassinY[1] = 15200.00
    set udg_SpaceObject_SlugglyAssassinX[2] = -6462.00
    set udg_SpaceObject_SlugglyAssassinY[2] = 14482.00
    set udg_SpaceObject_SlugglyAssassinX[3] = -11779.00
    set udg_SpaceObject_SlugglyAssassinY[3] = 7644.00
    set udg_SpaceObject_SlugglyAssassinX[4] = -11368.00
    set udg_SpaceObject_SlugglyAssassinY[4] = -3219.00
    set udg_SpaceObject_SlugglyAssassinX[5] = -10040.00
    set udg_SpaceObject_SlugglyAssassinY[5] = -11242.00
    set udg_SpaceObject_SlugglyAssassinX[8] = 7959.00
    set udg_SpaceObject_SlugglyAssassinY[8] = 2551.00
    set udg_SpaceObject_SlugglyAssassinX[22] = 12083.90
    set udg_SpaceObject_SlugglyAssassinY[22] = -1733.00
    call vendorDamage_init()
       call DestroyTrigger( GetTriggeringTrigger() )
    set udg_TempBool=bj_isSinglePlayer == true
    if ( Trig_FixVis_Func053C() ) then
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4372" )
    else
    endif
    if ( Trig_FixVis_Func054C() ) then
               call DestroyTrigger( gg_trg_Help )
                call DestroyTrigger( gg_trg_SpawnHelp )
                call DestroyTrigger( gg_trg_SpawnCodeGet )
                call DestroyTrigger( gg_trg_AlienEvoPoints )
                call DestroyTrigger( gg_trg_NoWin )
           call DestroyTrigger( gg_trg_Mine )
           call DestroyTrigger( gg_trg_Hostile )
                call DestroyTrigger( gg_trg_ForceRandom )
        call DestroyTrigger( gg_trg_SpawnUnit )
           call DestroyTrigger( gg_trg_TestAbilities )
           call DestroyTrigger( gg_trg_SetPlayerhero )
           call DestroyTrigger( gg_trg_SpawnApocalypse )
    else
    endif
endfunction

//===========================================================================
function InitTrig_FixVis takes nothing returns nothing
    set gg_trg_FixVis = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_FixVis, 0.50 )
    call TriggerAddAction( gg_trg_FixVis, function Trig_FixVis_Actions )
endfunction

