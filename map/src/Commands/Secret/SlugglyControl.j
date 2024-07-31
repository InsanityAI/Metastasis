library SlugglyCommand initializer init requires Commands, ChatSystem
    globals
        private constant SLUGGLY_UNITID = 'n003'
        private boolexpr slugglyFilter
        private group slugglyGroup
        private player initiatorPlayer
    endglobals

    private function SlugglyFilter takes nothing returns boolean
        local unit sluggly = GetFilterUnit()
        return GetUnitTypeId(sluggly) == SLUGGLY_UNITID and UnitAlive(sluggly) and not RectContainsUnit(gg_rct_Cage4, sluggly)
    endfunction

    private function GrabAliveUncontrolledSluggly takes nothing returns unit
        call GroupEnumUnitsOfPlayer(slugglyGroup, Player(PLAYER_NEUTRAL_PASSIVE), slugglyFilter)
        return GroupPickRandomUnit(g)
    endfunction

    private function ModifyPlayerAlliances takes nothing returns nothing
        if IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) then 
            call SetPlayerAllianceStateBJ(GetEnumPlayer(), initiatorPlayer, bj_ALLIANCE_ALLIED) 
            call SetPlayerAllianceStateBJ(initiatorPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED) 
        endif 
    endfunction

    struct SlugglyCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("iamthesluggly", 1)
        endmethod

        private method controlSluggly takes player initiator returns nothing
            local targetSluggly = GrabAliveUncontrolledSluggly()
            if targetSluggly == null then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: There are no eligible slugglies to take control of!")
                return
            endif
            set udg_Player_Slugglied[GetConvertedPlayerId(initiator)] = true 
            set initiatorPlayer = initiator
            call ForForce(GetPlayersAll(), function ModifyPlayerAlliances) 
            call SetUnitOwner(targetSluggly, initiator, true) 
            call PanCameraToTimedForPlayer(initiator, GetUnitX(targetSluggly), GetUnitY(targetSluggly), 0) 
            call SelectUnitForPlayerSingle(targetSluggly, initiator) 
            call SetUnitMoveSpeed(targetSluggly, 330.00) 
            call UnitAddAbilityBJ('A02I', targetSluggly) 
            call UnitAddAbilityBJ('AIl2', targetSluggly) 
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if udg_Player_Slugglied[GetConvertedPlayerId(initiator)] then 
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: You are already in control of a sluggly!")
                return
            endif
            if not IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) then
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Unknown command!")
                return
            endif
            call this.controlSluggly(initiator)            
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call SlugglyCommand.create()
        set slugglyFilter = Filter(function SlugglyFilter)
        set slugglyGroup = CreateGroup()
    endfunction
endlibrary
