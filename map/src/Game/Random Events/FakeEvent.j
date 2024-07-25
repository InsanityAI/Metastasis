function Trig_FakeEvent_Func002C takes nothing returns boolean 
    if(not(udg_TempInt == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func003C takes nothing returns boolean 
    if(not(udg_TempInt == 2)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func004C takes nothing returns boolean 
    if(not(udg_TempInt == 3)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func005C takes nothing returns boolean 
    if(not(udg_TempInt == 4)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func006C takes nothing returns boolean 
    if(not(udg_TempInt == 5)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func007C takes nothing returns boolean 
    if(not(udg_TempInt == 6)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func008C takes nothing returns boolean 
    if(not(udg_TempInt == 7)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func009C takes nothing returns boolean 
    if(not(udg_TempInt == 8)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func010C takes nothing returns boolean 
    if(not(udg_TempInt == 9)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func011C takes nothing returns boolean 
    if(not(udg_TempInt == 10)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func012C takes nothing returns boolean 
    if(not(udg_TempInt == 11)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func013C takes nothing returns boolean 
    if(not(udg_TempInt == 12)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func014C takes nothing returns boolean 
    if(not(udg_TempInt == 13)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func015C takes nothing returns boolean 
    if(not(udg_TempInt == 14)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func016C takes nothing returns boolean 
    if(not(udg_TempInt == 15)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Func017C takes nothing returns boolean 
    if(not(udg_TempInt == 16)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeEvent_Actions takes nothing returns nothing 
    set udg_TempInt = GetRandomInt(1, 16) 
    if(Trig_FakeEvent_Func002C()) then 
        call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(udg_TempPlayer) + " |cff00FF40has received a promotion!|r")) 
    else 
    endif 
    if(Trig_FakeEvent_Func003C()) then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4167") 
    else 
    endif 
    if(Trig_FakeEvent_Func004C()) then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4169") 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4170") 
    else 
    endif 
    if(Trig_FakeEvent_Func005C()) then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4171") 
    else 
    endif 
    if(Trig_FakeEvent_Func006C()) then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4172") 
    else 
    endif 
    if(Trig_FakeEvent_Func007C()) then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4173") 
    else 
    endif 
    if(Trig_FakeEvent_Func008C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func009C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func010C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func011C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func012C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func013C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func014C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func015C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func016C()) then 
    else 
    endif 
    if(Trig_FakeEvent_Func017C()) then 
    else 
    endif 
    call StartTimerBJ(udg_RandomEvent, false, GetRandomReal(120.00, 600.00)) 
endfunction 

//=========================================================================== 
function InitTrig_FakeEvent takes nothing returns nothing 
    set gg_trg_FakeEvent = CreateTrigger() 
    call DisableTrigger(gg_trg_FakeEvent) 
    call TriggerAddAction(gg_trg_FakeEvent, function Trig_FakeEvent_Actions) 
endfunction 

