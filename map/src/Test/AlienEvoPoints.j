function Trig_AlienEvoPoints_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_AlienEvoPoints_Actions takes nothing returns nothing 
    set udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 9999.00) 
    set udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 9999.00) 
    set udg_UpgradePointsAndroid = (udg_UpgradePointsAndroid + 9999.00) 
endfunction 

//=========================================================================== 
function InitTrig_AlienEvoPoints takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_AlienEvoPoints = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_AlienEvoPoints, Player(i), "-EP", true) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_AlienEvoPoints, Condition(function Trig_AlienEvoPoints_Conditions)) 
    call TriggerAddAction(gg_trg_AlienEvoPoints, function Trig_AlienEvoPoints_Actions) 
endfunction 

