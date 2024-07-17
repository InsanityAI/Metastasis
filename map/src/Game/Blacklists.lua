if Debug then Debug.beginFile "Game/Blaclists" end
OnInit.trig("Blacklists", function(require)
    LIBRARY_Blacklists = true
    local SCOPE_PREFIX = "Blacklists_" ---@type string  --TODO:

    DESTRUCT_FILTER = nil ---@type boolexpr
    DESTRUCT_COLLISION_FILTER = nil ---@type boolexpr
    UNIT_FILTER = nil ---@type boolexpr
    UNIT_CASTER_FILTER = nil ---@type boolexpr


    ---@return boolean
    local function Destructable_Collision_Filter()
        local DestructType = GetDestructableTypeId(GetFilterDestructable()) ---@type integer
        if DestructType == FourCC('B000') or DestructType == FourCC('B001') then
            return false
        end
        if GetDestructableLife(GetFilterDestructable()) <= 0 then
            return false
        end
        return true
    end

    ---@return boolean
    local function Destructable_Filter()
        local DestructType = GetDestructableTypeId(GetFilterDestructable()) ---@type integer
        if DestructType == FourCC('DTrx') then --Transportation Platform, probably android pad, or syllus pad
            return false
        end
        if DestructType == FourCC('YT40') then --A bridge
            return false
        end
        if DestructType == FourCC('YT16') then --Another bridge
            return false
        end
        if DestructType == FourCC('YT06') then --Another bridge
            return false
        end
        if DestructType == FourCC('YT30') then --Another bridge
            return false
        end
        return true
    end

    ---@return boolean
    local function UnitTarget_CasterFilter()
        local tr     = GetTriggeringTrigger() ---@type trigger
        local t      = GetExpiredTimer() ---@type timer
        local ht     = GetHandleId(tr) ---@type integer
        local target = GetFilterUnit() ---@type unit

        if (tr == nil) then
            ht = GetHandleId(t)
        else
            ht = GetHandleId(tr)
        end
        if LoadUnitHandle(udg_hash, ht, StringHash("Caster")) == target then
            return false
        end
        return true
    end

    ---@return boolean
    local function UnitTarget_Filter()
        local target = GetFilterUnit() ---@type unit

        if GetUnitAbilityLevel(target, FourCC('Avul')) > 0 then
            return false
        end
        if not (UnitAlive(target)) then
            return false
        end
        if GetUnitPointValue(target) == 37 then
            return false
        end

        return true
    end
    --==================================================================================================
    local function init()
        DESTRUCT_FILTER           = Filter(Destructable_Filter)
        UNIT_FILTER               = Filter(UnitTarget_Filter)
        DESTRUCT_COLLISION_FILTER = And(DESTRUCT_FILTER, Filter(Destructable_Collision_Filter))
        UNIT_CASTER_FILTER        = And(UNIT_FILTER, Filter(UnitTarget_CasterFilter))
    end
    OnGlobalInit(init)
end)
if Debug then Debug.endFile() end
