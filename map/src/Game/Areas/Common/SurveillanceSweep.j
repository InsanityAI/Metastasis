library SurveillanceSweep initializer init requires Station, MetaPlayer, UserNotifications, Space
    globals 
        private constant integer ABILITY_ID = 'A000' 

        private trigger abilityTrigger 

        private player currentPlayer
    endglobals 

    private function pingUnitsOfInterest takes nothing returns nothing 
        local unit thisUnit
        local MetaPlayer metaPlayer
        
        set thisUnit = GetEnumUnit() 

        //TODO: Check if inside Ship - ping ships with units inside
        // if IsUnitExplorer(thisUnit) and ShipHasUnits(thisUnit) then 
        //     call PingMinimapEx(thisUnit), GetUnitY(thisUnit), 7.00, 255, 63, 128, false) 
        // endif 

        set metaPlayer = MetaPlayer_GetFromHero(thisUnit)
        if metaPlayer == 0 then
            set thisUnit = null
            return
        endif

        if currentPlayer == null or currentPlayer == GetLocalPlayer() then
            call PingMinimapEx(GetUnitX(thisUnit), GetUnitY(thisUnit), 7.00, 255, 255, 255, false) 
        endif

        set thisUnit = null 
    endfunction 

    public function SweepStation takes MetaPlayer initiator, real x, real y returns nothing
        local Station station = Station_GetFromPoint(x, y) 
        if station == 0 then 
            call UserError(metaPlayer.actualPlayer, "|cFF00FFFFDev error: Sweep not initiated from within a station!") 
            return false 
        endif 

        if initiator == 0 then
            set currentPlayer = null
        else
            set currentPlayer = metaPlayer.actualPlayer
        endif
        call station.forEachUnit(function pingUnitsOfInterest)
    endfunction

    public function SweepSpace takes MetaPlayer initiator returns nothing
        if initiator == 0 then
            set currentPlayer = null
        else
            set currentPlayer = metaPlayer.actualPlayer
        endif
        call Space_Space.forEachUnit(function pingUnitsOfInterest)
    endfunction

    private function sweepAction takes nothing returns boolean 
        local unit triggerUnit 
        local MetaPlayer metaPlayer 

        if GetSpellAbilityId() != ABILITY_ID then 
            return false 
        endif 

        set triggerUnit = GetTriggerUnit() 
        set metaPlayer = MetaPlayer_GetFromOwner(triggerUnit) 
        
        call DisplayTextToForce(GetPlayersAll(), "|cffFF8000" + station.name + " initiating surveillance sweep...|r") 
        call SweepStation(metaPlayer, GetUnitX(triggerUnit), GetUnitY(triggerUnit))

        set triggerUnit = null 
        return true 
    endfunction 

    private function init takes nothing returns nothing 
        set abilityTrigger = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(abilityTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
        call TriggerAddCondition(abilityTrigger, Condition(function sweepAction)) 
    endfunction 
endlibrary 
