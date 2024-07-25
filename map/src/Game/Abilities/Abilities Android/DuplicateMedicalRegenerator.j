function Trig_DuplicateMedicalRegenerator_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A0AC')) then 
        return false 
    endif 
    return true 
endfunction 


function Trig_DuplicateMedicalRegenerator_Actions takes nothing returns nothing 
    if(GetItemOfTypeFromUnitBJ(GetTriggerUnit(), 'I01N') != null) then 
        //Create medpack at caster location 
        call CreateItemLoc('I01N', GetUnitLoc(GetTriggerUnit())) 
        
        //If less than 6, aka free inventory slot, give it straight to the unit! 
        if(UnitInventoryCount(GetTriggerUnit()) < 6) then 
            call UnitAddItem(GetTriggerUnit(), GetLastCreatedItem()) 
        endif 
    else //No antibodies to duplicate, so, refund the mana 
        call SetUnitManaBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_MANA, GetTriggerUnit()) + 100.00)) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_DuplicateMedicalRegenerator takes nothing returns nothing 
    set gg_trg_DuplicateMedicalRegenerator = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_DuplicateMedicalRegenerator, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_DuplicateMedicalRegenerator, Condition(function Trig_DuplicateMedicalRegenerator_Conditions)) 
    call TriggerAddAction(gg_trg_DuplicateMedicalRegenerator, function Trig_DuplicateMedicalRegenerator_Actions) 
endfunction 

