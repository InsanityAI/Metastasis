function Trig_ChooseRoles_Func003Func001C takes nothing returns boolean 
    if(not(GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING)) then 
        return false 
    endif 
    if(not(udg_Player_Left[GetConvertedPlayerId(GetEnumPlayer())] != true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func003A takes nothing returns nothing 
    if(Trig_ChooseRoles_Func003Func001C()) then 
        call ForceAddPlayerSimple(GetEnumPlayer(), udg_ChooseGroup) 
    else 
    endif 
endfunction 

function Trig_ChooseRoles_Func005A takes nothing returns nothing 
    set udg_TempUnit = GroupPickRandomUnit(udg_ChooseRoles_DummyGroup) 
    call GroupRemoveUnitSimple(udg_TempUnit, udg_ChooseRoles_DummyGroup) 
    set udg_TempInt = GetUnitUserData(udg_TempUnit) 
    set udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] = udg_TempInt 
endfunction 

function Trig_ChooseRoles_Func006A takes nothing returns nothing 
    set udg_TempPlayer = GetEnumPlayer() 
    call TriggerExecute(udg_PlayerRoleTrigger[udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())]]) 
endfunction 

function Trig_ChooseRoles_Func007Func001Func002Func001C takes nothing returns boolean 
    if(not(udg_HiddenAndroid == GetEnumPlayer())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func007Func001Func002C takes nothing returns boolean 
    if(not(udg_Parasite == GetEnumPlayer())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func007Func001C takes nothing returns boolean 
    if(not(udg_Mutant == GetEnumPlayer())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func007A takes nothing returns nothing 
    if(Trig_ChooseRoles_Func007Func001C()) then 
        call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "-Kill everybody, or turn them into mindless drones. Use stealth and sabotage at first, but when you become more powerful confront your enemies directly.") 
    else 
        if(Trig_ChooseRoles_Func007Func001Func002C()) then 
            call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "-Kill everybody, or turn them into spawns. Use stealth and infection to confront your enemies at first, and later confront them directly when you evolve.") 
        else 
            if(Trig_ChooseRoles_Func007Func001Func002Func001C()) then 
                call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "-Kill the mutant, the alien, and all of their allies. Please try to protect company property.|n-Protect local personnel.If too many are killed by you, you will be shut down.|n-You may upgrade yourself into a combat form if enough time passes.|n-If you die, you may be revived at the Arbitress.However you will be under the control of the person who revived you.")
            else 
                call DisplayTimedTextToPlayer(GetEnumPlayer(), 0, 0, 30, "-Kill the mutant, the alien, and all of their allies. Please try to protect company property.") 
            endif 
        endif 
    endif 
endfunction 

function Trig_ChooseRoles_Func008Func001C takes nothing returns boolean 
    if((udg_EngineerUsed == true)) then 
        return true 
    endif 
    if((udg_TESTING == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_ChooseRoles_Func008C takes nothing returns boolean 
    if(not Trig_ChooseRoles_Func008Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func010Func002Func001C takes nothing returns boolean 
    if((udg_ExtraStation == 2)) then 
        return true 
    endif 
    if((udg_TESTING == true)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_ChooseRoles_Func010Func002C takes nothing returns boolean 
    if(not Trig_ChooseRoles_Func010Func002Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func010C takes nothing returns boolean 
    if(not(CountPlayersInForceBJ(GetPlayersAll()) >= 11)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Func011C takes nothing returns boolean 
    if(not(CountPlayersInForceBJ(GetPlayersAll()) <= 6)) then 
        return false 
    endif 
    if(not(udg_TESTING == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ChooseRoles_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call ForceClear(udg_ChooseGroup) 
    call ForForce(GetPlayersAll(), function Trig_ChooseRoles_Func003A) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = udg_NumberofRoles 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call CreateNUnitsAtLoc(1, 'e000', Player(PLAYER_NEUTRAL_PASSIVE), udg_HoldZone, bj_UNIT_FACING) 
        call GroupAddUnitSimple(GetLastCreatedUnit(), udg_ChooseRoles_DummyGroup) 
        call SetUnitUserData(GetLastCreatedUnit(), GetForLoopIndexA()) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call ForForce(udg_ChooseGroup, function Trig_ChooseRoles_Func005A) 
    call ForForce(udg_ChooseGroup, function Trig_ChooseRoles_Func006A) 
    call ForForce(udg_ChooseGroup, function Trig_ChooseRoles_Func007A) 
    if(Trig_ChooseRoles_Func008C()) then 
        call TriggerExecute(gg_trg_ST8mInit) 
    else 
        call RemoveUnit(gg_unit_h04E_0259) 
        call DestroyTrigger(gg_trg_ST8Death) 
        call DestroyTrigger(gg_trg_ST8AttackEnd) 
        call DestroyTrigger(gg_trg_ST8Attack) 
    endif 
    call TriggerExecute(gg_trg_ST9Init) 
    if(Trig_ChooseRoles_Func010C()) then 
        call TriggerExecute(gg_trg_ST10Init) 
    else 
        if(Trig_ChooseRoles_Func010Func002C()) then 
            call TriggerExecute(gg_trg_ST10Init) 
        else 
            call TriggerExecute(gg_trg_ST10UnInit) 
        endif 
    endif 
    if(Trig_ChooseRoles_Func011C()) then 
        // No android? No arbi, its bloat (more playspace to drag games) 
        call RemoveUnit(gg_unit_h003_0018) 
        call DestroyTrigger(gg_trg_ST1Death) 
        call DestroyTrigger(gg_trg_ST1AttackEnd) 
        call DestroyTrigger(gg_trg_ST1Attack) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ChooseRoles takes nothing returns nothing 
    set gg_trg_ChooseRoles = CreateTrigger() 
    call TriggerAddAction(gg_trg_ChooseRoles, function Trig_ChooseRoles_Actions) 
endfunction 

