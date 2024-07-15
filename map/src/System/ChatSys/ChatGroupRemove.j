function Trig_ChatGroupRemove_Conditions takes nothing returns boolean
    return IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) != true and SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-remove"
endfunction

function Trig_ChatGroupRemove_IsOwner takes nothing returns boolean
    return udg_TempInt > 0 and GetConvertedPlayerId(GetTriggerPlayer()) == udg_TempInt2
endfunction

function Trig_ChatGroupRemove_Actions takes nothing returns nothing
    local player targettedPlayer
    local integer i=0
    call ClearArguments()
    call ParseEnteredString()
    set udg_TempInt2=LoadInteger(LS(), GetHandleId(gg_trg_ChatGroupAdd), StringHash(udg_arguments[2]))
    set udg_TempInt=S2I(udg_arguments[3])
    set udg_TempPlayerGroup=LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_arguments[2]))
    set udg_TempString = udg_arguments[2]
    if Trig_ChatGroupRemove_IsOwner() then
        if udg_TempInt==1337 then
            call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 30, " |cff008000All players have been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) )
            loop
                exitwhen i > 11
                call ForceRemovePlayerSimple( Player(i), udg_TempPlayerGroup )
                call DisplayTimedTextToPlayer( Player(i), 0, 0, 30, ( "You" + ( " |cff008000have been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) ) ) )
                set i=i+1
            endloop
        else
            set targettedPlayer = Anonymity_ShuffledPlayersArray[udg_TempInt]
            call ForceRemovePlayerSimple( targettedPlayer, udg_TempPlayerGroup )
            call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 30, ( PlayerColor_GetPlayerTextColor(targettedPlayer) + GetPlayerName(targettedPlayer) + ( "|r |cff008000has been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) ) ) )
            call DisplayTimedTextToPlayer( targettedPlayer, 0, 0, 30, ( "You" + ( " |cff008000have been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) ) ) )
        endif
    endif
endfunction

//===========================================================================
function InitTrig_ChatGroupRemove takes nothing returns nothing
local integer i=0
    set gg_trg_ChatGroupRemove = CreateTrigger(  )
    loop
        exitwhen i > 11
        call TriggerRegisterPlayerChatEvent( gg_trg_ChatGroupRemove, Player(i), "-remove", false )
        set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_ChatGroupRemove, Condition( function Trig_ChatGroupRemove_Conditions ) )
    call TriggerAddAction( gg_trg_ChatGroupRemove, function Trig_ChatGroupRemove_Actions )
endfunction

