if Debug then Debug.beginFile "Game/Stations/ST9/SyllusCageOpen" end
OnInit.map("SyllusCageOpen", function(require)
    ---@return boolean
    function Trig_SyllusCageOpen_Func002Func001Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02R'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func002Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func002Func001Func001Func001C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02P'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func002Func001Func001C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02O'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func002Func001C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02N'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func002C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02M'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func003Func001Func002C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func003Func001C()
        if (not Trig_SyllusCageOpen_Func003Func001Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func003Func005Func001C()
        if (not (udg_TempBool == true)) then
            return false
        end
        if (not (udg_TempBool2 == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageOpen_Func003Func005C()
        if (not Trig_SyllusCageOpen_Func003Func005Func001C()) then
            return false
        end
        return true
    end

    function Trig_SyllusCageOpen_Func003A()
        if (Trig_SyllusCageOpen_Func003Func001C()) then
        else
            return
        end
        udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1"))
        udg_TempBool = IsTriggerEnabled(udg_TempTrigger)
        udg_TempBool2 = udg_TempTrigger == nil
        if (Trig_SyllusCageOpen_Func003Func005C()) then
            DisableTrigger(udg_TempTrigger)
            udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2"))
            udg_TempDoorHack = true
            TriggerExecute(udg_TempTrigger)
            udg_TempDoorHack = false
            DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")),
                999999, true)
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 11.00, "|cffffcc00Cell locked.|r")
        else
            EnableTrigger(udg_TempTrigger)
            TriggerExecute(udg_TempTrigger)
            KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")))
            DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 11.00, "|cffffcc00Cell unlocked.|r")
        end
    end

    function Trig_SyllusCageOpen_Actions()
        if (Trig_SyllusCageOpen_Func002C()) then
            udg_TempPoint = GetRectCenter(gg_rct_Cage1)
        else
            if (Trig_SyllusCageOpen_Func002Func001C()) then
                udg_TempPoint = GetRectCenter(gg_rct_Cage2)
                KillDestructable(gg_dest_YTab_4373)
                KillDestructable(gg_dest_YTab_4372)
                KillDestructable(gg_dest_YTab_4371)
                KillDestructable(gg_dest_YTab_4370)
                KillDestructable(gg_dest_YTab_4369)
            else
                if (Trig_SyllusCageOpen_Func002Func001Func001C()) then
                    udg_TempPoint = GetRectCenter(gg_rct_Cage3)
                else
                    if (Trig_SyllusCageOpen_Func002Func001Func001Func001C()) then
                        udg_TempPoint = GetRectCenter(gg_rct_Cage4)
                    else
                        if (Trig_SyllusCageOpen_Func002Func001Func001Func001Func001C()) then
                            udg_TempPoint = GetRectCenter(gg_rct_Cage5)
                        else
                            if (Trig_SyllusCageOpen_Func002Func001Func001Func001Func001Func001C()) then
                                udg_TempPoint = GetRectCenter(gg_rct_Cage6)
                            else
                                return
                            end
                        end
                    end
                end
            end
        end
        EnumDestructablesInCircleBJ(900.00, udg_TempPoint, Trig_SyllusCageOpen_Func003A)
    end

    --===========================================================================
    gg_trg_SyllusCageOpen = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SyllusCageOpen, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddAction(gg_trg_SyllusCageOpen, Trig_SyllusCageOpen_Actions)
end)
if Debug then Debug.endFile() end
