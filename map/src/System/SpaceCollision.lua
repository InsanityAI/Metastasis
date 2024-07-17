if Debug then Debug.beginFile "System/SpaceCollisionSys/SpaceCollision" end
OnInit.map("SpaceCollision", function(require)
    ---@return boolean
    function Trig_SpaceCollision_Func002Func004Func002Func002C()
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h02P'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SpaceCollision_Func002Func004Func002C()
        if (not (GetEnumUnit() ~= udg_TempUnit)) then
            return false
        end
        if (not (GetEnumUnit() ~= gg_unit_h01A_0197)) then
            return false
        end
        if (not (GetUnitPointValue(GetEnumUnit()) ~= 37)) then
            return false
        end
        if not (not (IsUnitStation(GetEnumUnit()) and udg_TempUnit == gg_unit_h00X_0049)) then
            return false
        end
        return true
    end

    function Trig_SpaceCollision_Func002Func004A()
        local r ---@type integer
        if (Trig_SpaceCollision_Func002Func004Func002C()) then
            -- The above condition prevents the Swagger from pushing stations.
            if (Trig_SpaceCollision_Func002Func004Func002Func002C()) then
                udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
                Push(GetEnumUnit(), 30.0, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
                RemoveLocation(udg_TempPoint2)
            else
                r = LoadInteger(LS(), GetHandleId(GetEnumUnit()), StringHash("PushTolerance")) + 1
                SaveInteger(LS(), GetHandleId(GetEnumUnit()), StringHash("PushTolerance"), r)
                udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
                Push(GetEnumUnit(), 30.0 / r, 10.0, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
                RemoveLocation(udg_TempPoint2)
            end
        else
        end
    end

    function Trig_SpaceCollision_Func002A()
        udg_TempUnit = GetEnumUnit()
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)],
            udg_TempPoint)
        ForGroupBJ(udg_TempUnitGroup, Trig_SpaceCollision_Func002Func004A)
        RemoveLocation(udg_TempPoint)
        DestroyGroup(udg_TempUnitGroup)
    end

    function Trig_SpaceCollision_Actions()
        ForGroupBJ(udg_SpaceObject_CollideGroup, Trig_SpaceCollision_Func002A)
    end

    --===========================================================================
    gg_trg_SpaceCollision = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_SpaceCollision, 0.25)
    TriggerAddAction(gg_trg_SpaceCollision, Trig_SpaceCollision_Actions)
end)
if Debug then Debug.endFile() end
