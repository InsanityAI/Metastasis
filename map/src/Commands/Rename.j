library RenameCommand initializer init requires Commands, ChatSystem, ChatProfiles, StringUtil
    struct RenameCommand extends Command
        globals
            private RenameCommand thisCommand
        endglobals

        public static method create takes nothing returns thistype
            return thistype.allocate("rename", 2)
        endmethod

        public method execute takes player initiator, integer argc returns nothing
            local string name = udg_NamePrepension[GetConvertedPlayerId(initiator)] + StringUtil_argv[1]
            local ChatProfile playerProfile = ChatProfiles_getReal(initiator)
            if not IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) then
                call playerProfile.name = PlayerColor_GetPlayerTextColor(initiator) + name + "|r"
                call SetPlayerName(initiator, name) 
                call StateGrid_SetPlayerName(initiator, name) 
                call ChatSystem_sendSystemMessageToPlayer(initiator, "You have been successfully renamed.")
            else
                call ChatSystem_sendSystemMessageToPlayer(initiator, "|cFFFF0000ERROR: You are not allowed to rename while dead!")
            endif
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set thisCommand = RenameCommand.create()
    endfunction

    public function Disable takes nothing returns nothing
        call thisCommand.destroy()
    endfunction
endlibrary
