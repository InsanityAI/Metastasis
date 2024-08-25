library PlanetarySweep initializer init requires SurveillanceSweep 
    globals 
        private constant integer ITEM_ID = 'I00T' 

        private trigger sellingTrigger 
    endglobals 

    private function sweepAction takes nothing returns boolean 
        local unit triggerUnit 
        local MetaPlayer metaPlayer 

        if GetItemTypeId(GetManipulatedItem()) != ITEM_ID then 
            return false 
        endif 
        call RemoveItem(GetManipulatedItem()) 
        
        set triggerUnit = GetBuyingUnit() 
        set metaPlayer = MetaPlayer_GetFromOwner(triggerUnit) 
        
        call DisplayTextToPlayer(GetOwningPlayer(GetBuyingUnit()), 0, 0, "|cffffcc00Planetary sweep complete.|r") 
        call Sweep(metaPlayer, GetUnitX(triggerUnit), GetUnitY(triggerUnit)) 

        set triggerUnit = null 
        return true 
    endfunction 

    private function init takes nothing returns nothing 
        set sellingTrigger = CreateTrigger() 
        call TriggerRegisterAnyUnitEventBJ(abilityTrigger, EVENT_PLAYER_UNIT_SELL_ITEM) 
        call TriggerAddCondition(abilityTrigger, Condition(function sweepAction)) 
    endfunction 
endlibrary 
