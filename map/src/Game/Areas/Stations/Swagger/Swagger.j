library Swagger requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_ST5V1) 
        call gameSpace.addRect(gg_rct_ST5V10) 
        call gameSpace.addRect(gg_rct_ST5V11) 
        call gameSpace.addRect(gg_rct_ST5V12) 
        call gameSpace.addRect(gg_rct_ST5V13) 
        call gameSpace.addRect(gg_rct_ST5V2) 
        call gameSpace.addRect(gg_rct_ST5V3) 
        call gameSpace.addRect(gg_rct_ST5V4) 
        call gameSpace.addRect(gg_rct_ST5V5) 
        call gameSpace.addRect(gg_rct_ST5V6) 
        call gameSpace.addRect(gg_rct_ST5V7) 
        call gameSpace.addRect(gg_rct_ST5V8) 
        call gameSpace.addRect(gg_rct_ST5V9) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_6090) 
        call station.addDock(gg_dest_DTrx_6101) 
        call station.addDock(gg_dest_DTrx_6104) 
        call station.addDock(gg_dest_DTrx_6115) 
        call station.addDock(gg_dest_DTrx_2061) 
        call station.addDock(gg_dest_DTrx_2066) 

        //Swagger docked and space versions?
        call SetUnitTimeScalePercent( gg_unit_h03O_0208, 25.00 )
        call SetUnitTimeScalePercent( gg_unit_h00X_0049, 15.00 )
        call SetUnitVertexColorBJ( gg_unit_h03O_0208, 0.00, 0.00, 0.00, 100.00 )
        call SetUnitVertexColorBJ( gg_unit_e012_0074, 100.00, 100.00, 100.00, 100.00 )
        call SetUnitVertexColorBJ( gg_unit_e012_0092, 100.00, 100.00, 100.00, 100.00 )

        call station.initialize() 
        return station 
    endfunction 
endlibrary