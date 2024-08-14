library Station initializer init requires Table, Dockable, Poddable, Boardable, CompositeGameSpace, Timeout, MetaPlayer 
    globals 
        private Table triggerData //table<unit, Station>    
        private Table timerData //table<timer, Station>    

        private trigger damageTrigger 
        private conditionfunc damageAction 

        private trigger deathTrigger 
        private conditionfunc deathAction 

        private string currentMessage
    endglobals 

    private function endStationDamage takes nothing returns nothing 
        local Station stationData = timerData.get(GetExpiringTimer()) 
        set stationData.takingDamage = false 
        call SetStackedSoundBJ(false, Sounds_ALARM, station.overRect) 
        call PauseTimer(stationData.damageNotificationTimer) 
    endfunction 

    private function notifyPlayerOfStationDamage takes nothing returns nothing 
        local MetaPlayer metaPlayer = MetaPlayer_GetFromHero(GetEnumUnit()) 
        if metaPlayer == 0 then 
            return 
        endif 
        call DisplayTimedTextToPlayer(metaPlayer.actualPlayer, 0, 0, 5.00, currentMessage)
    endfunction 

    private function stationDamageNotification takes nothing returns nothing 
        local Station stationData = timerData.get(GetExpiringTimer()) 
        set currentMessage = "|cFFFF0000" + stationData.name ++ " under attack!|r"
        call stationData.forEachUnit(function notifyPlayerOfStationDamage) 
    endfunction 

    private function stationDamaged takes nothing returns boolean 
        local unit damagedUnit = GetTriggerData() 
        local Station station 

        if not triggerData.stores(damagedUnit) then 
            return //not a station    
        endif 
        set station = triggerData.get(GetTriggerUnit()) 

        if station.damageSilent then
            return
        endif

        if not station.takingDamage then 
            set stationData.takingDamage = true 
            call SetStackedSoundBJ(true, Sounds_ALARM, station.overRect) 
            call TimerStart(station.damageNotificationTimer, 5.00, true, function stationDamageNotification) 
        endif 

        call TimerStart(station.damageTimer, 5.00, false, function endStationDamage) 
    endfunction 

    private function stationDeath takes nothing returns boolean 
        local unit dyingUnit = GetTriggerData() 
        local Station station 

        if not triggerData.stores(dyingUnit) then 
            return //not a station    
        endif 
        set station = triggerData.get(GetTriggerUnit()) 
    endfunction 

    struct Station extends CompositeGameSpace, IPoddable 
        readonly string name
        readonly unit stationUnit 
        readonly rect overRect 
        public boolean takingDamage = false 
        readonly timer damageTimer 
        readonly timer damageNotificationTimer 
        public boolean damageSilent = false

        static method create takes unit stationUnit, rect overRect, string name returns thistype 
            local thistype this = thistype.allocate() 
            set this.stationUnit = stationUnit 
            set this.name = name
            set this.overRect = overRect 
            set this.damageTimer = CreateTimer() 
            set this.damageNotificationTimer = CreateTimer() 
            call triggerData.store(stationUnit, this) 
            call timerData.store(this.damageTimer, this) 
            call timerData.store(this.damageNotificationTimer, this) 
            return this 
        endmethod 

        implement Poddable 
    endstruct 

    struct BoardableStation extends Station, IBoardable 
        static method create takes unit stationUnit, rect overRect returns thistype 
            return thistype.allocate(stationUnit, overRect) 
        endmethod 
        implement Boardable 
    endstruct 

    struct DockableStation extends Station, IDockable 
        static method create takes unit stationUnit, rect overRect returns thistype 
            return thistype.allocate(stationUnit, overRect) 
        endmethod 
        implement Dockable 
    endstruct 

    private function init takes nothing returns nothing 
        set triggerData = Table.create() 
        set timerData = Table.create() 

        set damageTrigger = CreateTrigger() 
        set damageAction = Condition(function stationDamaged) 
        call TriggerRegisterAnyUnitEventBJ(damageTrigger, EVENT_PLAYER_UNIT_DAMAGED) 
        set deathTrigger = CreateTrigger() 
        set deathAction = Condition(function stationDeath) 
        call TriggerRegisterAnyUnitEventBJ(damageTrigger, EVENT_PLAYER_UNIT_DEATH) 
    endfunction 
endlibrary