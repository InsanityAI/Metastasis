library Dockable initializer init requires Table
    globals
        private Table dockMap // table<destructable, IDockable>
    endglobals

    interface IDockable
        method defineDock takes destructable dock returns nothing
        method hasAvailableDock takes nothing returns boolean
        method getAvailableDock takes nothing returns destructable
    endinterface

    module Dockable
        private Table docks = Table.create() //table<destructable, isOccupied(boolean)>
        private Table availableDocks = Table.create() //table<destructable, true>

        method defineDock takes destructable dock returns nothing
            this.docks.boolean.store(dock, false)
            call dockMap.store(dock, this)
            call ChangeElevatorWalls(true, bj_ELEVATOR_WALL_TYPE_ALL, dock) 
        endmethod
    endmodule

    private function init takes nothing returns nothing
        set dockMap = Table.create()
    endfunction

endlibrary