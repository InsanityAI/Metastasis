library SimpleGameSpace initializer init requires Table, GameSpace
    globals
        private Table triggerData //table<trigger, SimpleGameSpace>
        private fogstate currentFogState
        private rect currentRect
        private conditionfunc enterSpaceAction
        private conditionfunc exitSpaceAction
    endglobals

    private function flashVisibilityEnum takes nothing returns nothing
        call DestroyFogModifier(CreateFogModifierRectBJ(true, GetEnumPlayer(), currentFogState, currentRect))
    endfunction

    private function flashVisibility takes Table rects, fogstate visionMod returns nothing
        local integer i = rects[0]
        local force players = GetPlayersAll()
        set currentFogState = visionMod

        loop
            exitwhen i == 0
            set currentRect = rects.rect[i]
            call ForForce(players, function flashVisibilityEnum)
            set i = i - 1
        endloop

        set players = null
        set vision = null
    endfunction

    private function enterSpace takes nothing returns boolean
        local SimpleGameSpace gameSpace = triggerData.get(GetTriggeringTrigger())
        call GroupAddUnit(gameSpace.unitsInSpace, GetTriggerUnit())
        return true
    endfunction

    private function exitSpace takes nothing returns boolean
        local SimpleGameSpace gameSpace = triggerData.get(GetTriggeringTrigger())
        call GroupRemoveUnit(gameSpace.unitsInSpace, GetTriggerUnit())
        return true
    endfunction

    struct SimpleGameSpace extends GameSpace
        private Table rects //table<rect, boolean>
        private region space
        readonly group unitsInSpace
        private trigger unitEnterSpace
        private trigger unitExitSpace

        static method create takes nothing returns thistype
            local thistype this = thistype.allocate()
            set this.rects = Table.create()
            set this.space = CreateRegion()

            set this.unitEnterSpace = CreateTrigger()
            call TriggerRegisterEnterRegion(this.unitEnterSpace, this.space, null)
            call TriggerAddCondition(this.unitEnterSpace, enterSpaceAction)
            call triggerData.store(this.unitEnterSpace, this)

            set this.unitExitSpace = CreateTrigger()
            call TriggerRegisterLeaveRegion(this.unitExitSpace, this.space, null)
            call TriggerAddCondition(this.unitExitSpace, exitSpaceAction)
            call triggerData.store(this.unitExitSpace, this)

            return this
        endmethod

        method destroy takes nothing returns nothing
            call flashInvisibility(this.rects.getKeys(), FOG_OF_WAR_MASKED)
            this.rects.destroy()
        endmethod

        method addRect takes rect r returns nothing
            call this.rects.boolean.store(r, true)
            call RegionAddRect(this.space, r)
        endmethod

        method removeRect takes rect r returns nothing
            call this.rects.forget(r)
            //Note: this might cause issues where rects overlap, TODO: refresh region?
            call RegionClearRect(this.space, r)
        endmethod

        method getRects takes nothing returns Table //tablekeys
            return this.rects.getKeys()
        endmethod

        method initialize takes nothing returns nothing
            call flashInvisibility(this.rects.getKeys(), FOG_OF_WAR_VISIBLE)
        endmethod

        method contains takes unit thisUnit returns boolean
            return IsUnitInGroup(thisUnit, this.unitsInSpace)
        endmethod

        method forEachUnit takes code callback returns nothing
            call ForGroup(this.unitsInSpace, callback)
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set enterSpaceAction = Condition(enterSpace)
        set exitSpaceAction = Condition(exitSpace)
    endfunction
endlibrary