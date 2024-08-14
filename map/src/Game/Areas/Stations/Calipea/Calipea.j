library Calipea requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = BoardableStation.create() 
        call gameSpace.addRect(gg_rct_ST8) 
        call station.addGameStation(gameSpace)

        set udg_TempUnit = gg_unit_h04F_0260
        set udg_TempUnit2 = gg_unit_h04E_0259
        call GenConsole(udg_TempUnit,udg_TempUnit2,gg_rct_ST8Control)

        call station.initialize() 
        return station 
    endfunction 
endlibrary
