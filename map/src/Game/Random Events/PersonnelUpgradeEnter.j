function Trig_PersonnelUpgradeEnter_Conditions takes nothing returns boolean 
    if(not(udg_Personnel_HasUpgrade[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PersonnelUpgradeEnter_Func003C takes nothing returns boolean 
    if(not(SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 2, 2) != "2")) then 
        return false 
    endif 
    if(not(udg_TempInt != 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PersonnelUpgradeEnter_Actions takes nothing returns nothing 
    if(Trig_PersonnelUpgradeEnter_Func003C()) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffffcc00We're sorry, but we don't recognize you in our databanks.|r") 
        return 
    else 
    endif 
    call DialogDisplayBJ(true, udg_PersonnelUpgradeDialog, GetOwningPlayer(GetTriggerUnit())) 
    set udg_Personnel_HasUpgrade[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = true 
endfunction 

//=========================================================================== 
function InitTrig_PersonnelUpgradeEnter takes nothing returns nothing 
    set gg_trg_PersonnelUpgradeEnter = CreateTrigger() 
    call DisableTrigger(gg_trg_PersonnelUpgradeEnter) 
    call TriggerRegisterEnterRectSimple(gg_trg_PersonnelUpgradeEnter, gg_rct_PersonnelUpgrade) 
    call TriggerAddCondition(gg_trg_PersonnelUpgradeEnter, Condition(function Trig_PersonnelUpgradeEnter_Conditions)) 
    call TriggerAddAction(gg_trg_PersonnelUpgradeEnter, function Trig_PersonnelUpgradeEnter_Actions) 
endfunction 

