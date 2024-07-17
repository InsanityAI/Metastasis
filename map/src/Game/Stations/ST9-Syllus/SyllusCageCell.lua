if Debug then Debug.beginFile "Game/Stations/ST9/SyllusCageCell" end
OnInit.trig("SyllusCageCell", function(require)
    ---@return boolean
    function Trig_SyllusCageCell_Func002Func002Func001Func002Func002Func002C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02Y'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func002Func002Func001Func002Func002C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02X'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func002Func002Func001Func002C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02W'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func002Func002Func001C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func002Func002C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02U'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func002C()
        if (not (GetUnitTypeId(GetTrainedUnit()) == FourCC('e02T'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func004Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('h04Q'))) then
            return false
        end
        if not (LoadInteger(LS(), GetHandleId(GetEnumUnit()), StringHash("Cage_Weight")) <= 2) then
            return false
        end
        if (not (IsUnitHiddenBJ(GetEnumUnit()) == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_SyllusCageCell_Func004A()
        if (Trig_SyllusCageCell_Func004Func001C()) then
            udg_TempBool = true
            udg_TempUnit2 = GetEnumUnit()
        else
        end
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func005C()
        if (not (udg_TempBool == false)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func007Func001C()
        if (not (GetUnitPointValue(GetEnumUnit()) ~= 37)) then
            return false
        end
        return true
    end

    function Trig_SyllusCageCell_Func007A()
        if (Trig_SyllusCageCell_Func007Func001C()) then
            udg_TempBool = true
            udg_TempUnit = GetEnumUnit()
        else
        end
    end

    ---@return boolean
    function Trig_SyllusCageCell_Func008C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    function Trig_SyllusCageCell_Actions()
        if (Trig_SyllusCageCell_Func002C()) then
            udg_TempRect = gg_rct_Cage1
        else
            if (Trig_SyllusCageCell_Func002Func002C()) then
                udg_TempRect = gg_rct_Cage2
            else
                if (Trig_SyllusCageCell_Func002Func002Func001C()) then
                    udg_TempRect = gg_rct_Cage3
                else
                    if (Trig_SyllusCageCell_Func002Func002Func001Func002C()) then
                        udg_TempRect = gg_rct_Cage4
                    else
                        if (Trig_SyllusCageCell_Func002Func002Func001Func002Func002C()) then
                            udg_TempRect = gg_rct_Cage5
                        else
                            if (Trig_SyllusCageCell_Func002Func002Func001Func002Func002Func002C()) then
                                udg_TempRect = gg_rct_Cage6
                            else
                                return
                            end
                        end
                    end
                end
            end
        end
        udg_TempBool = false
        ForGroupBJ(GetUnitsInRectAll(gg_rct_Cage_Transport), Trig_SyllusCageCell_Func004A)
        if (Trig_SyllusCageCell_Func005C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0,
                "|cffffcc00Error: Unable to find a non-full cage on the transportation platform.|r")
            return
        else
        end
        udg_TempBool = false
        ForGroupBJ(GetUnitsInRectAll(udg_TempRect), Trig_SyllusCageCell_Func007A)
        if (Trig_SyllusCageCell_Func008C()) then
            udg_TempPoint = GetUnitLoc(udg_TempUnit)
            ShowUnitHide(udg_TempUnit)
            PauseUnitBJ(true, udg_TempUnit)
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
            SFXThreadClean()
            GroupAddUnit(LoadGroupHandle(LS(), GetHandleId(udg_TempUnit2), StringHash("CageGroup")), udg_TempUnit)
            SaveInteger(LS(), GetHandleId(udg_TempUnit2), StringHash("Cage_Weight"),
                LoadInteger(LS(), GetHandleId(udg_TempUnit2), StringHash("Cage_Weight")) + 1)
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cff00FF00Transfer successful!|r")
            UnitShareVisionBJ(true, udg_TempUnit2, GetOwningPlayer(udg_TempUnit))
            RemoveLocation(udg_TempPoint)
            udg_TempPoint = GetUnitLoc(udg_TempUnit2)
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
            SFXThreadClean()
            RemoveLocation(udg_TempPoint)
        else
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0,
                "|cffffcc00Error: Unable to find subject in requested cell.|r")
        end
    end

    --===========================================================================
    gg_trg_SyllusCageCell = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SyllusCageCell, EVENT_PLAYER_UNIT_TRAIN_FINISH)
    TriggerAddAction(gg_trg_SyllusCageCell, Trig_SyllusCageCell_Actions)
end)
if Debug then Debug.endFile() end
