library UFO requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    private function MakeScientistAppearDeadEnum takes nothing returns nothing
        call SetUnitAnimation( GetEnumUnit(), "death" )
    endfunction

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace ufoSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call ufoSpace.addRect(gg_rct_LostStation) 
        call station.addGameSpace(ufoSpace)

        call station.addDock(gg_dest_DTrx_9308) 
        call station.addDock(gg_dest_DTrx_9425) 

        set bj_wantDestroyGroup = true
        call ForGroupBJ( GetUnitsInRectAll(gg_rct_LostStation), function MakeScientistAppearDeadEnum )

        call station.initialize() 
        return station 
    endfunction 
endlibrary