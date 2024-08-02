library ShutdownCommand initializer init requires Commands, ChatSystem, CSAPI
    struct ShutdownCommand extends Command
        public static method create takes nothing returns thistype
            return thistype.allocate("shutdown", 1)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            if initiator == udg_HiddenAndroid then 
                set udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] = CreateUnitAtLoc(udg_HiddenAndroid, 'hpea', udg_HoldZone, bj_UNIT_FACING)
                call KillUnit(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]) 
                call RemoveItem(udg_Android_MemoryCard) 
                call ChatSystem_groupDead.add(ChatProfiles_getReal(udg_HiddenAndroid))
                call PlayerSelectedChat_SetPlayerChatGroup(udg_HiddenAndroid, ChatSystem_groupDead)
                set AndroidChat_Enabled = false //make droid be able to deadchat
                set udg_HiddenAndroid = Player(PLAYER_NEUTRAL_PASSIVE) 
            else
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Unknown command!")
            endif 
        endmethod
    endstruct

    private function init takes nothing returns nothing
        call ShutdownCommand.create()
    endfunction
endlibrary
