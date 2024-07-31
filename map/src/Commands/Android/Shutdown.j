library ClearCommand initializer init requires Commands, ChatSystem, Anonymity
    struct ClearCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("shutdown", 1)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if initiator == udg_HiddenAndroid then 
                set udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] = CreateUnitAtLoc(udg_HiddenAndroid, 'hpea', udg_HoldZone, bj_UNIT_FACING)
                set udg_HiddenAndroid = Player(PLAYER_NEUTRAL_PASSIVE) 
                call KillUnit(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) 
                call RemoveItem(udg_Android_MemoryCard) 
            else
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Unknown command!")
            endif 
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call ClearCommand.create()
    endfunction
endlibrary