function Trig_DuplicateMedPack_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A0AA')) then 
        return false 
    endif 
    return true 
endfunction 


function Trig_DuplicateMedPack_Actions takes nothing returns nothing 
    if(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I002') != null) then 
        //Create medpack at caster location 
        call CreateItemLoc('I002', GetUnitLoc(GetTriggerUnit())) 
        
        //If less than 6, aka free inventory slot, give it straight to the unit! 
        if(UnitInventoryCount(GetTriggerUnit()) < 6) then 
            call UnitAddItem(GetTriggerUnit(), GetLastCreatedItem()) 
        endif 
    else //No medpack to duplicate, so, refund the mana 
        call SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) + 50.00)) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_DuplicateMedPack takes nothing returns nothing 
    set gg_trg_DuplicateMedPack = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_DuplicateMedPack, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_DuplicateMedPack, Condition(function Trig_DuplicateMedPack_Conditions)) 
    call TriggerAddAction(gg_trg_DuplicateMedPack, function Trig_DuplicateMedPack_Actions) 
endfunction 

