function Trig_ST11HivesDie_Func004Func003A takes nothing returns nothing 
    call DisplayTextToPlayer(GetEnumPlayer(), 0, 0, "The Overlord has been slain! Flee his body or BE DOOMED TO A HORRIBLE DEATH.") 
endfunction 

function Trig_ST11HivesDie_Func004Func008C takes nothing returns boolean 
    if(not(IsUnitAliveBJ(gg_unit_h04X_0172) == false)) then 
        return false 
    endif 
    if(not(IsUnitAliveBJ(gg_unit_h04X_0148) == false)) then 
        return false 
    endif 
    if(not(IsUnitAliveBJ(gg_unit_h04X_0173) == false)) then 
        return false 
    endif 
    if(not(IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST11HivesDie_Func004C takes nothing returns boolean 
    if(not Trig_ST11HivesDie_Func004Func008C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST11HivesDie_Actions takes nothing returns nothing 
    if(Trig_ST11HivesDie_Func004C()) then 
        call DestroyTrigger(GetTriggeringTrigger()) 
        call SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], Player(PLAYER_NEUTRAL_PASSIVE), false) 
        call ForForce(GetPlayersAll(), function Trig_ST11HivesDie_Func004Func003A) 
        call DisplayTextToForce(GetForceOfPlayer(udg_Mutant), "\nDONT Panic.\nYou have 35 seconds to kill every invader and win the game!") 
        call StartTimerBJ(udg_OverlordDeath_DestructionTimer, false, 35.00) 
        call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_4087") 
        set udg_OverlordDeath_TimerWindow = GetLastCreatedTimerDialogBJ() 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ST11HivesDie takes nothing returns nothing 
    set gg_trg_ST11HivesDie = CreateTrigger() 
    call DisableTrigger(gg_trg_ST11HivesDie) 
    call TriggerRegisterUnitEvent(gg_trg_ST11HivesDie, gg_unit_h04X_0173, EVENT_UNIT_DEATH) 
    call TriggerRegisterUnitEvent(gg_trg_ST11HivesDie, gg_unit_h04X_0148, EVENT_UNIT_DEATH) 
    call TriggerRegisterUnitEvent(gg_trg_ST11HivesDie, gg_unit_h04X_0172, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_ST11HivesDie, function Trig_ST11HivesDie_Actions) 
endfunction 

