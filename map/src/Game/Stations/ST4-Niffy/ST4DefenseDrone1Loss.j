function Trig_ST4DefenseDrone1Loss_Conditions takes nothing returns boolean 
    if(not(GetUnitPointValue(GetTriggerUnit()) != 37)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST4DefenseDrone1Loss_Func003C takes nothing returns boolean 
    if(not(GetOwningPlayer(gg_unit_h00B_0032) == GetOwningPlayer(GetTriggerUnit()))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST4DefenseDrone1Loss_Actions takes nothing returns nothing 
    if(Trig_ST4DefenseDrone1Loss_Func003C()) then 
        call SetUnitOwner(gg_unit_h00B_0032, Player(PLAYER_NEUTRAL_PASSIVE), false) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ST4DefenseDrone1Loss takes nothing returns nothing 
    set gg_trg_ST4DefenseDrone1Loss = CreateTrigger() 
    call TriggerRegisterLeaveRectSimple(gg_trg_ST4DefenseDrone1Loss, gg_rct_DD1) 
    call TriggerAddCondition(gg_trg_ST4DefenseDrone1Loss, Condition(function Trig_ST4DefenseDrone1Loss_Conditions)) 
    call TriggerAddAction(gg_trg_ST4DefenseDrone1Loss, function Trig_ST4DefenseDrone1Loss_Actions) 
endfunction 

