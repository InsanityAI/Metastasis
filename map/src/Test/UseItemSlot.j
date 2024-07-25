function Trig_UseItemSlot_Conditions takes nothing returns boolean 
    if(not(udg_TESTING == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_UseItemSlot_Actions takes nothing returns nothing 

    //Call UnitUseItem(playerhero[first number typed], itemslot of second number typed)  
    //^Second has a unit in between, which is the target if the item needs targetting and it is itself  
    call UnitUseItem(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))], UnitItemInSlotBJ(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))], S2I(SubStringBJ(GetEventPlayerChatString(), 12, 15)))) 
    call UnitUseItemTarget(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))], UnitItemInSlotBJ(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))], S2I(SubStringBJ(GetEventPlayerChatString(), 12, 15))), udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))]) 
    //call DisplayTextToForce( GetPlayersAll(), SubStringBJ(GetEventPlayerChatString(), 10, 11))// Debug msg  
    //call DisplayTextToForce( GetPlayersAll(), SubStringBJ(GetEventPlayerChatString(), 12, 15))// Debug msg  
    
endfunction 

//===========================================================================  
function InitTrig_UseItemSlot takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_UseItemSlot = CreateTrigger() 
    
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_UseItemSlot, Player(i), "-useitem", false) 
        set i = i + 1 
    endloop 
    
    call TriggerAddCondition(gg_trg_UseItemSlot, Condition(function Trig_UseItemSlot_Conditions)) 
    call TriggerAddAction(gg_trg_UseItemSlot, function Trig_UseItemSlot_Actions) 
endfunction 

