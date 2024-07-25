function Trig_SpawnCodeGet_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function DisplaySpawnCode takes nothing returns nothing 
    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Spawn code " + UnitId2String(GetUnitTypeId(GetEnumUnit()))) 
endfunction 

function Trig_SpawnCodeGet_Actions takes nothing returns nothing 
    local group g = GetUnitsSelectedAll(GetTriggerPlayer()) 
    call ForGroup(g, function DisplaySpawnCode) 
    call DestroyGroup(g) 
endfunction 

//===========================================================================  
function InitTrig_SpawnCodeGet takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_SpawnCodeGet = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_SpawnCodeGet, Player(i), "-spawncode", true) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_SpawnCodeGet, Condition(function Trig_SpawnCodeGet_Conditions)) 
    call TriggerAddAction(gg_trg_SpawnCodeGet, function Trig_SpawnCodeGet_Actions) 
endfunction 

