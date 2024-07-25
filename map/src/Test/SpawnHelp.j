function Trig_SpawnHelp_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SpawnHelp_Actions takes nothing returns nothing 
    call DisplayTextToForce(GetPlayersAll(), "For standard wc3 units, you can simply use the unit's name. '-spawn peasant' for example will spawn a peasant. To get the code for any unit ingame, select it and enter '-spawncode'. Most codes will be of the form custom_h0XY, where X and Y are either numbers or letters. The defiler mutant for example is custom_h01V") 
endfunction 

//===========================================================================  
function InitTrig_SpawnHelp takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_SpawnHelp = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_SpawnHelp, Player(i), "-spawnhelp", true) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_SpawnHelp, Condition(function Trig_SpawnHelp_Conditions)) 
    call TriggerAddAction(gg_trg_SpawnHelp, function Trig_SpawnHelp_Actions) 
endfunction 

