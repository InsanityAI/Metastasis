function Trig_SpawnUnit_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    if(not(SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-spawn ")) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpawnUnit_Actions takes nothing returns nothing 
    set udg_TempInt = S2I(SubStringBJ(GetEventPlayerChatString(), 8, 99)) 
    set udg_TempUnitType = udg_TempInt 
    set bj_lastCreatedUnit = null 
    call CreateNUnitsAtLoc(1, String2UnitIdBJ(SubStringBJ(GetEventPlayerChatString(), 8, 999)), GetTriggerPlayer(), GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]), bj_UNIT_FACING) 
    if bj_lastCreatedUnit == null then 
        call DisplayTextToForce(GetPlayersAll(), "Spawn command NOT successful.") 
    else 
        call DisplayTextToForce(GetPlayersAll(), "Spawn command successful.") 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_SpawnUnit takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_SpawnUnit = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_SpawnUnit, Player(i), "-spawn ", false) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_SpawnUnit, Condition(function Trig_SpawnUnit_Conditions)) 
    call TriggerAddAction(gg_trg_SpawnUnit, function Trig_SpawnUnit_Actions) 
endfunction 

