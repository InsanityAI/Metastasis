function Trig_BlackoutEnd_Func015A takes nothing returns nothing 
    call FogModifierStart(udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())]) 
endfunction 

function Trig_BlackoutEnd_Func016A takes nothing returns nothing 
    call SetUnitMoveSpeed(GetEnumUnit(), GetUnitDefaultMoveSpeed(GetTriggerUnit())) 
    call SetUnitOwner(GetEnumUnit(), udg_EscapePod_Owner[GetUnitUserData(GetEnumUnit())], true) 
endfunction 

function Trig_BlackoutEnd_Func017Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BlackoutEnd_Func017A takes nothing returns nothing 
    if(Trig_BlackoutEnd_Func017Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    else 
    endif 
endfunction 

function Trig_BlackoutEnd_Func018Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BlackoutEnd_Func018A takes nothing returns nothing 
    if(Trig_BlackoutEnd_Func018Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    else 
    endif 
endfunction 

function Trig_BlackoutEnd_Func019Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BlackoutEnd_Func019A takes nothing returns nothing 
    if(Trig_BlackoutEnd_Func019Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    else 
    endif 
endfunction 

function Trig_BlackoutEnd_Func020Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BlackoutEnd_Func020A takes nothing returns nothing 
    if(Trig_BlackoutEnd_Func020Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    else 
    endif 
endfunction 

function Trig_BlackoutEnd_Func021Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BlackoutEnd_Func021A takes nothing returns nothing 
    if(Trig_BlackoutEnd_Func021Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    else 
    endif 
endfunction 

function Trig_BlackoutEnd_Func022Func001C takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_BlackoutEnd_Func022A takes nothing returns nothing 
    if(Trig_BlackoutEnd_Func022Func001C()) then 
        call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    else 
    endif 
endfunction 

function Trig_BlackoutEnd_Actions takes nothing returns nothing 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4613") 
    call PolledWait(2.00) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4614") 
    call PolledWait(2.00) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4615") 
    call PolledWait(2.00) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4616") 
    call PolledWait(2.00) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4617") 
    set udg_Blackout = false 
    call PolledWait(2.00) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2571") 
    call DestroyTimerDialogBJ(udg_BlackoutTimerWindow) 
    call ForForce(GetPlayersAll(), function Trig_BlackoutEnd_Func015A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h02P'), function Trig_BlackoutEnd_Func016A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h02B'), function Trig_BlackoutEnd_Func017A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h043'), function Trig_BlackoutEnd_Func018A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h040'), function Trig_BlackoutEnd_Func019A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h041'), function Trig_BlackoutEnd_Func020A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h042'), function Trig_BlackoutEnd_Func021A) 
    call ForGroupBJ(GetUnitsOfTypeIdAll('h02T'), function Trig_BlackoutEnd_Func022A) 
endfunction 

//=========================================================================== 
function InitTrig_BlackoutEnd takes nothing returns nothing 
    set gg_trg_BlackoutEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_BlackoutEnd, udg_BlackoutTimer) 
    call TriggerAddAction(gg_trg_BlackoutEnd, function Trig_BlackoutEnd_Actions) 
endfunction 

