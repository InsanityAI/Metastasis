library Overlord requires Station, SimpleGameSpace
    globals 
        public Station station 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create()
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_ST11V1) 
        call gameSpace.addRect(gg_rct_ST11V10) 
        call gameSpace.addRect(gg_rct_ST11V11) 
        call gameSpace.addRect(gg_rct_ST11V12) 
        call gameSpace.addRect(gg_rct_ST11V13) 
        call gameSpace.addRect(gg_rct_ST11V14) 
        call gameSpace.addRect(gg_rct_ST11V15) 
        call gameSpace.addRect(gg_rct_ST11V16) 
        call gameSpace.addRect(gg_rct_ST11V17) 
        call gameSpace.addRect(gg_rct_ST11V18) 
        call gameSpace.addRect(gg_rct_ST11V19) 
        call gameSpace.addRect(gg_rct_ST11V2) 
        call gameSpace.addRect(gg_rct_ST11V20) 
        call gameSpace.addRect(gg_rct_ST11V21) 
        call gameSpace.addRect(gg_rct_ST11V22) 
        call gameSpace.addRect(gg_rct_ST11V23) 
        call gameSpace.addRect(gg_rct_ST11V24) 
        call gameSpace.addRect(gg_rct_ST11V3) 
        call gameSpace.addRect(gg_rct_ST11V4) 
        call gameSpace.addRect(gg_rct_ST11V5) 
        call gameSpace.addRect(gg_rct_ST11V6) 
        call gameSpace.addRect(gg_rct_ST11V7) 
        call gameSpace.addRect(gg_rct_ST11V8) 
        call gameSpace.addRect(gg_rct_ST11V9) 
        call station.addGameSpace(gameSpace)

        call EnableTrigger(gg_trg_ST11BloodEffect) 
        call EnableTrigger(gg_trg_ST11HivesDie) 
        call EnableTrigger(gg_trg_ST11DieNatural) 
        set udg_Sector_Space[27] = GetLastCreatedUnit() //expecting overlord?? 
        set udg_SectorId[27] = gg_rct_OverlordRect 

        call station.addDock(gg_dest_B009_5548) 
        call station.addDock(gg_dest_B009_5547) 
        call station.addDock(gg_dest_B009_5543) 
        call station.addDock(gg_dest_B009_5542) 
        call station.addDock(gg_dest_B009_5540) 

        set udg_TempUnit = GetLastCreatedUnit() 
        call GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup) 
        call NewUnitRegister(udg_TempUnit) 
        set udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 150.00 
    
        call PlaySoundBJ(gg_snd_SargerasRoar02) 
        call UnitRemoveAbilityBJ('Avul', gg_unit_h04X_0172) 
        call UnitRemoveAbilityBJ('Avul', gg_unit_h04X_0148) 
        call UnitRemoveAbilityBJ('Avul', gg_unit_h04X_0173) 


        //todo: silence damage!!
        call station.initialize() 
        return station 
    endfunction 
endlibrary 
