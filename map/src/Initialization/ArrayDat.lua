if Debug then Debug.beginFile "Initialization/ArrayDat" end
OnInit.trig("ArrayDat", function(require)
    ---@param h unit
    function NewUnitRegister(h)
        if GetUnitUserData(h) == 0 then
            --Should be 8192 and 1, but I'm not going to change it while it's working.
            udg_Array_On = udg_Array_On + 1
            if udg_Array_On >= 8000 then
                udg_Array_On = 100
            end
            if udg_UnitAssignation[udg_Array_On] ~= nil then
                while not (udg_UnitAssignation[udg_Array_On] == nil or udg_UnitAssignation[udg_Array_On] == udg_TheNullUnit) do
                    udg_Array_On = udg_Array_On + 1
                end
            end
            udg_UnitAssignation[udg_Array_On] = h
            SetUnitUserData(h, udg_Array_On)
        end
    end

    --Faster to type than GetUnitUserData() and easier to remember.
    ---@param h unit
    ---@return integer
    function GetUnitAN(h)
        return GetUnitUserData(h)
    end

    --When a unit enters the map, this will catch it and assign a number to it.
    --The bad part is, you shouldn't reference a unit immediately after creating it.
    --If you must, call NewUnitRegister(GetLastCreatedUnit()). A built in safety guard will prevent this function from overwriting.
    function Redirect_RegisterUnit()
        if GetUnitUserData(GetTriggerUnit()) ~= 0 then
            return
        end
        NewUnitRegister(GetTriggerUnit())
    end

    --==============================
    --Give pre-placed units a number.
    --You should still call a new register before accessing if you immediately want it during map init.
    function PrePlacedUnits()
        NewUnitRegister(GetEnumUnit())
    end

    --Fun fun fun, make sure to call this somewhere.
    OnInit.main(function()
        local x = GetUnitsInRectAll(GetPlayableMapRect()) ---@type group
        local v = CreateTrigger() ---@type trigger
        TriggerRegisterEnterRectSimple(v, GetPlayableMapRect())
        TriggerAddAction(v, Redirect_RegisterUnit)
        ForGroup(x, PrePlacedUnits)
        DestroyGroup(x)
    end)
end)
if Debug then Debug.endFile() end
