library Pown requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = BoardableStation.create() 
        call gameSpace.addRect(gg_rct_ST10V1) 
        call station.addGameSpace(gameSpace)

        set udg_TempUnit = gg_unit_h04U_0252 
        set udg_TempUnit2 = gg_unit_h04V_0253 
        call GenConsole(udg_TempUnit, udg_TempUnit2, gg_rct_ST10Control) 

        call station.initialize() 
        return station 
    endfunction 
endlibrary 
