library Minertha requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_Planet) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_1992) 
        call station.addDock(gg_dest_DTrx_1993) 
        call station.addDock(gg_dest_DTrx_1994) 
        call station.addDock(gg_dest_DTrx_1995) 
        call station.addDock(gg_dest_DTrx_1991) 
        call station.addDock(gg_dest_DTrx_1997) 
        call station.addDock(gg_dest_DTrx_1998) 
        call station.addDock(gg_dest_DTrx_1996) 

        set udg_PlanetRotatePoint = GetRectCenter(gg_rct_Space) 
        call SetUnitTimeScalePercent(gg_unit_h008_0196, 15.00) 

        call station.initialize() 
        return station 
    endfunction 
endlibrary