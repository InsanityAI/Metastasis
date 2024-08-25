library CompositeGameSpace requires Table, GameSpace
    struct CompositeGameSpace extends GameSpace
        private Table spaces = Table.create() //table<GameSpace, boolean>

        public method addGameSpace takes GameSpace gameSpace returns nothing
            this.spaces.boolean[gameSpace] = true
        endmethod

        public method removeGameSpace takes GameSpace gameSpace returns nothing
            this.spaces.boolean.remove(gameSpace)
        endmethod

        method initialize takes nothing returns nothing
            local Table gameSpaces = this.spaces.getKeys()
            local GameSpace thisSpace
            local integer i = gameSpaces[0]
            loop
                exitwhen i == 0
                set thisSpace = gameSpaces[i]
                call thisSpace.initialize()
                set i = i - 1
            endloop
        endmethod

        method contains takes unit thisUnit returns nothing
            local Table gameSpaces = this.spaces.getKeys()
            local GameSpace thisSpace
            local integer i = gameSpaces[0]
            local boolean result
            loop
                exitwhen i == 0
                set thisSpace = gameSpaces[i]
                set result = thisSpace.contains(thisUnit)
                exitwhen result
                set i = i - 1
            endloop
            return result
        endmethod

        method containsPoint takes real x, real y returns nothing
            local Table gameSpaces = this.spaces.getKeys()
            local GameSpace thisSpace
            local integer i = gameSpaces[0]
            local boolean result
            loop
                exitwhen i == 0
                set thisSpace = gameSpaces[i]
                set result = thisSpace.containsPoint(x, y)
                exitwhen result
                set i = i - 1
            endloop
            return result
        endmethod

        method forEachUnit takes code callback returns nothing
            local Table gameSpaces = this.spaces.getKeys()
            local GameSpace thisSpace
            local integer i = gameSpaces[0]
            loop
                exitwhen i == 0
                exitwhen result
                set thisSpace = gameSpaces[i]
                call thisSpace.forEachUnit(callback)
                set i = i - 1
            endloop
        endmethod
    endstruct
endlibrary