library Syllus requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    private function LockDoor takes nothing returns nothing 
        set udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1")) 
        call DisableTrigger(udg_TempTrigger) 
        set udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2")) 
        set udg_TempDoorHack = true 
        call TriggerExecute(udg_TempTrigger) 
        set udg_TempDoorHack = false 
        call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")), 999999, true) 
    endfunction 

    private function GiveAI takes nothing returns nothing 
        call BasicAI(GetEnumUnit(), 300, 1000.0) 
    endfunction 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_ST9V1) 
        call gameSpace.addRect(gg_rct_ST9V2) 
        call gameSpace.addRect(gg_rct_ST9V3) 
        call gameSpace.addRect(gg_rct_ST9V4) 
        call gameSpace.addRect(gg_rct_ST9V5) 
        call gameSpace.addRect(gg_rct_ST9V6) 
        call gameSpace.addRect(gg_rct_ST9V7) 
        call gameSpace.addRect(gg_rct_ST9V8) 
        call gameSpace.addRect(gg_rct_Cage1) 
        call gameSpace.addRect(gg_rct_Cage2) 
        call gameSpace.addRect(gg_rct_Cage3) 
        call gameSpace.addRect(gg_rct_Cage4) 
        call gameSpace.addRect(gg_rct_Cage5) 
        call gameSpace.addRect(gg_rct_Cage6) 
        call station.addGameSpace(gameSpace)

        call station.addDock(gg_dest_DTrx_7022) 
        call station.addDock(gg_dest_DTrx_7025) 
        call station.addDock(gg_dest_DTrx_7023) 
        call station.addDock(gg_dest_DTrx_7024) 
        call station.addDock(gg_dest_DTrx_7020) 
        call station.addDock(gg_dest_DTrx_7021) 

        set bj_wantDestroyGroup = true 
        call ForGroupBJ(GetUnitsInRectAll(gg_rct_Cage5), function GiveAI) 

        set udg_TempUnit = gg_unit_h04P_0266 
        call BasicAI_Murmusk(udg_TempUnit, 160, 700.0) 

        call EnumDestructablesInRectAll(gg_rct_ST9, function LockDoor) 

        set udg_TempUnit = gg_unit_h04I_0012 
        call GenConsole(udg_TempUnit, udg_TempUnit, gg_rct_ST9Control) 
        set udg_TempUnit = gg_unit_h04R_0258 
        call GenConsole(udg_TempUnit, udg_TempUnit, gg_rct_ST9Control2) 

        call station.initialize() 
        return station 
    endfunction 
endlibrary 
