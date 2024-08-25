library PirateShip initializer init requires Station, SimpleGameSpace, Timeout 
    globals 
        public Station station 
        private trigger pirateShipConsoleDeath 
        private timerdialog pirateShipExplosionTimerDialog 
    endglobals 

    public function Initialize takes nothing returns Station 
        local SimpleGameSpace gameSpace = SimpleGameSpace.create() 
        set station = DockableStation.create() 
        call gameSpace.addRect(gg_rct_PirateShip) 
        call station.addGameSpace(gameSpace) 

        call station.addDock(gg_dest_DTrx_9311) 
        call station.addDock(gg_dest_DTrx_9316) 
        call station.addDock(gg_dest_DTrx_2150) 
        call station.addDock(gg_dest_DTrx_2156) 

        call station.initialize() 
        return station 
    endfunction 

    private function pirateShipDeath takes nothing returns nothing 
        call KillUnit(station)
    endfunction 

    private function consoleDeath takes nothing returns boolean 
        local Table timerData = Timeout.start(40.00, false, function pirateShipDeath) 
        set pirateShipExplosionTimerDialog = CreateTimerDialog(Timeout.getTimer(timerData)) 
        call TimerDialogSetTitle(pirateShipExplosionTimerDialog, "Pirate Ship Explodes") 
        call DisplayTextToForce(GetPlayersAll(), "|cffFF0000ERROR: 00000000xc1202nsiisd9999932u3bjazjlss\nBeginning self destruction sequence.|r") 
        return true 
    endfunction 

    private function init takes nothing returns nothing 
        set pirateShipConsoleDeath = CreateTrigger() 
        call TriggerRegisterUnitEvent(pirateShipConsoleDeath, gg_unit_h02A_0115, EVENT_UNIT_DEATH) 
        call TriggerAddCondition(pirateShipConsoleDeath, Condition(function consoleDeath)) 
    endfunction 
endlibrary