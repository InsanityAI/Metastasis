if Debug then Debug.beginFile "System/Doors/DoorInit2" end
OnInit.map("DoorInit2", function(require)
    ---@return boolean
    function Trig_DoorInit2_Func003Func001Func006C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_DoorInit2_Func003Func001C()
        if (not Trig_DoorInit2_Func003Func001Func006C()) then
            return false
        end
        return true
    end

    function Trig_DoorInit2_Func003A()
        if (Trig_DoorInit2_Func003Func001C()) then
            udg_TempDestruct = GetEnumDestructable()
            udg_TempPoint = GetDestructableLoc(GetEnumDestructable())
            udg_TempRect = Rect((GetLocationX(udg_TempPoint) - 280.00), (GetLocationY(udg_TempPoint) - 280.00),
                (GetLocationX(udg_TempPoint) + 280.00), (GetLocationY(udg_TempPoint) + 280.00))
            RegisterSecurityDoor(udg_TempDestruct, udg_TempRect, 0)
            RemoveLocation(udg_TempPoint)
        else
        end
    end

    function Trig_DoorInit2_Actions()
        DisableTrigger(GetTriggeringTrigger())
        EnumDestructablesInRectAll(GetPlayableMapRect(), Trig_DoorInit2_Func003A)
        udg_TempDestruct = gg_dest_B000_0656
        DoorRegisterClearance(udg_TempDestruct, FourCC('I00J'))
        udg_TempDestruct = gg_dest_B000_1445
        DoorRegisterClearance(udg_TempDestruct, FourCC('I00J'))
        udg_TempDestruct = gg_dest_B000_1811
        DoorRegisterClearance(udg_TempDestruct, FourCC('I00J'))
    end

    gg_trg_DoorInit2 = CreateTrigger()
    TriggerAddAction(gg_trg_DoorInit2, Trig_DoorInit2_Actions)
end)
if Debug then Debug.endFile() end
