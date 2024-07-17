if Debug then Debug.beginFile "Initialization/MapCenterError" end
OnInit.trig("MapCenterError", function(require)
    ---@return boolean
    function Trig_MapCenterError_Func004C()
        if not (GetPlayerheroU(GetTriggerUnit()) == GetTriggerUnit()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MapCenterError_Func006C()
        if (not (udg_MapCenterErrors > 16)) then
            return false
        end
        return true
    end

    function Trig_MapCenterError_Actions()
        DisplayTextToForce(GetPlayersAll(), ("MAP ERROR: " .. GetUnitName(GetTriggerUnit())))
        SetUnitPositionLoc(GetEnteringUnit(), GetRectCenter(gg_rct_Planet))
        if (Trig_MapCenterError_Func004C()) then
            UnitAddItemByIdSwapped(FourCC('I00O'), GetEnteringUnit())
        else
        end
        udg_MapCenterErrors = (udg_MapCenterErrors + 1)
        if (Trig_MapCenterError_Func006C()) then
            DestroyTrigger(GetTriggeringTrigger())
            DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4248")
        else
        end
    end

    --===========================================================================
    gg_trg_MapCenterError = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_MapCenterError, gg_rct_MapCenter)
    TriggerAddAction(gg_trg_MapCenterError, Trig_MapCenterError_Actions)
end)
if Debug then Debug.endFile() end
