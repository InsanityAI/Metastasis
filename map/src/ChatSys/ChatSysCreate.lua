//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_ChatSysCreate_Conditions takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 1, 12) == "-creategroup" ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) != true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChatSysCreate_Func003C takes nothing returns boolean
    if ( not ( CountPlayersInForceBJ(udg_TempPlayerGroup) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChatSysCreate_Actions takes nothing returns nothing
    set udg_TempString = SubStringBJ(GetEventPlayerChatString(), 14, 99)
    set udg_TempPlayerGroup=LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_TempString))

    if ( Trig_ChatSysCreate_Func003C() ) then
        set udg_TempPlayerGroup = CreateForce()
        call ForceAddPlayerSimple( GetTriggerPlayer(), udg_TempPlayerGroup )
        call SaveForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_TempString), udg_TempPlayerGroup)
        call SaveInteger(LS(), GetHandleId(gg_trg_ChatGroupAdd), StringHash(udg_TempString), GetConvertedPlayerId(GetTriggerPlayer()))
        call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 30, "TRIGSTR_1559" )
    else
        call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 30, "TRIGSTR_1558" )
    endif
endfunction

//===========================================================================
function InitTrig_ChatSysCreate takes nothing returns nothing
local integer i=0
    set gg_trg_ChatSysCreate = CreateTrigger(  )
    loop
    exitwhen i > 11
    call TriggerRegisterPlayerChatEvent( gg_trg_ChatSysCreate, Player(i), "-creategroup", false )
    set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_ChatSysCreate, Condition( function Trig_ChatSysCreate_Conditions ) )
    call TriggerAddAction( gg_trg_ChatSysCreate, function Trig_ChatSysCreate_Actions )
endfunction

