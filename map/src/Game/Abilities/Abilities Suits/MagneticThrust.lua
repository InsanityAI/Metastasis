if Debug then Debug.beginFile "Game/Abilities/Suits/MagneticThrust" end
OnInit.trig("MagneticThrust", function(require)
    ---@return boolean
    function Trig_MagneticThrust_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07U'))) then
            return false
        end
        return true
    end

    --Push2 is global function pushing units, muh physicsss

    --Optimally, med regenerator + GIT Resolver (+ motion sensor)
    --Should take no damage from pushing, while also not pushing bounce'd units.
    --But whatever.
    --Honestly, if the initial thrust of magnetic suit did no damage, it would be not OP, but broken.
    function MT_PushAway()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("t")) ---@type unit

        if not (HaveSavedBoolean(LS(), GetHandleId(a), StringHash("AlreadyHit_" .. I2S(GetUnitAN(GetTriggerUnit()))))) and GetUnitAbilityLevel(GetTriggerUnit(), FourCC('Avul')) == 0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) ~= 37 then
            --If the one who cast it, do not damage, otherwise PUSHHHH
            if (LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) ~= GetTriggerUnit()) then
                UnitDamageTarget(a, GetTriggerUnit(), 100.0, true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                    WEAPON_TYPE_WHOKNOWS)
            end

            Push2(GetTriggerUnit(), 400.0, 230.0, AngleBetweenUnits(a, GetTriggerUnit()))

            --Cache already hit by an object, so the same won't do it again?
            SaveBoolean(LS(), GetHandleId(a), StringHash("AlreadyHit_" .. I2S(GetUnitAN(GetTriggerUnit()))), true)
        end
    end

    function MT_Cleanup()
        local m = GetExpiredTimer() ---@type timer
        local t = LoadTriggerHandle(LS(), GetHandleId(m), StringHash("a")) ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(m), StringHash("unit")) ---@type unit

        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
        FlushChildHashtable(LS(), GetHandleId(m))
        DestroyTimer(m)
        FlushChildHashtable(LS(), GetHandleId(a))
    end

    function ThrustPickedMetalUnit()
        local pushContactTrigger ---@type trigger
        local m ---@type timer
        local thrustableUnit = GetEnumUnit() ---@type unit

        --useless if, since the units enumerated/picked here, are already filtered!
        --However! that suit unit function is DEFINITELY interesting. As in, you can push other players holy fuck.
        --if GetUnitTypeId(thrustableUnit)==FourCC('h04L') or GetUnitTypeId(thrustableUnit)==FourCC('h03N') or GetUnitTypeId(GetFilterUnit())==FourCC('n00J') or IsUnitSuit(thrustableUnit) then
        m                    = CreateTimer()
        pushContactTrigger   = CreateTrigger()

        --90 range is the magnetic thrust
        --When the enumerated unit (metal) comes into contact with something on 90 range (melee contact), then run function push away ;)
        TriggerRegisterUnitInRange(pushContactTrigger, thrustableUnit, 90.0, nil)
        TriggerAddAction(pushContactTrigger, MT_PushAway)

        --Cache/Remember who the caster is, and which ones are the pushed objects!
        SaveUnitHandle(LS(), GetHandleId(pushContactTrigger), StringHash("t"), thrustableUnit)
        SaveUnitHandle(LS(), GetHandleId(pushContactTrigger), StringHash("caster"), udg_TempUnit4)


        SaveTriggerHandle(LS(), GetHandleId(m), StringHash("a"), pushContactTrigger)
        SaveUnitHandle(LS(), GetHandleId(m), StringHash("unit"), thrustableUnit)
        udg_TempPoint = GetUnitLoc(thrustableUnit)

        --If suited unit pushed (doesnt happen cuz of filter feelsbadman)
        if IsUnitSuit(thrustableUnit) then
            Push2(thrustableUnit, 250.0, 250.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
            TimerStart(m, 1.0, false, MT_Cleanup)
        else --magnetic object
            Push2(thrustableUnit, 800.0, 250.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
            TimerStart(m, 4.0, false, MT_Cleanup)
        end

        RemoveLocation(udg_TempPoint)

        pushContactTrigger = nil
        --endif
    end

    --return IsMetallicObject
    ---@return boolean
    function MT_Filter()
        return GetUnitTypeId(GetFilterUnit()) == FourCC('h04L') or GetUnitTypeId(GetFilterUnit()) == FourCC('h03N') or
            GetUnitTypeId(GetFilterUnit()) == FourCC('n00J') or GetUnitTypeId(GetFilterUnit()) == FourCC('h04A') or
            GetUnitTypeId(GetFilterUnit()) == FourCC('h01Z') or GetUnitTypeId(GetFilterUnit()) == FourCC('h00B') or
            GetUnitTypeId(GetFilterUnit()) == FourCC('e018') or GetUnitTypeId(GetFilterUnit()) == FourCC('h04Q') or
            GetUnitTypeId(GetFilterUnit()) == FourCC('h038') or
            GetUnitTypeId(GetFilterUnit()) ==
            FourCC('e00C') --or GetUnitTypeId(GetFilterUnit())==FourCC('h045')
    end

    function Trig_MagneticThrust_Actions()
        local magneticMasterLocation  = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        local ord                     = Condition(MT_Filter) ---@type boolexpr
        local metallicObjectGroup     = GetUnitsInRangeOfLocMatching(310.00, magneticMasterLocation, ord) ---@type group
        local tempMetallicObjectGroup = metallicObjectGroup ---@type group
        local pickedUnit ---@type unit
        local i                       = 0 ---@type integer

        udg_TempPoint2                = GetSpellTargetLoc()
        udg_TempUnit4                 = GetSpellAbilityUnit()

        --If more than 5 units to be pushed (in the metal/saw/barrel group)
        --Take metallicObjectGroup's elements and put them onto... wtf?
        --Remove, put them onto tempMetallicObjectGroup, then merge the groups, wtf?!!!!!
        --WHY IS THIS A THING? WAS THERE EVEN A BUG?
        if CountUnitsInGroup(metallicObjectGroup) > 5 then
            tempMetallicObjectGroup = CreateGroup()

            while i <= 4 do
                pickedUnit = FirstOfGroup(metallicObjectGroup)
                GroupRemoveUnit(metallicObjectGroup, pickedUnit)
                GroupAddUnit(tempMetallicObjectGroup, pickedUnit)
                i = i + 1
            end

            metallicObjectGroup = tempMetallicObjectGroup
        end

        --Pushing time!
        ForGroupBJ(metallicObjectGroup, ThrustPickedMetalUnit)

        --Clean cache
        DestroyGroup(metallicObjectGroup)
        DestroyGroup(tempMetallicObjectGroup)
        RemoveLocation(magneticMasterLocation)
    end

    --===========================================================================
    gg_trg_MagneticThrust = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MagneticThrust, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_MagneticThrust, Condition(Trig_MagneticThrust_Conditions))
    TriggerAddAction(gg_trg_MagneticThrust, Trig_MagneticThrust_Actions)
end)
if Debug then Debug.endFile() end
