//TESH.scrollpos=23
//TESH.alwaysfold=0
function Trig_ChatGroupMutantBroadcast_Conditions takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 1, 1) == "[" ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) != true ) ) then
        return false
    endif
    return true
endfunction



function Trig_ChatGroupMutantBroadcast_Actions takes nothing returns nothing
local integer i=0

 //   call ExecuteFunc( "ClearArguments" )
  //  call ExecuteFunc( "ParseEnteredString" )
    if not(udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetTriggerPlayer())] or GetTriggerPlayer()==udg_Mutant) or Player_IsDead(GetTriggerPlayer()) then
    return
    endif
    set udg_arguments[2]=SubStringBJ(GetEventPlayerChatString(),2,99)
    loop
    exitwhen i>11
    if (udg_Player_IsMutantSpawn[i+1] or Player(i)==udg_Mutant) then
    call DisplayTextToPlayer(Player(i),0,0, "|cff800080" +  "[" +  "Mutant" +  "]|r" + udg_ColorCode[GetConvertedPlayerId(GetTriggerPlayer())]+ GetPlayerName(GetTriggerPlayer())  +  "|r: " + udg_arguments[2] )
    endif
    set i=i+1
    endloop
endfunction

//===========================================================================
function InitTrig_ChatGroupMutantBroadcast takes nothing returns nothing
local integer i=0
    set gg_trg_ChatGroupMutantBroadcast = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_ChatGroupMutantBroadcast, Player(i), "[", false )
    set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_ChatGroupMutantBroadcast, Condition( function Trig_ChatGroupMutantBroadcast_Conditions ) )
    call TriggerAddAction( gg_trg_ChatGroupMutantBroadcast, function Trig_ChatGroupMutantBroadcast_Actions )
endfunction

