if Debug then Debug.beginFile "Game/Abilities/Items/RubbleClearingDevice" end
OnInit.trig("RubbleClearingDevice", function(require)
    ---@return boolean
    function Rubble_Clearing_Device_Conditions()
        return GetSpellAbilityId() == FourCC('A08E')
    end

    function RCD_Damage2()
        local t = GetExpiredTimer() ---@type timer
        local a = LoadDestructableHandle(LS(), GetHandleId(t), StringHash("d")) ---@type destructable
        local b = LoadUnitHandle(LS(), GetHandleId(t), StringHash("u")) ---@type unit
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTimer(t)
        UnitDamageTarget(b, a, 750, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    end

    function RCD_Damage()
        local t = CreateTimer() ---@type timer
        SaveDestructableHandle(LS(), GetHandleId(t), StringHash("d"), GetEnumDestructable())
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("u"), GetSpellAbilityUnit())
        TimerStart(t, udg_TempReal * GetRandomReal(0.8, 1.2), false, RCD_Damage2)
    end

    function Rubble_Clearing_Device_Actions()
        local a      = GetSpellTargetLoc() ---@type location
        local b      = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        udg_TempReal = DistanceBetweenPoints(a, b) / 700.0
        EnumDestructablesInCircleBJ(100.00, a, RCD_Damage)
        RemoveLocation(a)
        RemoveLocation(b)
    end

    --===========================================================================
    gg_trg_Rubble_Clearing_Device = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Rubble_Clearing_Device, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Rubble_Clearing_Device, Condition(Rubble_Clearing_Device_Conditions))
    TriggerAddAction(gg_trg_Rubble_Clearing_Device, Rubble_Clearing_Device_Actions)
end)
if Debug then Debug.endFile() end
