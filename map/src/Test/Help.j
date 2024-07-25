function Trig_Help_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Help_Actions takes nothing returns nothing 
    call DisplayTextToForce(GetPlayersAll(), "TESTING COMMANDS:\n-help\n-EP ### (grants EP to alien/mutant/android)\n-nowin (disables win conditions\n-mine (takes control of selected units)\n-forcerandom ## (forces random event # to occur, type -randomevents for a list)\n-spawn #### (spawns unit based on unit code; for most units this is custom_####, type -spawnhelp for further info)\n-forceapocalypse (forces apocalypse event; 1 for USI fleet and 2 for black hole)\n-playerhero (makes selected unit playerhero; you lose if it dies)\n-test_abilities (grants ultrablink ability to selected units)\n-hostile (selected unit becomes hostile)\n-vision") 
endfunction 

//=========================================================================== 
function InitTrig_Help takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_Help = CreateTrigger() 
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_Help, Player(i), "-help", true) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_Help, Condition(function Trig_Help_Conditions)) 
    call TriggerAddAction(gg_trg_Help, function Trig_Help_Actions) 
endfunction 

