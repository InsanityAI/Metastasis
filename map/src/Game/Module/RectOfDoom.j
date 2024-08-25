library RectOfDoom initializer init requires Timeout
    globals
        private group units
        private group tempGroup
        private trigger entryTrigger
        private region regionOfDoom
    endglobals

    private function RectOfDoomEntryKill takes nothing returns boolean
        local unit u = GetTriggerUnit()
        call GroupAddUnit(units, u)
        call KillUnit(u)
        set u = null
    endfunction

    private function RectOfDoomKill takes nothing returns nothing
        call KillUnit(GetEnumUnit())
    endfunction

    private function RectOfDoomTimedKill takes nothing returns nothing
        call ForGroup(units, function RectOfDoomKill)
    endfunction
        
    function RectOfDoom takes rect r returns nothing
        call RegionAddRect(regionOfDoom, r)
        call GroupEnumUnitsInRect(tempGroup, r, null)
        call GroupAddGroup(tempGroup, units)
        call ForGroup(tempGroup, function RectOfDoomKill)
    endfunction

    private function init takes nothing returns nothing
        set units = CreateGroup()
        set tempGroup = CreateGroup()
        set regionOfDoom = CreateRegion()
        set entryTrigger = CreateTrigger()

        call TriggerRegisterEnterRegion(entryRegion, regionOfDoom, null)
        call TriggerAddCondition(entryRegion, Condition(function RectOfDoomEntryKill))
        call Timeout.start(2.0, true, function RectOfDoomTimedKill)
    endfunction
endlibrary