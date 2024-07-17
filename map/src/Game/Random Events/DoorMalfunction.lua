if Debug then Debug.beginFile "Game/RandomEvents/DoorMalfunction" end
OnInit.trig("DoorMalfunction", function(require)
    ---@return boolean
    function Trig_DoorMalfunction_Func002Func001Func001C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_DoorMalfunction_Func002Func001C()
        if (not Trig_DoorMalfunction_Func002Func001Func001C()) then
            return false
        end
        return true
    end

    function Trig_DoorMalfunction_Func002A()
        if (Trig_DoorMalfunction_Func002Func001C()) then
            DoorMalfunction(GetEnumDestructable())
        else
        end
    end

    function Trig_DoorMalfunction_Func006002()
        RemoveUnit(GetEnumUnit())
    end

    ---@return boolean
    function Trig_DoorMalfunction_Func007Func001Func001C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_DoorMalfunction_Func007Func001C()
        if (not Trig_DoorMalfunction_Func007Func001Func001C()) then
            return false
        end
        return true
    end

    function Trig_DoorMalfunction_Func007A()
        if (Trig_DoorMalfunction_Func007Func001C()) then
            DoorMalfunction_End(GetEnumDestructable())
        else
        end
    end

    function Trig_DoorMalfunction_Actions()
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4340")
        EnumDestructablesInRectAll(GetEntireMapRect(), Trig_DoorMalfunction_Func002A)
        TriggerSleepAction(GetRandomReal(300.00, 600.00))
        TriggerExecute(gg_trg_DoorInit2)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4341")
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('e039')), Trig_DoorMalfunction_Func006002)
        EnumDestructablesInRectAll(GetEntireMapRect(), Trig_DoorMalfunction_Func007A)
    end

    --===========================================================================
    gg_trg_DoorMalfunction = CreateTrigger()
    DisableTrigger(gg_trg_DoorMalfunction)
    TriggerAddAction(gg_trg_DoorMalfunction, Trig_DoorMalfunction_Actions)
end)
if Debug then Debug.endFile() end
