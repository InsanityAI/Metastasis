//TESH.scrollpos=1
//TESH.alwaysfold=0
function Trig_ChatGroupRemove_Conditions takes nothing returns boolean
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) != true ) ) then
        return false
    endif
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-remove" ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChatGroupRemove_Func009C takes nothing returns boolean
    if ( not ( udg_TempInt > 0 ) ) then
        return false
    endif
    if ( not ( GetConvertedPlayerId(GetTriggerPlayer()) == udg_TempInt2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChatGroupRemove_Actions takes nothing returns nothing
local integer i=0
    call ExecuteFunc( "ClearArguments" )
    call ExecuteFunc( "ParseEnteredString" )
    set udg_TempInt2=LoadInteger(LS(), GetHandleId(gg_trg_ChatGroupAdd), StringHash(udg_arguments[2]))
    set udg_TempInt=LoadInteger(LS(), GetHandleId(gg_trg_ChatGroupBroadcast), StringHash(udg_arguments[3]))
    set udg_TempPlayerGroup=LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_arguments[2]))
    set udg_TempString = udg_arguments[2]
    if ( Trig_ChatGroupRemove_Func009C() ) then
      if udg_TempInt==1337 then
      call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 30, " |cff008000All players have been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) )
    loop
    exitwhen i > 11
              call ForceRemovePlayerSimple( Player(i), udg_TempPlayerGroup )
        call DisplayTimedTextToPlayer( Player(i), 0, 0, 30, ( "You" + ( " |cff008000have been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) ) ) )
  set i=i+1
  endloop
  else
        call ForceRemovePlayerSimple( ConvertedPlayer(udg_TempInt), udg_TempPlayerGroup )
        call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 30, ( udg_ColorCode[udg_TempInt] + GetPlayerName(ConvertedPlayer(udg_TempInt)) + ( "|r |cff008000has been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) ) ) )
        call DisplayTimedTextToPlayer( ConvertedPlayer(udg_TempInt), 0, 0, 30, ( "You" + ( " |cff008000have been removed from group |r|cff0080C0" + ( udg_TempString + "|r." ) ) ) )
    endif
    else
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

