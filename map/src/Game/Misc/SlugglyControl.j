function Trig_SlugglyControl_Conditions takes nothing returns boolean 
    if(not(udg_Player_Slugglied[GetConvertedPlayerId(GetTriggerPlayer())] != true)) then 
        return false 
    endif 
    if(not(IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SlugglyControl_Func017Func002C takes nothing returns boolean 
    if((udg_TempUnit == null)) then 
        return true 
    endif 
    if((IsUnitDeadBJ(udg_TempUnit) == true)) then 
        return true 
    endif 
    if((RectContainsUnit(gg_rct_Cage4, udg_TempUnit) == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_SlugglyControl_Func017C takes nothing returns boolean 
    if(not Trig_SlugglyControl_Func017Func002C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SlugglyControl_Func018Func001C takes nothing returns boolean 
    if(not(IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SlugglyControl_Func018A takes nothing returns nothing 
    if(Trig_SlugglyControl_Func018Func001C()) then 
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), GetTriggerPlayer(), bj_ALLIANCE_ALLIED) 
        call SetPlayerAllianceStateBJ(GetTriggerPlayer(), GetEnumPlayer(), bj_ALLIANCE_ALLIED) 
    else 
    endif 
endfunction 

function Trig_SlugglyControl_Actions takes nothing returns nothing 
    set udg_Player_Slugglied[GetConvertedPlayerId(GetTriggerPlayer())] = true 
    set udg_TempUnit = GroupPickRandomUnit(GetUnitsOfPlayerAndTypeId(Player(PLAYER_NEUTRAL_PASSIVE), 'n003')) 
    if(Trig_SlugglyControl_Func017C()) then 
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, "Oops! Try again.") 
        return 
    else 
    endif 
    call ForForce(GetPlayersAll(), function Trig_SlugglyControl_Func018A) 
    call SetUnitOwner(udg_TempUnit, GetTriggerPlayer(), true) 
    call PanCameraToTimedLocForPlayer(GetTriggerPlayer(), GetUnitLoc(udg_TempUnit), 0) 
    call SelectUnitForPlayerSingle(udg_TempUnit, GetTriggerPlayer()) 
    call SetUnitMoveSpeed(udg_TempUnit, 330.00) 
    call UnitAddAbilityBJ('A02I', udg_TempUnit) 
    call UnitAddAbilityBJ('AIl2', udg_TempUnit) 
endfunction 

//=========================================================================== 
function InitTrig_SlugglyControl takes nothing returns nothing 
    set gg_trg_SlugglyControl = CreateTrigger() 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(0), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(1), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(2), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(3), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(4), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(5), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(6), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(7), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(8), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(9), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(10), "-iamthesluggly", true) 
    call TriggerRegisterPlayerChatEvent(gg_trg_SlugglyControl, Player(11), "-iamthesluggly", true) 
    call TriggerAddCondition(gg_trg_SlugglyControl, Condition(function Trig_SlugglyControl_Conditions)) 
    call TriggerAddAction(gg_trg_SlugglyControl, function Trig_SlugglyControl_Actions) 
endfunction 

