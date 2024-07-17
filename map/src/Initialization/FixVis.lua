if Debug then Debug.beginFile "Initialization/FixVis" end
OnInit.trig("FixVis", function(require)
    function Trig_FixVis_Func004A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_UnvisionNiffy)
        DestroyFogModifier(GetLastCreatedFogModifier())
    end

    ---@return boolean
    function Trig_FixVis_Func053C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_FixVis_Func054C()
        if (not (false == true)) then
            return false
        end
        return true
    end

    function Trig_FixVis_Actions()
        EnableTrigger(gg_trg_Rename)
        -- There's a bug where the center of the map, roughly above the Niffy docking bay, is partially visible which fudges up the minimap. This restores the black mask.
        ForForce(GetPlayersAll(), Trig_FixVis_Func004A)
        -- Also, initialize space things
        udg_Sector_Space[1] = gg_unit_h003_0018
        udg_Sector_Space[2] = gg_unit_h005_0024
        udg_Sector_Space[3] = gg_unit_h007_0027
        udg_Sector_Space[4] = gg_unit_h009_0029
        udg_Sector_Space[5] = gg_unit_h00X_0049
        udg_Sector_Space[6] = gg_unit_h029_0114
        udg_Sector_Space[7] = gg_unit_h02B_0116
        udg_Sector_Space[8] = gg_unit_h008_0196
        udg_Sector_Space[22] = gg_unit_h03T_0209
        udg_Sector_Space[23] = gg_unit_h04E_0259
        udg_Sector_Space[24] = gg_unit_h04T_0265
        udg_Sector_Space[25] = gg_unit_h04V_0253
        bj_forLoopAIndex = 9
        bj_forLoopAIndexEnd = 20
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_Sector_Space[GetForLoopIndexA()] = udg_SpaceshipID_Space[(GetForLoopIndexA() - 8)]
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        udg_Sector_Space[21] = nil
        udg_Sector_Space[22] = gg_unit_h03T_0209
        -- SpaceObject_Rect for spaceship/explorers is set in spaceship initialization.
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h009_0029)] = gg_rct_ST4S2
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h00X_0049)] = gg_rct_ST5
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h005_0024)] = gg_rct_ST2
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h003_0018)] = gg_rct_ST1
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h008_0196)] = gg_rct_Planet
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h007_0027)] = gg_rct_ST3
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h02B_0116)] = gg_rct_PirateShip
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h029_0114)] = gg_rct_LostStation
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h03T_0209)] = gg_rct_MoonRect
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h04E_0259)] = gg_rct_ST8
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h04T_0265)] = gg_rct_ST9
        udg_SpaceObject_Rect[GetUnitUserData(gg_unit_h04V_0253)] = gg_rct_ST10
        udg_ChatGroupStore = gg_trg_ChatGroupBroadcast
        -- Sluggly assassin init
        udg_SpaceObject_SlugglyAssassinX[1] = -11535.00
        udg_SpaceObject_SlugglyAssassinY[1] = 15200.00
        udg_SpaceObject_SlugglyAssassinX[2] = -6462.00
        udg_SpaceObject_SlugglyAssassinY[2] = 14482.00
        udg_SpaceObject_SlugglyAssassinX[3] = -11779.00
        udg_SpaceObject_SlugglyAssassinY[3] = 7644.00
        udg_SpaceObject_SlugglyAssassinX[4] = -11368.00
        udg_SpaceObject_SlugglyAssassinY[4] = -3219.00
        udg_SpaceObject_SlugglyAssassinX[5] = -10040.00
        udg_SpaceObject_SlugglyAssassinY[5] = -11242.00
        udg_SpaceObject_SlugglyAssassinX[8] = 7959.00
        udg_SpaceObject_SlugglyAssassinY[8] = 2551.00
        udg_SpaceObject_SlugglyAssassinX[22] = 12083.90
        udg_SpaceObject_SlugglyAssassinY[22] = -1733.00
        vendorDamage_init()
        DestroyTrigger(GetTriggeringTrigger())
        udg_TempBool = bj_isSinglePlayer == true
        if (Trig_FixVis_Func053C()) then
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4372")
        else
        end
        if (Trig_FixVis_Func054C()) then
            DestroyTrigger(gg_trg_Help)
            DestroyTrigger(gg_trg_SpawnHelp)
            DestroyTrigger(gg_trg_SpawnCodeGet)
            DestroyTrigger(gg_trg_AlienEvoPoints)
            DestroyTrigger(gg_trg_NoWin)
            DestroyTrigger(gg_trg_Mine)
            DestroyTrigger(gg_trg_Hostile)
            DestroyTrigger(gg_trg_ForceRandom)
            DestroyTrigger(gg_trg_SpawnUnit)
            DestroyTrigger(gg_trg_TestAbilities)
            DestroyTrigger(gg_trg_SetPlayerhero)
            DestroyTrigger(gg_trg_SpawnApocalypse)
        end
    end

    --===========================================================================
    gg_trg_FixVis = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_FixVis, 0.50)
    TriggerAddAction(gg_trg_FixVis, Trig_FixVis_Actions)
end)
if Debug then Debug.endFile() end
