function Trig_DeathSysClick_Func003Func002Func003A takes nothing returns nothing 
    call DialogDisplayBJ(false, udg_DeathVoteDialog, GetEnumPlayer()) 
endfunction 

function Trig_DeathSysClick_Func003Func002C takes nothing returns boolean 
    if(not(udg_InstantBootMode_Votes >= (CountPlayersInForceBJ(GetPlayersAll()) / 2))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_DeathSysClick_Func003Func003Func004Func003A takes nothing returns nothing 
    call DialogDisplayBJ(false, udg_DeathVoteDialog, GetEnumPlayer()) 
endfunction 

function Trig_DeathSysClick_Func003Func003Func004C takes nothing returns boolean 
    if(not(udg_InstantBootMode_Votes >= (CountPlayersInForceBJ(GetPlayersAll()) / 2))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_DeathSysClick_Func003Func003C takes nothing returns boolean 
    if(not(GetClickedButtonBJ() == udg_DeathVoteDialog_Buttons[2])) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_DeathSysClick_Func003C takes nothing returns boolean 
    if(not(GetClickedButtonBJ() == udg_DeathVoteDialog_Buttons[1])) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_DeathSysClick_Actions takes nothing returns nothing 
    // Voting. Since Spectator mode is default, the voting really only ends if enough votes accumulate for Instant Boot mode. 
    if(Trig_DeathSysClick_Func003C()) then 
        call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(GetTriggerPlayer()) + " |cffFF8000has voted for spectator mode!|r")) 
        if(Trig_DeathSysClick_Func003Func002C()) then 
            call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2358") 
            set udg_DeathType = 1 
            call ForForce(GetPlayersAll(), function Trig_DeathSysClick_Func003Func002Func003A) 
        else 
        endif 
    else 
        if(Trig_DeathSysClick_Func003Func003C()) then 
            set udg_InstantBootMode_Votes = (udg_InstantBootMode_Votes + 1) 
            call DisplayTextToForce(GetPlayersAll(), (GetPlayerName(GetTriggerPlayer()) + " |cffFF8000has voted for instant-boot mode!|r")) 
            if(Trig_DeathSysClick_Func003Func003Func004C()) then 
                call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2355") 
                set udg_DeathType = 2 
                call ForForce(GetPlayersAll(), function Trig_DeathSysClick_Func003Func003Func004Func003A) 
            else 
            endif 
        else 
            call DialogDisplayBJ(true, udg_DeathVoteDialog, GetTriggerPlayer()) 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_DeathSysClick takes nothing returns nothing 
    set gg_trg_DeathSysClick = CreateTrigger() 
    call TriggerRegisterDialogEventBJ(gg_trg_DeathSysClick, udg_DeathVoteDialog) 
    call TriggerAddAction(gg_trg_DeathSysClick, function Trig_DeathSysClick_Actions) 
endfunction 

