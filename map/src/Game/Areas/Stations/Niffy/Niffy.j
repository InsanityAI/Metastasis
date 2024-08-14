library Niffy requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_ST4V1) 
        call gameSpace.addRect(gg_rct_ST4V10) 
        call gameSpace.addRect(gg_rct_ST4V11) 
        call gameSpace.addRect(gg_rct_ST4V15) 
        call gameSpace.addRect(gg_rct_ST4V18) 
        call gameSpace.addRect(gg_rct_ST4V2) 
        call gameSpace.addRect(gg_rct_ST4V24) 
        call gameSpace.addRect(gg_rct_ST4V25) 
        call gameSpace.addRect(gg_rct_ST4V3) 
        call gameSpace.addRect(gg_rct_ST4V30) 
        call gameSpace.addRect(gg_rct_ST4V31) 
        call gameSpace.addRect(gg_rct_ST4V32) 
        call gameSpace.addRect(gg_rct_ST4V33) 
        call gameSpace.addRect(gg_rct_ST4V4) 
        call gameSpace.addRect(gg_rct_ST4V5) 
        call gameSpace.addRect(gg_rct_ST4V7) 
        call gameSpace.addRect(gg_rct_ST4V8) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_1464) 
        call station.addDock(gg_dest_DTrx_1474) 
        call station.addDock(gg_dest_DTrx_1484) 
        call station.addDock(gg_dest_DTrx_1534) 
        call station.addDock(gg_dest_DTrx_1494) 
        call station.addDock(gg_dest_DTrx_1504) 
        call station.addDock(gg_dest_DTrx_1514) 
        call station.addDock(gg_dest_DTrx_1524) 
        call station.addDock(gg_dest_DTrx_2402) 
        call station.addDock(gg_dest_DTrx_2412) 
        call station.addDock(gg_dest_DTrx_2422) 
        call station.addDock(gg_dest_DTrx_2432) 
        call station.addDock(gg_dest_DTrx_2442) 

        //pacibot 
        call SetUnitTimeScalePercent(gg_unit_h04A_0144, 0.00) 
        call PauseUnit(gg_unit_h04A_0144, true) 

        call station.initialize() 
        return station 
    endfunction 
endlibrary