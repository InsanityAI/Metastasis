function Trig_GetSectorInit_Actions takes nothing returns nothing
       call DestroyTrigger( GetTriggeringTrigger() )
    set udg_SectorId[1] = gg_rct_ST1
    set udg_SectorId[2] = gg_rct_ST2
    set udg_SectorId[3] = gg_rct_ST3
    set udg_SectorId[4] = gg_rct_ST4S2
    set udg_SectorId[5] = gg_rct_ST5
    set udg_SectorId[6] = gg_rct_LostStation
    set udg_SectorId[7] = gg_rct_PirateShip
    set udg_SectorId[8] = gg_rct_Planet
    set udg_SectorId[9] = gg_rct_SS1
    set udg_SectorId[10] = gg_rct_SS2
    set udg_SectorId[11] = gg_rct_SS3
    set udg_SectorId[12] = gg_rct_SS4
    set udg_SectorId[13] = gg_rct_SS5
    set udg_SectorId[14] = gg_rct_SS6
    set udg_SectorId[15] = gg_rct_SS7
    set udg_SectorId[16] = gg_rct_SS8
    set udg_SectorId[17] = gg_rct_SS9
    set udg_SectorId[18] = gg_rct_SS10
    set udg_SectorId[19] = gg_rct_SS11
    set udg_SectorId[20] = gg_rct_SS12
    set udg_SectorId[21] = gg_rct_Space
    set udg_SectorId[22] = gg_rct_MoonRect
    set udg_SectorId[23] = gg_rct_ST8
    set udg_SectorId[24] = gg_rct_ST9
    set udg_SectorId[25] = gg_rct_ST10
    set udg_SectorId[28] = gg_rct_Mirror_Arena
endfunction

//===========================================================================
function InitTrig_GetSectorInit takes nothing returns nothing
    set gg_trg_GetSectorInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_GetSectorInit, function Trig_GetSectorInit_Actions )
endfunction

