library Blacklists initializer init 
    globals 
        boolexpr DESTRUCT_FILTER 
        boolexpr DESTRUCT_COLLISION_FILTER 
        boolexpr UNIT_FILTER 
        boolexpr UNIT_CASTER_FILTER 
    endglobals 
    
    private function Destructable_Collision_Filter takes nothing returns boolean 
        local integer DestructType = GetDestructableTypeId(GetFilterDestructable()) 
        if DestructType == 'B000' or DestructType == 'B001' then 
            return false 
        endif 
        if GetDestructableLife(GetFilterDestructable()) <= 0 then 
            return false 
        endif 
        return true 
    endfunction 
    
    private function Destructable_Filter takes nothing returns boolean 
        local integer DestructType = GetDestructableTypeId(GetFilterDestructable()) 
        if DestructType == 'DTrx' then //Transportation Platform, probably android pad, or syllus pad 
            return false 
        endif 
        if DestructType == 'YT40' then //A bridge 
            return false 
        endif 
        if DestructType == 'YT16' then //Another bridge 
            return false 
        endif 
        if DestructType == 'YT06' then //Another bridge 
            return false 
        endif 
        if DestructType == 'YT30' then //Another bridge 
            return false 
        endif 
        return true 
    endfunction 
    
    private function UnitTarget_CasterFilter takes nothing returns boolean 
        local trigger tr = GetTriggeringTrigger() 
        local timer t = GetExpiredTimer() 
        local integer ht = GetHandleId(tr) 
        local unit target = GetFilterUnit() 
        
        if(tr == null) then 
            set ht = GetHandleId(t) 
        else 
            set ht = GetHandleId(tr) 
        endif 
        if LoadUnitHandle(udg_hash, ht, StringHash("Caster")) == target then 
            return false 
        endif 
        return true 
    endfunction 
    
    private function UnitTarget_Filter takes nothing returns boolean 
        local unit target = GetFilterUnit() 
        
        if GetUnitAbilityLevel(target, 'Avul') > 0 then 
            return false 
        endif 
        if not(UnitAlive(target)) then 
            return false 
        endif 
        if GetUnitPointValue(target) == 37 then 
            return false 
        endif 

        return true 
    endfunction 
    //================================================================================================== 
    private function init takes nothing returns nothing 
        set DESTRUCT_FILTER = Filter(function Destructable_Filter) 
        set UNIT_FILTER = Filter(function UnitTarget_Filter) 
        set DESTRUCT_COLLISION_FILTER = And(DESTRUCT_FILTER, Filter(function Destructable_Collision_Filter)) 
        set UNIT_CASTER_FILTER = And(UNIT_FILTER, Filter(function UnitTarget_CasterFilter)) 
    endfunction 
endlibrary