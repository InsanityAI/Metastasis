library Boardable initializer init requires Table, Timeout, ProgressBar
    globals 
        private constant integer SHIP_BOARD_ABILITY = 'A02J' 
        private constant real BOARDING_DURATION = 20.00 

        private trigger attemptBoardingTrigger 
        private trigger boardingTrigger 
        private trigger deathTrigger 
        private trigger transferUnitTrigger 

        private Table boardableUnits //table<unit, IBoardable>  
        private Table boardingActions //table<unit, BoardingAction>  
        private Table transferTriggers //table<trigger, IBoardable>

        private code destroyBoardActionTimed 
        private conditionfunc transferUnitAction
    endglobals 

    struct BoardingAction 
        readonly IBoardable sourceBoard 
        readonly IBoardable targetBoard
        readonly unit sourceUnit
        readonly unit targetUnit
        readonly lightning boardingBeam 
        readonly integer progressBar 
        readonly Table endTimerData 

        static method create takes IBoardable sourceBoard, IBoardable targetBoard, unit sourceUnit, unit targetUnit returns thistype 
            local thistype this = thistype.allocate() 
            local real x1 = GetUnitX(sourceUnit) 
            local real y2 = GetUnitY(sourceUnit) 
            local real x2 = GetUnitX(targetUnit) 
            local real y2 = GetUnitY(targetUnit) 
            set this.sourceBoard = sourceBoard 
            set this.targetBoard = targetBoard 
            set this.sourceUnit = sourceUnit 
            set this.targetUnit = targetUnit 
            call boardingActions.store(sourceUnit, this) 
            call boardingActions.store(targetUnit, this) 
            call PauseUnit(sourceUnit, false) 
            call PauseUnit(targetUnit, false) 
            set this.boardingBeam = AddLightningEx("MFPB", true, x1, y1, -156, x2, y2, -156) 
            set this.progressBar = ProgressBars_TimedAdd((x1 + x2) / 2, (y1 + y2) / 2, BOARDING_DURATION, "|cff00FFFF", true) 
            set this.endTimerData = Timeout.start(BOARDING_DURATION, false, function destroyBoardActionTimed) 
            set this.endTimerData.write("boardingAction", this) 
            return this 
        endmethod 

        method destroy takes nothing returns nothing 
            call boardingActions.forget(this.sourceUnit) 
            call boardingActions.forget(this.targetUnit) 
            call PauseUnit(boardingTrigger.boardableUnit, false) 
            call PauseUnit(boardingTarget.boardableUnit, false) 
            call boardingTrigger.setBoarding(null) 
            call boardingTarget.setBoarding(null) 
            call DestroyLightning(this.boardingBeam) 
            call Timeout.stop(this.endTimerData, true) 
        endmethod 
    endstruct 

    interface IBoardable 
        method setBoardingEntrance takes rect entrance returns nothing 
        method getBoardingEntranceX takes nothing returns real 
        method getBoardingEntranceY takes nothing returns real 
        method isBoarding takes nothing returns boolean 
        method setBoardingAction takes BoardingAction boardingAction returns nothing 
        method getBoardingAction takes nothing returns BoardingAction
        method defineBoardableUnit takes unit thisUnit returns nothing 
        method enableBoarding takes boolean enable returns nothing
    endinterface 

    module Boardable 
        private unit boardableUnit 
        private BoardingAction boardingAction 
        private rect boardEntrance 
        private trigger boardTransferTrigger 
        private region enterRegion 

        public method setBoardingEntrance takes rect entrance returns nothing 
            if this.enterRegion == null then
                set this.enterRegion = CreateRegion()
                set this.boardTransferTrigger = CreateTrigger()
                call TriggerRegisterEnterRegion(this.boardTransferTrigger, this.enterRegion, null)
                call TriggerAddCondition(this.boardTransferTrigger, transferUnitAction)
                call DisableTrigger(this.boardTransferTrigger)
                call transferTriggers.store(this.boardTransferTrigger, this)
            endif

            if this.boardEntrance != null then 
                call RegionClearRect(this.enterRegion, this.boardEntrance)
            endif 
            call RegionAddRect(this.enterRegion, entrance)
            set this.boardEntrance = entrance 
        endmethod 

        public method getBoardingEntranceX takes nothing returns real 
            return GetRectCenterX(this.boardEntrance) 
        endmethod 

        public method getBoardingEntranceY takes nothing returns real 
            return GetRectCenterY(this.boardEntrance) 
        endmethod 

        public method isBoarding takes nothing returns boolean 
            return this.boardingAction != 0 
        endmethod 

        public method setBoardingAction takes BoardingAction boardingAction returns nothing 
            set this.boardingAction = boardingAction 
            if this.isBoarding() then
                call EnableTrigger(this.boardTransferTrigger)
            else
                call DisableTrigger(this.boardTransferTrigger)
            endif
        endmethod 

        public method getBoardingAction takes nothing returns BoardingAction
            return this.boardingAction
        endmethod

        public method defineBoardableUnit takes unit thisUnit returns nothing 
            set this.boardableUnit = thisUnit 
            if thisUnit != null then 
                call boardableUnits.forget(thisUnit) 
            endif 
            call boardableUnits.store(thisUnit, this) 
        endmethod 

        public method enableBoarding takes boolean enable returns nothing
            if enable and this.isBoarding() then
                call EnableTrigger(this.boardTransferTrigger)
            else
                call DisableTrigger(this.boardTransferTrigger)
            endif
        endmethod
    endmodule 

    private function attemptBoardingAction takes nothing returns boolean 
        if GetSpellAbilityId() == SHIP_BOARD_ABILITY then 
            if boardableUnits.stores(GetSpellTargetUnit()) then 
                return true 
            endif 
            call IssueImmediateOrder(GetTriggerUnit(), "stop") 
        endif 
        return false 
    endfunction 

    private function endBoarding takes nothing returns nothing 
        local BoardingAction boardingAction = Timeout.complete().read("boardingAction") 
        call boardingAction.destroy() 
    endfunction 

    private function boardingAction takes nothing returns boolean 
        local unit triggerUnit = GetTriggerUnit() 
        local unit targetUnit = GetSpellTargetUnit() 
        local IBoardable boardingTrigger 
        local IBoardable boardingTarget 
        local lightning boardingBeam 
        local Timer timerData 

        if GetSpellAbilityId() == SHIP_BOARD_ABILITY then 
            return false 
        endif 

        if not boardableUnits.has(triggerUnit) then 
            return false 
        endif 
        set boardingTrigger = boardableUnits.get(triggerUnit) 
        if boardingTrigger.isBoarding then 
            return false 
        endif 
        call IssueImmediateOrder(triggerUnit, "stop") 

        if not boardableUnits.has(targetUnit) then 
            return false 
        endif 
        set boardingTarget = boardableUnits.get(targetUnit) 
        if boardingTarget.isBoarding then 
            return false 
        endif 
        call IssueImmediateOrder(targetUnit, "stop") 

        call BoardingAction.create(boardingTrigger, boardingTarget, triggerUnit, targetUnit) 
        return true 
    endfunction 

    private function deathAction takes nothing returns boolean 
        local unit triggerUnit = GetTriggerUnit() 
        local BoardingAction boardingAction 

        if not boardingActions.has(triggerUnit) then 
            return false 
        endif 
        set boardingAction = boardingActions.get(triggerUnit) 
        call boardingAction.destroy() 
    endfunction 

    private function transferAction takes nothing returns boolean
        local IBoardable boardHost = transferTriggers.get(GetTriggeringTrigger())
        local BoardingAction boardingAction = boardHost.getBoardingAction()
        local IBoardable boardDestination
        if boardingAction.sourceBoard == boardHost then
            set boardDestination = boardingAction.targetBoard
        else
            set boardDestination = boardHost
        endif
        
        call boardDestination.enableBoarding(false)
        call SetUnitPosition(GetTriggerUnit(), boardDestination.getBoardingEntranceX(), boardDestination.getBoardingEntranceY())
        call boardDestination.enableBoarding(true)
    endfunction

    private function init takes nothing returns nothing 
        set attemptBoardingTrigger = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(attemptBoardingTrigger, EVENT_PLAYER_UNIT_SPELL_CAST) 
        call TriggerAddCondition(attemptBoardingTrigger, Condition(function attemptBoardingAction)) 

        set boardingTrigger = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(boardingTrigger, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
        call TriggerAddCondition(boardingTrigger, Condition(function boardingAction)) 

        set deathTrigger = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(deathTrigger, EVENT_PLAYER_UNIT_DEATH) 
        call TriggerAddCondition(deathTrigger, Condition(function deathAction)) 

        set destroyBoardActionTimed = function endBoarding 
        set transferUnitAction = Condition(transferAction)

        set boardableUnits = Table.create() 
    endfunction 

endlibrary